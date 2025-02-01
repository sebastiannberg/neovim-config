-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load core settings
require('core.options')
require('core.keymaps')
require('core.autocommands')

-- vim: ts=2 sts=2 sw=2 et
