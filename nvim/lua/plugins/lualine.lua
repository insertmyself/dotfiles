return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							if str:find("NORMAL") then
								return " NORMAL"
							elseif str:find("INSERT") then
								return " INSERT"
							elseif str:find("VISUAL") then
								return " VISUAL"
							elseif str:find("REPLACE") then
								return "󰬲 REPLACE"
							elseif str:find("PENDING") then
								return " PENDING"
							elseif str:find("BLOCK") then
								return "󰈈 BLOCK"
							elseif str:find("COMMAND") then
								return " COMMAND"
							else
								return str
							end
						end,
					},
				},
				lualine_b = {
					{
						function()
							local ft = vim.bo.filetype
							local filename = vim.fn.expand("%:t")
							local icon = require("nvim-web-devicons").get_icon(ft)
							local status = ""

							if vim.bo.modified then
								status = status .. " [+]"
							elseif vim.bo.readonly then
								status = status .. " [!]"
							end

							if filename == "" then
								return " File" .. status
							end

							if icon then
								return icon .. " " .. filename .. status
							else
								return " " .. filename .. status
							end
						end,
					},
				},
				lualine_c = {},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "warn", "error", "info", "hint" },
						diagnostics_color = {
							error = { fg = "#ffffff" },
							warn = { fg = "#ffffff" },
							hint = { fg = "#ffffff" },
							info = { fg = "#ffffff" },
						},
						symbols = {
							error = " ",
							warn = " ",
							info = "󰋼 ",
							hint = "󰯪 ",
						},
					},
				},
				lualine_y = {
					function()
						local sysname = vim.uv.os_uname().sysname

						if sysname == "Windows" then
							return " Windows"
						elseif sysname == "Darwin" then
							return " Mac"
						elseif sysname == "Linux" then
							return " Linux"
						end

						return " " .. sysname
					end,
				},
				lualine_z = {
					{
						function()
							return vim.fn.line(".") .. ":" .. vim.fn.col(".") .. " "
						end,
					},
				},
			},
			options = {
				icons_enabled = true,
				theme = "wetar",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "neo-tree", "alpha" },
				ignore_focus = { "neo-tree", "alpha" },
				always_divide_middle = true,
			},
		})
	end,
}
