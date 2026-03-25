-- auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath('data')

if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
	vim.cmd('!curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.o.runtimepath = vim.o.runtimepath
	vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end
-- end autoinstall

local vim = vim
local Plug = vim.fn['plug#']

vim.loader.enable()

vim.call('plug#begin')

-- visual core
Plug('luisiacc/gruvbox-baby', { ['as'] = 'gruvbox' }) -- theme
Plug('nvim-tree/nvim-web-devicons') -- icons
Plug('lewis6991/gitsigns.nvim') -- git status

-- system
Plug('stevearc/oil.nvim') -- file browser
Plug('numToStr/FTerm.nvim') -- floating terminal
Plug('ibhagwan/fzf-lua') -- fuzzy search
Plug('neovim/nvim-lspconfig') -- LSP
Plug('nvim-lua/plenary.nvim') -- library for obsidian
Plug('epwalsh/obsidian.nvim') -- obsidian features
Plug('epwalsh/pomo.nvim') -- pomodoro timer

-- syntax/rendering
Plug('MeanderingProgrammer/render-markdown.nvim') -- markdown
Plug('nvim-treesitter/nvim-treesitter') -- context aware syntax highlighting

-- visual tweaks
Plug('norcalli/nvim-colorizer.lua') -- colorize hex codes
Plug('sphamba/smear-cursor.nvim') -- pretty cursor
Plug('utilyre/sentiment.nvim') -- highlight bracket pairs
Plug('m-demare/hlargs.nvim') -- highlight func args in body
Plug('lukas-reineke/indent-blankline.nvim', { ['as'] = 'ibl' }) -- show indentation guides

-- editing tweaks
Plug('nvim-mini/mini.ai') -- around/inside
Plug('nvim-mini/mini.surround') -- surround with brackets
Plug('aaronik/treewalker.nvim') -- treesitter movement
Plug('nvim-treesitter/nvim-treesitter-textobjects') -- treesitter editing
Plug('Wansmer/treesj') -- argument splitting/joining
Plug('windwp/nvim-ts-autotag') -- html tag closing
Plug('numToStr/Comment.nvim') -- comment toggles
Plug('monaqa/dial.nvim') -- toggles/incr/decr

-- ui
-- Plug('nvim-treesitter/nvim-treesitter-context') -- context bar at top
Plug('SmiteshP/nvim-navic')
Plug('folke/which-key.nvim') -- keymap popup
Plug('romgrk/barbar.nvim') -- tabs
Plug('nvim-lualine/lualine.nvim') -- statusline
Plug('goolord/alpha-nvim') --pretty startup

vim.call('plug#end')

require("config")
require("lsp")
require("plugins")

vim.g.gruvbox_baby_comment_style = "NONE"
vim.g.gruvbox_baby_keyword_style = "NONE"
vim.g.gruvbox_baby_transparent_mode = true
vim.g.gruvbox_baby_use_original_palette = true

vim.cmd('silent! colorscheme gruvbox-baby')
