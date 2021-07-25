function __tds_error_fx_args(effect) {
	show_error("tds error: incorrect number of arguments for effect \"" + effect + "\"", true)
}

function __tds_fx_font(aargs) {
	if (array_length(aargs) != 1) {
		__tds_error_fx_args("font")
	}
	return {
		char_refs:	[],
		font:		asset_get_index(aargs[@ 0]),
		update:		function() {
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].font = font
			}
		}
	}
}

function __tds_fx_offset(aargs) {
	if (array_length(aargs) != 2) {
		__tds_error_fx_args("offset")
	}
	return {
		char_refs:	[],
		mod_x:		aargs[@ 0],
		mod_y:		aargs[@ 1],
		update:		function() {
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_x
				char_refs[@ i].Y += mod_y
			}
		}
	}
}

function __tds_fx_shake(aargs) {
	var arg_frame_time_max = 5
	var arg_pixel_offset = 1
	if (array_length(aargs) == 2) {
		arg_frame_time_max = aargs[@ 0]
		arg_pixel_offset = aargs[@ 1]
	} else if (array_length(aargs) != 0) {
		__tds_error_fx_args("shake")
	}
	return {
		char_refs:		[],
		frame_time_max:	arg_frame_time_max,
		time:			0,
		pixel_offset:	arg_pixel_offset,
		mod_arr_x:		[],
		mod_arr_y:		[],
		update:			function() {
			time--
			if (time <= 0) {
				time = frame_time_max
				mod_arr_x = array_create(array_length(char_refs), 0)
				mod_arr_y = array_create(array_length(char_refs), 0)
				for (var i = 0; i < array_length(char_refs); i++) {
					mod_arr_x[@ i] = irandom_range(pixel_offset * -1, pixel_offset)
					mod_arr_y[@ i] = irandom_range(pixel_offset * -1, pixel_offset)
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_arr_x[@ i]
				char_refs[@ i].Y += mod_arr_y[@ i]
			}
		}
	}
}

function __tds_fx_wshake(aargs) {
	var arg_frame_time_max = 5
	var arg_pixel_offset = 1
	if (array_length(aargs) == 2) {
		arg_frame_time_max = aargs[@ 0]
		arg_pixel_offset = aargs[@ 1]
	} else if (array_length(aargs) != 0) {
		__tds_error_fx_args("wshake")
	}
	return {
		char_refs:		[],
		frame_time_max:	arg_frame_time_max,
		time:			0,
		pixel_offset:	arg_pixel_offset,
		mod_x:			0,
		mod_y:			0,
		update:			function() {
			time--
			if (time <= 0) {
				time = frame_time_max
				for (var i = 0; i < array_length(char_refs); i++) {
					mod_x = irandom_range(pixel_offset * -1, pixel_offset)
					mod_y = irandom_range(pixel_offset * -1, pixel_offset)
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_x
				char_refs[@ i].Y += mod_y
			}
		}
	}
}

function __tds_fx_float(aargs) {
	var arg_frame_time_max = 1,
	var arg_pixel_offset = 2,
	var arg_change_percent = 0.07
	if (array_length(aargs) == 3) {
		arg_frame_time_max = aargs[@ 0]
		arg_pixel_offset = aargs[@ 1]
		arg_change_percent = aargs[@ 2]
	} else if (array_length(aargs) != 0) {
		__tds_error_fx_args("float")
	}
	return {
		char_refs:		[],
		frame_time_max:	arg_frame_time_max,
		time:			0,
		pixel_offset:	arg_pixel_offset,
		change_percent:	arg_change_percent,
		count:			0,
		update:			function() {
			time--
			if (time <= 0) {
				time = frame_time_max
				count += change_percent
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].Y += sin(count) * pixel_offset
			}
		}
	}
}

function __tds_fx_fade(aargs) {
	var arg_alpha_min = 0.3
	var arg_alpha_max = 1
	var arg_alpha_change_percent = 0.015
	var arg_frame_time_max = 1
	if (array_length(aargs) == 2) {
		arg_alpha_min = aargs[0]
		arg_alpha_max = aargs[1]
	} else if (array_length(aargs) == 4) {
		arg_alpha_min = aargs[0]
		arg_alpha_max = aargs[1]
		arg_alpha_change_percent = aargs[2]
		arg_frame_time_max = aargs[3]
	} else if (array_length(aargs) != 0) {
		__tds_error_fx_args("fade")
	}
	return {
		char_refs:				[],
		alpha_min:				arg_alpha_min,
		alpha_max:				arg_alpha_max,
		alpha_change_percent:	arg_alpha_change_percent,
		frame_time_max:			arg_frame_time_max,
		change_dir:				-1,
		time:					0,
		mod_alpha:				1,	
		update:			function() {
			var change = (alpha_max - alpha_min) * alpha_change_percent
			time--
			if (time <= 0) {
				time = frame_time_max
				mod_alpha += change * change_dir
				if (mod_alpha <= alpha_min) {
					mod_alpha = alpha_min
					change_dir *= -1
				} else if (mod_alpha >= alpha_max) {
					mod_alpha = alpha_max
					change_dir *= -1
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].alpha *= mod_alpha
			}
		}
	}
}

function __tds_fx_chromatic(aargs) {
	var max_rgb = 255
	var min_rgb = 0
	return {
		char_refs:	[],
		rgb_change:	10,
		rgb_max:	max_rgb,
		rgb_min:	min_rgb,
		red:		max_rgb,
		green:		0,
		blue:		0,
		state:		1,
		update:		function() {
			if (state == 0) {
				red += rgb_change
				if (red > rgb_max) {
					red = rgb_max
					state++
				}
			} else if (state == 1) {
				blue -= rgb_change
				if (blue < rgb_min) {
					blue = rgb_min
					state++
				}
			} else if (state == 2) {
				green += rgb_change
				if (green > rgb_max) {
					green = rgb_max
					state++
				}
			} else if (state == 3) {
				red -= rgb_change
				if (red < rgb_min) {
					red = rgb_min
					state++
				}
			} else if (state == 4) {
				blue += rgb_change
				if (blue > rgb_max) {
					blue = rgb_max
					state++
				}
			} else if (state == 5) {
				green -= rgb_change
				if (green < rgb_min) {
					green = rgb_min
					state = 0
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].c_color = make_color_rgb(red, green, blue)
			}
		}
	}
}

function __tds_fx_rgb(aargs) {
	if (array_length(aargs) != 3) {
		__tds_error_fx_args("rgb")
	}
	return {
		char_refs:	[],
		red:		aargs[0],
		green:		aargs[1],
		blue:		aargs[2],
		update:		function() {
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].c_color = make_color_rgb(red, green, blue)
			}
		}
	}
}

function __tds_fx_scale(aargs) {
	var arg_mod_scale_x = 1
	var arg_mod_scale_y = 1
	if (array_length(aargs) == 2) {
		arg_mod_scale_x = aargs[@ 0]
		arg_mod_scale_y = aargs[@ 1]
	} else {
		__tds_error_fx_args("scale")
	}
	return {
		char_refs:		[],
		mod_scale_x:	arg_mod_scale_x,
		mod_scale_y:	arg_mod_scale_y,
		update:			function() {
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].scale_x *= mod_scale_x
				char_refs[@ i].scale_y *= mod_scale_y
			}
		}
	}
}

function __tds_get_fx(command, aargs) {
	command = __tds_color_to_rgb(command, aargs)
	if (command == "rgb") {
		return __tds_fx_rgb(aargs)
	}
	if (command == "chromatic") {
		return __tds_fx_chromatic(aargs)
	}
	if (command == "font") {
		return __tds_fx_font(aargs)
	}
	if (command == "offset") {
		return __tds_fx_offset(aargs)
	}
	if (command == "shake") {
		return __tds_fx_shake(aargs)
	}
	if (command == "wshake") {
		return __tds_fx_wshake(aargs)
	}
	if (command == "float") {
		return __tds_fx_float(aargs)
	}
	if (command == "fade") {
		return __tds_fx_fade(aargs)
	}
	if (command == "scale") {
		return __tds_fx_scale(aargs)
	}
	if (command == "sprite") {
		return undefined // sprite not handled here, included to avoid error
	}
	show_error("tds error: effect \"" + command + "\" not recognized", true)
}
