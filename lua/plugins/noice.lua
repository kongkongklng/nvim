local noice_ok, noice = pcall(require, "noice")
if not noice_ok then
	return
end

local notify_ok, notify = pcall(require, "notify")
if notify_ok then
	notify.setup({
		background_colour = "#000000",
	})
	vim.notify = notify
end

noice.setup({
	cmdline = {
		view = "cmdline_popup",
	},
	formats = {
		cmdline = { icon = "" },
		search = { icon = "" },
		lua = { icon = "" },
	},
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
	},
	routes = {
		{ filter = { event = "msg_show", find = "written" }, opts = { skip = true } },
	},
	views = {
		cmdline_popup = {
			relative = "editor",
			position = { row = "50%", col = "50%" },
			anchor = "NW",
			size = { width = 60, height = "auto" },
			border = { style = "rounded", padding = { 0, 1 } },
			win_options = {
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
			},
		},
	},
})

