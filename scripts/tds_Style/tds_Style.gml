function __tds_Style() constructor {
	font = tds_font_default
	s_color = c_white
	alpha = 1
	scale_x = 1
	scale_y = 1
	mod_x = 0
	mod_y = 0
	mod_angle = 0
}

function __tds_get_undefined_style() {
	var result = new __tds_Style()
	result.font = undefined
	result.s_color = undefined
	result.alpha= undefined
	result.scale_x = undefined
	result.scale_y = undefined
	result.mod_x = undefined
	result.mod_y = undefined
	result.mod_angle = undefined
	return result
}

function __tds_get_style(original_style, commands) {
	var result = __tds_style_copy(original_style)
	for (var i = 0; i < array_length(commands); i++) {
		var c = commands[@ i].command
		var a = commands[@ i].aargs
		c = __tds_color_to_rgb(c, a)
		if (c == "rgb") {
			result.s_color = make_color_rgb(a[@ 0], a[@ 1], a[@ 2])
		}
		if (c == "font") {
			if (array_length(a) != 1) {
				show_error("TDS: Incorrect number of args for font style.", true)
			}
			if (asset_get_type(a[@ 0]) != asset_font) {
				show_error("TDS: Unrecognized font name.", true)
			}
			result.font = asset_get_index(a[@ 0])
			
		}
		if (c == "scale") {
			if (array_length(a) != 2) {
				show_error("TDS: Incorrect number of args for scale style.", true)
			}
			result.scale_x = a[@ 0]
			result.scale_y = a[@ 1]
		}
		if (c == "angle") {
			if (array_length(a) != 1) {
				show_error("TDS: Incorrect number of args for angle style.", true)
			}
			result.mod_angle = a[@ 0]
		}
		if (c == "alpha") {
			if (array_length(a) != 1) {
				show_error("TDS: Incorrect number of args for alpha style.", true)
			}
			result.alpha = a[@ 0]
		}
		if (c == "offset") {
			if (array_length(a) != 2) {
				show_error("TDS: Incorrect number of args for offset style.", true)
			}
			result.mod_x = a[@ 0]
			result.mod_y = a[@ 1]
		}
	}
	return result
}

function __tds_style_copy(style_to_copy) {
	var result = new __tds_Style()
	result.font = style_to_copy.font
	result.s_color = style_to_copy.s_color
	result.alpha= style_to_copy.alpha
	result.scale_x = style_to_copy.scale_x
	result.scale_y = style_to_copy.scale_y
	result.mod_x = style_to_copy.mod_x
	result.mod_y = style_to_copy.mod_y
	result.mod_angle = style_to_copy.mod_angle
	return result
}

function __tds_style_equal(style_a, style_b) {
	if (style_a.font != style_b.font) {
		return false
	}
	if (style_a.s_color != style_b.s_color) {
		return false
	}
	if (style_a.alpha != style_b.alpha) {
		return false
	}
	if (style_a.scale_x != style_b.scale_x) {
		return false
	}
	if (style_a.scale_y != style_b.scale_y) {
		return false
	}
	if (style_a.mod_x != style_b.mod_x) {
		return false
	}
	if (style_a.mod_y != style_b.mod_y) {
		return false
	}
	if (style_a.mod_angle != style_b.mod_angle) {
		return false
	}
	return true
}