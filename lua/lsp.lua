vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc" --lsp omnifunc
vim.opt.completeopt = "menuone,noselect,popup" --lsp completion menu settings

vim.lsp.inlay_hint.enable()
vim.lsp.completion.enable()

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true
})

vim.lsp.config('*', {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			}
		}
	},
	root_markers = { '.git' },
})

vim.lsp.config('elixir', {
	cmd = { 'elixir-ls' },
	filetypes = { 'elixir' },
	root_markers = { { '*.ex', '*.exs' }, '.git' },
})
vim.lsp.config('js', {
	cmd = { 'biome', 'lsp-proxy' },
	filetypes = { 'javascript', 'css', 'svelte' },
	root_markers = { { 'package-lock.json', 'package.json' }, { '*.js', '*.svelte' }, '.git' },
})
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

vim.lsp.enable({'elixir', 'js', 'rust'--[[ , 'ruby' ]]})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
			and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

vim.keymap.set("n", "<leader>c", "", { desc = "Code Utils (LSP Server)" })
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, { desc = "Go to Definition" })
vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.declaration() end, { desc = "Go to Declaration" })
vim.keymap.set("n", "<leader>ch", function() vim.lsp.buf.hover() end, { desc = "Hover Info" })
vim.keymap.set("n", "<leader>ci", function() vim.lsp.buf.implementation() end, { desc = "Go to Implementation" })
vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "Find References" })
vim.keymap.set("n", "<leader>ct", function() vim.lsp.buf.type_definition() end, { desc = "Go to Type Definition" })
vim.keymap.set("n", "<leader>cs", function() vim.lsp.buf.document_symbol() end, { desc = "List all Local Symbols" })
vim.keymap.set("n", "<leader>cS", function() vim.lsp.buf.workspace_symbol() end, { desc = "List all Symbols" })
