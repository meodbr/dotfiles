local home = os.getenv("HOME")

require('telescope').load_extension("fzf")
require("telescope").load_extension('harpoon')

require("gitsigns").setup()

require("catppuccin").setup {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "macchiato",
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        beacon = true,
        treesitter = true,
        telescope = true,
        fidget = true,
        gitsigns = true,
        harpoon = true,
        markdown = true,

        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
         

        notify = false,
        mini = false,
    }
}


require("fidget").setup {
    window = {
        blend = 0,
    },
}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
