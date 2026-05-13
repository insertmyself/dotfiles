return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			"*",
			css = { rgb_fn = true, hsl_fn = true },
		})
	end,
}
