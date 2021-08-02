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