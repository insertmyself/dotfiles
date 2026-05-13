return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	lazy = false,
	config = function()
		require("cord").setup({
			autostart = true,
			variables = true,

			ipc = {
				socket = "/tmp/discord-ipc-0",
			},

			editor = {
				tooltip = "Sometimes dumb text editor",
			},

			display = {
				theme = "classic",
				swap_fields = true,
			},

			text = {
				editing = "Changing stuff in ${filename}",
				file_browser = "Searching for something in ${name}",
				docs = "Reading the docs in ${name}",
				workspace = "Cooking in ${workspace}",
			},

			idle = {
				tooltip = "Doing something irl (probably)",
			},

			advanced = {
				workspace = {
					limit_to_cwd = true,
				},
			},
		})
	end,
}
