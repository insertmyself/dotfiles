return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			highlights = {
				buffer_selected = {
					fg = "#ffffff",
				},

				modified_selected = {
					fg = "#ffffff",
				},

				modified = {
					fg = "#979da9",
				},

				modified_visible = {
					fg = "#979da9",
				},
			},

			options = {
				style_preset = {
					require("bufferline").style_preset.no_italic,
					require("bufferline").style_preset.no_bold,
				},

				separator_style = "slant",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		})
	end,
}
