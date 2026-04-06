local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
	  -- completion = cmp.config.window.bordered(),
	  -- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources(
		{
			{ name = 'nvim_lsp' },
		}, {
			{ name = 'buffer' },
		}
	)
})

vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc" --lsp omnifunc
vim.opt.completeopt = "menuone,noselect,popup,preinsert" --lsp completion menu settings

vim.lsp.inlay_hint.enable()
-- vim.lsp.completion.enable()

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true
})

vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	-- capabilities = {
	-- 	textDocument = {
	-- 		semanticTokens = {
	-- 			multilineTokenSupport = false,
	-- 		}
	-- 	}
	-- },
	root_markers = { '.git' },
})

vim.lsp.config('elixir', {
	cmd = { 'elixir-ls' },
	filetypes = { 'elixir' },
	root_markers = { { '*.ex', '*.exs' }, '.git' },
})
-- vim.lsp.config('js', {
-- 	cmd = { 'biome', 'lsp-proxy' },
-- 	filetypes = { "astro", "css", "graphql", "html", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescriptreact", "vue" },
-- 	root_markers = { { 'package-lock.json', 'package.json' }, { '*.js', '*.svelte' }, '.git' },
-- })
vim.lsp.config('tailwindcss', {})
vim.lsp.config('rust', {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { { 'Cargo.toml', 'Cargo.lock' }, '*.rs', '.git' },
})
-- TODO: USE `sorbet`
-- vim.lsp.config('ruby', {
-- 	cmd = { '' },
-- 	filetypes = { 'ruby' },
-- 	root_markers = { { '*.rb' }, '.git' },
-- })

vim.lsp.enable({'elixir', 'tailwindcss', 'biome', 'rust' --[[ , 'ruby' ]]})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.keymap.set("n", "<leader>c", "", { desc = "Code Utils (LSP Server)" })
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, { desc = "Go to Definition" })
vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.declaration() end, { desc = "Go to Declaration" })
vim.keymap.set("n", "<leader>cf", function() 
	local client = assert(vim.lsp.get_client_by_id(1), "No LSP client!")
	if client:supports_method('textDocument/formatting') then
		vim.lsp.buf.format({ id = client.id, timeout_ms = 1000 })
		print("Zap!")
	else
		print("Client does not support formatting!")
	end
end, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>ch", function() vim.lsp.buf.hover() end, { desc = "Hover Info" })
vim.keymap.set("n", "<leader>ci", function() vim.lsp.buf.implementation() end, { desc = "Go to Implementation" })
vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "Find References" })
vim.keymap.set("n", "<leader>ct", function() vim.lsp.buf.type_definition() end, { desc = "Go to Type Definition" })
vim.keymap.set("n", "<leader>cs", function() vim.lsp.buf.document_symbol() end, { desc = "List all Local Symbols" })
vim.keymap.set("n", "<leader>cS", function() vim.lsp.buf.workspace_symbol() end, { desc = "List all Symbols" })
