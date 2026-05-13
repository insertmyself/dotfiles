-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- Credit itchyny, jackno (lightline)
-- stylua: ignore
local colors = {
  gray       = '#101010',
  lightgray  = '#202020',
  white      = '#ffffff',
  black      = '#000000',
}

return {
	normal = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	insert = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	visual = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	replace = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	command = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	inactive = {
		a = { bg = colors.gray, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
}
