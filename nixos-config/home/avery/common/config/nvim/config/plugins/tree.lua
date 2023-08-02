local tree = require("nvim-tree");
local api = require('nvim-tree.api')

tree.setup({
    sort_by = "case_sensitive",
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

vim.keymap.set('n', '<C-b>', api.tree.toggle, {})
vim.keymap.set('n', '<leader>b', api.tree.focus, {})