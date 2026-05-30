hl.config({
	input = {
		kb_layout = "gb",
		kb_variant = "",
		kb_model = "",
		kb_options = "compose:ralt",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
