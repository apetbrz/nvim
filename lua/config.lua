-- -- keybinds -- --

-- setup --
-- leader
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- nvim helpers
vim.keymap.set("n", "<leader><leader>", "", { silent = true, desc = "Neovim Management" })
vim.keymap.set("n", "<leader><leader>r", function() end, { silent = true, desc = "Reload init.lua" })
vim.keymap.set("n", "<leader><leader>e", ":e $MYVIMRC<cr>", { silent = true, desc = "Edit init.lua" })
vim.keymap.set("n", "<leader><leader>i", ":PlugInstall<cr>", { silent = true, desc = "Run vim-plug" })
vim.keymap.set("n", "<leader><leader>c", ":PlugClean<cr>", { silent = true, desc = "Clean vim-plug" })

-- navigation --
-- treewalker movements
vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<cr>", { silent = true })
-- buffer movement/management
vim.keymap.set("n", "H", ":bprevious<cr>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "L", ":bnext<cr>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>", { silent = true, desc = "Close buffer" })
-- split screen
vim.keymap.set('n', '<leader>S', '', { silent = true, desc = "Split" })
vim.keymap.set('n', '<leader>Sv', ':vsplit<cr>:bnext<cr>', { silent = true, desc = "Split onto right" })

-- treesitter support --
require("nvim-treesitter-textobjects").setup({ select = { lookahead = true, include_surrounding_whitespace = false } })
local tssel = require("nvim-treesitter-textobjects.select")
local tsmv = require("nvim-treesitter-textobjects.move")
local tsswp = require("nvim-treesitter-textobjects.swap")
-- textobjs
vim.keymap.set({ "x", "o" }, "af", function() tssel.select_textobject("@function.outer", "textobjects") end, { desc = "function" })
vim.keymap.set({ "x", "o" }, "if", function() tssel.select_textobject("@function.inner", "textobjects") end, { desc = "inner function" })
vim.keymap.set({ "x", "o" }, "aa", function() tssel.select_textobject("@parameter.outer", "textobjects") end, { desc = "argument" })
vim.keymap.set({ "x", "o" }, "ia", function() tssel.select_textobject("@parameter.inner", "textobjects") end, { desc = "inner argument" })
vim.keymap.set({ "x", "o" }, "ac", function() tssel.select_textobject("@call.outer", "textobjects") end, { desc = "function call" })
vim.keymap.set({ "x", "o" }, "ic", function() tssel.select_textobject("@call.inner", "textobjects") end, { desc = "inner function call" })
vim.keymap.set({ "x", "o" }, "ar", function() tssel.select_textobject("@class.outer", "textobjects") end, { desc = "struct" })
vim.keymap.set({ "x", "o" }, "ir", function() tssel.select_textobject("@class.inner", "textobjects") end, { desc = "inner struct" })
vim.keymap.set({ "x", "o" }, "as", function() tssel.select_textobject("@block.outer", "textobjects") end, { desc = "scope" })
vim.keymap.set({ "x", "o" }, "is", function() tssel.select_textobject("@block.inner", "textobjects") end, { desc = "inner scope" })
-- moves
vim.keymap.set({ "n", "x", "o" }, ";", function() require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move() end)
vim.keymap.set({ "n", "x", "o" }, ",", function() require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_opposite() end)
vim.keymap.set('n', '<leader>n', '', { silent = true, desc = "Next" })
vim.keymap.set("n", "<leader>na", function() tsmv.goto_next_start("@parameter.inner", "textobjects") end, { desc = "argument" })
vim.keymap.set("n", "<leader>nf", function() tsmv.goto_next_start("@function.outer", "textobjects") end, { desc = "function" })
vim.keymap.set("n", "<leader>nb", function() tsmv.goto_next_start("@function.outer", "textobjects") end, { desc = "function body" })
vim.keymap.set("n", "<leader>nc", function() tsmv.goto_next_start("@call.outer", "textobjects") end, { desc = "function call" })
vim.keymap.set("n", "<leader>nr", function() tsmv.goto_next_start("@class.outer", "textobjects") end, { desc = "struct definition" })
vim.keymap.set("n", "<leader>ns", function() tsmv.goto_next_start("@block.inner", "textobjects") end, { desc = "scope" })
vim.keymap.set('n', '<leader>p', '', { silent = true, desc = "Previous" })
vim.keymap.set("n", "<leader>pa", function() tsmv.goto_previous_start("@parameter.inner", "textobjects") end, { desc = "argument" })
vim.keymap.set("n", "<leader>pd", function() tsmv.goto_previous_start("@function.outer", "textobjects") end, { desc = "function" })
vim.keymap.set("n", "<leader>pc", function() tsmv.goto_previous_start("@call.outer", "textobjects") end, { desc = "function call" })
vim.keymap.set("n", "<leader>pr", function() tsmv.goto_previous_start("@class.outer", "textobjects") end, { desc = "struct" })
vim.keymap.set("n", "<leader>ps", function() tsmv.goto_previous_start("@block.inner", "textobjects") end, { desc = "scope" })
-- vim.keymap.set("n", "<leader>u", function() require("treesitter-context").go_to_context(vim.v.count1) end, { desc = "Up in context" })
-- swaps
vim.keymap.set({ 'n', "v" }, '<leader>a', '', { silent = true, desc = "Swap (Treesitter)" })
vim.keymap.set({ "n", "v" }, "<leader>aa", function() tsswp.swap_next("@parameter.inner", "textobjects") end, { desc = "next argument" })
vim.keymap.set({ "n", "v" }, "<leader>aA", function() tsswp.swap_previous("@parameter.inner", "textobjects") end, { desc = "prev argument" })
vim.keymap.set({ "n", "v" }, "<A-l>", function() tsswp.swap_next("@parameter.inner", "textobjects") end, { desc = "swap next argument" })
vim.keymap.set({ "n", "v" }, "<A-h>", function() tsswp.swap_previous("@parameter.inner", "textobjects") end, { desc = "swap prev argument" })

-- find --
-- fzf and grep
vim.keymap.set("n", "<leader>f", "", { desc = "fzf" })
vim.keymap.set("n", "<leader>ff", function() require('fzf-lua').files() end, { desc = "fzf filenames" }) --search cwd
vim.keymap.set("n", "<leader>fr", function() require('fzf-lua').resume() end, { desc = "repeat last fzf" }) --last search
vim.keymap.set("n", "<leader>fh", function() require('fzf-lua').files({ cwd = '~/' }) end, { desc = "fzf ~/" }) --search home
vim.keymap.set("n", "<leader>fc", function() require('fzf-lua').files({ cwd = '~/.config' }) end, { desc = "fzf ~/.config" }) --search ~/.config
vim.keymap.set("n", "<leader>fl", function() require('fzf-lua').files({ cwd = '~/src' }) end, { desc = "fzf ~/src" }) --search ~/src
vim.keymap.set("n", "<leader>fd", function() require('fzf-lua').files({ cwd = '~/dev' }) end, { desc = "fzf ~/dev" }) --search ~/dev
vim.keymap.set("n", "<leader>fg", function() require('fzf-lua').grep() end, { desc = "ripgrep" }) --grep
vim.keymap.set("n", "<leader>fG", function() require('fzf-lua').grep_cword() end, { desc = "ripgrep word under cursor" }) --grep word under cursor

-- editing --
-- incr/decr
vim.keymap.set("n", "<C-a>", function() require("dial.map").manipulate("increment","normal") end, { silent = true })
vim.keymap.set("n", "<C-S-a>", function() require("dial.map").manipulate("decrement","normal") end, { silent = true })
vim.keymap.set("n", "g<C-a>", function() require("dial.map").manipulate("increment","gnormal") end, { silent = true })
vim.keymap.set("n", "g<C-S-a>", function() require("dial.map").manipulate("decrement","gnormal") end, { silent = true })
vim.keymap.set("v", "<C-a>", function() require("dial.map").manipulate("increment","visual") end, { silent = true })
vim.keymap.set("v", "<C-S-a>", function() require("dial.map").manipulate("decrement","visual") end, { silent = true })
vim.keymap.set("v", "g<C-a>", function() require("dial.map").manipulate("increment","gvisual") end, { silent = true })
vim.keymap.set("v", "g<C-S-a>", function() require("dial.map").manipulate("decrement","gvisual") end, { silent = true })
-- QoL
vim.keymap.set("n", "<leader>w", '<C-w>', { silent = true, desc = "Window control leader" })
vim.keymap.set("n", "<leader>/", ':nohlsearch<cr>', { silent = true, desc = "Clear search highlights" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { silent = true, desc = "Delete without yanking" })
-- move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "K", ":m .-2<CR>J", { desc = "Join upwards" })
-- treewalker swaps
vim.keymap.set("n", "<A-K>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
vim.keymap.set("n", "<A-J>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
vim.keymap.set("n", "<A-H>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
vim.keymap.set("n", "<A-L>", "<cmd>Treewalker SwapRight<cr>", { silent = true })
-- better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
-- whole file changes
vim.keymap.set("n", "<leader>F", "", { desc = "File edit" })
vim.keymap.set("n", "<leader>Fi", "gg=G''", { desc = "Re-indent entire file" })

-- external interaction --
-- oil browser
vim.keymap.set("n", "<leader>e", ":Oil --float %:p:h<cr>", { silent = true, desc = "File browser" })
-- terminal
vim.keymap.set("n", "<leader>z", function() require('FTerm').open() end, { silent = true, desc = "Open terminal" })
vim.keymap.set("t", "<esc>", function() require('FTerm').close() end, { silent = true })
-- exec current file
vim.keymap.set("n", "<leader>cc", "", { silent = true, desc = "Compiler Options" })
vim.keymap.set("n", "<leader>ccs", function() vim.w.USER_COMPILER = vim.fn.input("Enter the compiler command to store: ") end, { silent = true, desc = "Set Compiler" })
vim.keymap.set("n", "<leader>ccr", ":exe '!'w:USER_COMPILER expand('%:p')<cr>", { silent = false, desc = "Run Compiler on Current File" })
-- git
vim.keymap.set('n', '<leader>g', '', { silent = false, desc = "Git" })
vim.keymap.set('n', '<leader>gd', ':diffthis<cr>', { silent = false, desc = "Check git diff" })
vim.keymap.set('n', '<leader>gD', ':diffoff<cr>', { silent = false, desc = "Clear git diff" })

-- ui --
vim.keymap.set("n", "<leader>T", "", { desc = "Text" })
vim.keymap.set("n", "<leader>Tw", ":set wrap!<CR>", { desc = "Toggle Wrapping" })

-- obsidian --
vim.keymap.set("n", "<leader>o", "", { desc = "Obsidian" })
vim.keymap.set("n", "<leader>on", ":ObsidianNew<cr>", { desc = "New Note" })
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<cr>", { desc = "Today's Note" })
vim.keymap.set("v", "<leader>oe", ":ObsidianExtractNote<cr>", { desc = "Extract selection to a note" })
vim.keymap.set("n", "<leader>ow", ":ObsidianWorkspaces<cr>", { desc = "Workspaces" })

vim.keymap.set("n", "<leader>tc", function() require("obsidian").util.toggle_checkbox() end, { desc = "Toggle Checkbox" })

-- pomo --
vim.keymap.set("n", "<leader>t", "", { desc = "Toggle/Pomodoro Timer" })
vim.keymap.set("n", "<leader>tp", ":TimerSession pomodoro<cr>", { desc = "Start Pomodoro Session (25-5-25-5-25-15)" })
vim.keymap.set("n", "<leader>tt", ":TimerStart", { desc = "Start Timer" })
vim.keymap.set("n", "<leader>ts", ":TimerStop<cr>", { desc = "Stop Timer" })

-- -- nvim cfg -- --

-- core
vim.opt.title = true --automatic window titlebar
vim.opt.history = 100 --command line history
vim.opt.swapfile = false --swap just gets in the way, usually
vim.opt.backup = false --junk files
vim.opt.undofile = true --undos are saved to file
vim.opt.autoread = false -- reload if changed externally
vim.opt.mouse = "a" --enable mouse
vim.opt.clipboard = "unnamedplus" --system clipboard integration
vim.opt.ttyfast = true --faster scrolling
vim.opt.smoothscroll = true --nice
vim.opt.termguicolors = true --need colors
vim.opt.lazyredraw = true --dont bother drawing during macros
vim.opt.diffopt:append("linematch:60") --diff 60 lines

-- framing and highlights
vim.opt.number = true --numbering lines
vim.opt.signcolumn = "yes" --icon column
vim.opt.numberwidth = 4 --line number bar width
vim.opt.cursorline = true --highlight line
vim.opt.laststatus = 3 --status line always at bottom with windows open
vim.opt.splitkeep = 'screen' --keep text on the same lines when splitting

-- command line
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.so", "*.obj", "*.pyc", "*.class", "*.jar" })

-- text ui
vim.opt.list = true --show tab characters
vim.opt.wrap = false --toggleable
vim.opt.linebreak = true --wrap on spaces
vim.opt.conceallevel = 2 --markdown conceal
vim.opt.concealcursor = "nc" --^not in insert/visual modes
vim.opt.scrolloff = 8 --keep lines above/below when scrolling
vim.opt.sidescrolloff = 8 --keep cols left/right when scrolling
vim.opt.showmatch = true --show matching brackets

-- editing
vim.opt.smarttab = true --indentation stuff
vim.opt.autoindent = true --enable indentation
vim.opt.cindent = true --i love this
vim.opt.autoindent = false --relying on cindent^
vim.opt.tabstop = 4 --visual width of tab
vim.opt.shiftwidth = 0 --use tabstop^ for indent width
vim.opt.ignorecase = true --ignore case while searching
vim.opt.smartcase = true --but do not ignore if caps are used
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99 --disable folding, lower #s enable
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- redundant
vim.opt.showmode = false --not needed due to lualine
vim.opt.ruler = false --not needed due to lualine
vim.opt.showcmd = false --i kinda wished this would work but it flickers on normal mode commands :\

vim.diagnostic.config({
	signs = true,
})

-- -- autocmds -- --

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost",{
	pattern = "*",
	group = augroup,
	callback = function()
		vim.highlight.on_yank({timeout = 100})
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		local line = mark[1]
		local ft = vim.bo.filetype
		if line > 0 and line <= lcount
			and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
			and not vim.o.diff then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

-- auto swap numberline https://github.com/sitiom/nvim-numbertoggle/blob/main/plugin/numbertoggle.lua
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			-- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
			-- Workaround for https://github.com/neovim/neovim/issues/32068
			if not vim.tbl_contains({"@", "-"}, vim.v.event.cmdtype) then
				vim.cmd "redraw"
			end
		end
	end,
})
