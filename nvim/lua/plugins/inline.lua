return {
	"rachartier/tiny-inline-diagnostic.nvim",
	lazy = false,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "ghost",
			transparent_cursorline = false,
			transparent_bg = true,
			options = {
				show_source = {
					enabled = true,
				},
				use_icons_from_diagnostics = true,
				show_all_diags_on_cursorline = true,
			},
		})
	end,
}
