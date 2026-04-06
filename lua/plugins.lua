local NOT_SSH = os.execute("[ -z ${SSH_TTY} ]") == 0

require("barbar").setup({
	animation = false,
	auto_hide = 1,
	insert_at_end = true,
})

require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
		"size",
	},
	view_options = {
		show_hidden = true,
	},
	constrain_cursor = "editable",
	prompt_save_on_select_new_entry = true,
})

require('nvim-treesitter').install({
	'bash',
	'css',
	'elixir',
	'eex',
	'heex',
	'html',
	'html_tags',
	'javascript',
	'markdown',
	'markdown_inline',
	'svelte',
	'rust',
	'typescript',
	'zig',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'bash',
		'css',
		'elixir',
		'eex',
		'heex',
		'html',
		'html_tags',
		'javascript',
		'markdown',
		'markdown_inline',
		'svelte',
		'rust',
		'typescript',
		'zig',
	},
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.treesitter.start()
	end,
})

require("nvim-navic").setup({
	lsp = {
		auto_attach = true,
	},
})
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.cmd([[
highlight WinBar           guibg=None guifg=#BBBBBB gui=bold
highlight WinBarHeader     guibg=None guifg=#BBBBBB gui=bold,underline
highlight WinBarNC         guibg=None guifg=#888888 gui=bold
highlight WinBarLocation   guibg=None guifg=#888888 gui=bold
highlight WinBarModified   guibg=None guifg=#d7d787
highlight WinBarGitDirty   guibg=None guifg=#d7afd7
highlight WinBarIndicator  guibg=None guifg=#5fafd7 gui=bold
highlight WinBarInactive   guibg=None guibg=#3a3a3a guifg=#777777 gui=bold
]])

require('treesj').setup()

require("Comment").setup()

require("sentiment").enable()

require("colorizer").setup(nil, {
	RGB = true, -- #RGB hex codes
	RRGGBB = true, -- #RRGGBB hex codes
	names = false, -- "Name" codes like Blue
	RRGGBBAA = true, -- #RRGGBBAA hex codes
	rgb_fn = true, -- CSS rgb() and rgba() functions
	hsl_fn = true, -- CSS hsl() and hsla() functions
})

require("ibl").setup()

require("which-key").setup({
	preset = "helix",
	delay = 500,
})

require("lualine").setup({
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'location', 'progress'},
		lualine_z = {
			function() 
				local ok, pomo = pcall(require, "pomo")
				if not ok then
					return ""
				end

				local timer = pomo.get_first_to_finish()
				if timer == nil then
					return ""
				end

				return "󰄉 " .. tostring(timer)
			end
		},
	},
})

if NOT_SSH then require("smear_cursor").setup({
	stiffness = 0.8,
	trailing_stiffness = 0.4,
	smear_insert_mode = false,
	delay_disable = 1000,
	never_draw_over_target = true,
	hide_target_hack = true,
	anticipation = 0,
	distance_stop_animating = 0.5,
}) end

require("smear_cursor").enabled = NOT_SSH

require('hlargs').setup()

require("mini.surround").setup()

require("obsidian").setup({
	workspaces = {
		{
			name = "personal",
			path = "~/vault/personal"
		},
		{
			name = "work",
			path = "~/vault/work"
		}
	}
})

require("pomo").setup({
	timers = {
		Work = {
			{ name = "System" },
		},
		Break = {
			{ name = "System" },
		}
	},
	sessions = {
		pomodoro = {
			{ name = "Work", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Work", duration = "25m" },
			{ name = "Short Break", duration = "5m" },
			{ name = "Work", duration = "25m" },
			{ name = "Long Break", duration = "15m" },
		},
	}
})

local augend = require("dial.augend")
require("dial.config").augends:register_group{
	-- default augends used when no group name is specified
	default = {
		augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.semver.alias.semver,     -- semantic versioning (0.3.0, 1.22.1, ...)
		augend.constant.alias.bool,     -- elements in boolean algebra (true and false)
		augend.constant.alias.Bool,     -- elements in boolean algebra (True and False)
		augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
	},
}
