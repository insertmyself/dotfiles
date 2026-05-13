return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(ft)

					if not vim.treesitter.language.add(lang) then
						local available = vim.g.ts_available or require("nvim-treesitter").get_available()
						if not vim.g.ts_available then
							vim.g.ts_available = available
						end
						if vim.tbl_contains(available, lang) then
							require("nvim-treesitter").install(lang)
						end
					end
					if vim.treesitter.language.add(lang) then
						vim.treesitter.start(args.buf, lang)
					end
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers").indonesian_script = {
						install_info = {
							url = "~/Documents/tree-sitter-is",
							files = { "src/parser.c" },
						},

						filetype = "is",
					}
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
}
