-- Misc
vim.opt.fileencoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse = "a"

-- Colorscheme
vim.g.tokyonight_style = "night"
vim.cmd "colorscheme tokyonight"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"

-- Appearance
vim.opt.showtabline = 2
vim.opt.cursorline = true
vim.opt.cmdheight = 2
vim.opt.pumheight = 10
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Scrolling
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.showmode = false

-- Completion
vim.opt.shortmess:append "c"
vim.opt.completeopt = { "menuone", "noselect" }

-- Temporary files
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Delays
vim.opt.updatetime = 400
vim.opt.timeoutlen = 800

