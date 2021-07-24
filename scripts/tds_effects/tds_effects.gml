function __tds_fx_shake(args) {
	var arg_time_max = 5
	var arg_magnitude = 1
	if (array_length(args) == 2) {
		arg_time_max = args[@ 0]
		arg_magnitude = args[@ 1]
	} else if (array_length(args) != 0) {
		show_error("tds error: incorrect number of arguments for effect \"shake\"", true)
	}
	return {
		char_refs:	[],
		time_max:	arg_time_max, // number of frames between position changes
		time:		0,
		magnitude:	arg_magnitude, // max pixel offset left or right each change
		mod_arr_x:	[],
		mod_arr_y:	[],
		update:		function() {
			time--
			if (time <= 0) {
				time = time_max
				mod_arr_x = array_create(array_length(char_refs), 0)
				mod_arr_y = array_create(array_length(char_refs), 0)
				for (var i = 0; i < array_length(char_refs); i++) {
					mod_arr_x[@ i] = irandom_range(magnitude * -1, magnitude)
					mod_arr_y[@ i] = irandom_range(magnitude * -1, magnitude)
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_arr_x[@ i]
				char_refs[@ i].Y += mod_arr_y[@ i]
			}
		}
	}
}

function __tds_fx_wshake(args) {
	var arg_time_max = 5
	var arg_magnitude = 1
	if (array_length(args) == 2) {
		arg_time_max = args[@ 0]
		arg_magnitude = args[@ 1]
	} else if (array_length(args) != 0) {
		show_error("tds error: incorrect number of arguments for effect \"wshake\"", true)
	}
	return {
		char_refs:	[],
		time_max:	arg_time_max, // number of frames between position changes
		time:		0,
		magnitude:	arg_magnitude, // max pixel offset left or right each change
		mod_x:		0,
		mod_y:		0,
		update:		function() {
			time--
			if (time <= 0) {
				time = time_max
				for (var i = 0; i < array_length(char_refs); i++) {
					mod_x = irandom_range(magnitude * -1, magnitude)
					mod_y = irandom_range(magnitude * -1, magnitude)
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_x
				char_refs[@ i].Y += mod_y
			}
		}
	}
}
