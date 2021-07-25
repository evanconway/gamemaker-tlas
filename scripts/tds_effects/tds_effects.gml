/*
	All effects must contain a char_refs array and an update function. The update function should
	act on all elements in the char_refs array. Everything else dependson the effect. 
*/

function __tds_fx_shake(aargs) {
	var arg_frame_time_max = 5
	var arg_pixel_offset = 1
	if (array_length(aargs) == 2) {
		arg_frame_time_max = aargs[@ 0]
		arg_pixel_offset = aargs[@ 1]
	} else if (array_length(aargs) != 0) {
		show_error("tds error: incorrect number of arguments for effect \"shake\"", true)
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
		show_error("tds error: incorrect number of arguments for effect \"wshake\"", true)
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
		show_error("tds error: incorrect number of arguments for effect \"rgb\"", true)
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

function __tds_get_fx(command, aargs) {
	command = __tds_color_to_rgb(command, aargs)
	if (command == "rgb") {
		return __tds_fx_rgb(aargs)
	}
	if (command == "shake") {
		return __tds_fx_shake(aargs)
	}
	if (command == "wshake") {
		return __tds_fx_wshake(aargs)
	}
	if (command == "chromatic") {
		return __tds_fx_chromatic(aargs)
	}
	show_error("tds error: effect \"" + command + "\" not recognized", true)
}
