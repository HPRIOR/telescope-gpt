# Telescope GPT 

Telescope-GPT is an extension for [telescope](https://github.com/nvim-telescope/telescope.nvim) which integrates the [ChatGPT plugin](https://github.com/jackMort/ChatGPT.nvim).


## Demo

![output](https://github.com/HPRIOR/telescope-gpt/assets/56833147/843ffdeb-14c8-4e37-afdd-828af630d831)

## Installation
Using [LazyNvim](https://github.com/folke/lazy.nvim):

```lua
return {
    {
        "HPRIOR/telescope-gpt",
        dependencies = { "nvim-telescope/telescope.nvim", "jackMort/ChatGPT.nvim" }
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        version = false, 
        opts = {
            extensions = {
                gpt = {
                    title = "Gpt Actions",
                    commands = {
                        "add_tests",
                        "chat",
                        "docstring",
                        "explain_code",
                        "fix_bugs",
                        "grammar_correction",
                        "interactive",
                        "optimize_code",
                        "summarize",
                        "translate"
                    },
                    theme = require("telescope.themes").get_dropdown{}
                }
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require('telescope').load_extension('gpt')
        end,
    },
}

```

## Config

The default configurations are given in the example above under `opts->extensions->gpt`

By default, the commands given correspond to the defualt `ChatGptRun` commands in `ChatGPT.nvim`.

You can create custom `ChatGPTRun` commands by following `ChatGPT.nvim`'s [readme](https://github.com/jackMort/ChatGPT.nvim#chatgptrun). Once the custom command has been created, add an entry command config to access it.

In addition to the `ChatGPTRun` commands, the default chat interface, `ChatGPT`, is available through `chat`, and `ChatGPTEditWithInstructions` via `interactive`.

The default theme can also be changed via the `theme` entry.

## Usage

Call `:Telescope gpt` to access the commands. 

Mapping `Telescope gpt` to a key in visual and normal mode will allow you to run over visual selections and entire buffers.
Telescope doesn't accept visual selections itself, so executing the command above will not work over a visual selection - e.g. `:'<,'> Telescope gpt`.
To work around this, the extension retrieves marks set by a visual selection, and then passes them to the relevant `ChatGPT.nvim` command. 

All commands with the exception `ChatGPT` will work over a visual selection. 








