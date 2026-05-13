return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme onedark_dark")
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none", fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "none", fg = "#ffffff", bold = true })
		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "none", fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "none", fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { fg = "#787c99" })
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#000000" })
		vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#495162" })
		vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#ffffff", fg = "#000000" })
		vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#ffffff", fg = "#000000" })
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#000000" })
		vim.api.nvim_set_hl(0, "ScreenkeyTitle", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "Cursor", { bg = "#ffffff" })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#ffffff" })
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#ffffff" })
	end,
}
