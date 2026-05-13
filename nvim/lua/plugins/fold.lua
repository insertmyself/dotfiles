return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "lsp", "indent" }
			end,
		})

		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Unfold all folded things" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Fold all things" })
		vim.keymap.set("n", "-", "<CMD>foldclose<CR>", { desc = "Fold thing" })
		vim.keymap.set("n", "+", "<CMD>foldopen<CR>", { desc = "Unfold thing" })
		vim.keymap.set("n", "zK", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()

			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek into folded thing" })
	end,
}
