vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.cmdheight = 0
vim.opt.scrolloff = 4
vim.opt.breakindent = true
vim.opt.formatoptions:remove("t")
vim.opt.linebreak = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.incsearch = true
vim.opt.fillchars = { eob = " " }
vim.opt.laststatus = 3
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.wo.relativenumber = true
vim.cmd([[
  augroup noAutoComment
    autocmd!
    autocmd FileType * setlocal formatoptions-=cro
  augroup END
]])
