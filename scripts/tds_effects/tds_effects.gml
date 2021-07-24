function __tds_fx_shake(aargs) {
	var arg_frame_time_max = 5;
	var arg_pixel_offset = 1;
	if (array_length(aargs) == 2) {
		arg_frame_time_max = aargs[@ 0];
		arg_pixel_offset = aargs[@ 1];
	} else if (array_length(aargs) != 0) {
		show_error("tds error: incorrect number of arguments for effect \"shake\"", true);
	}
	return {
		char_refs:		[],
		frame_time_max:	arg_frame_time_max,
		time:			0,
		pixel_offset:	arg_pixel_offset,
		mod_arr_x:		[],
		mod_arr_y:		[],
		update:			function() {
			time--;
			if (time <= 0) {
				time = frame_time_max;
				mod_arr_x = array_create(array_length(char_refs), 0);
				mod_arr_y = array_create(array_length(char_refs), 0);
				for (var i = 0; i < array_length(char_refs); i++) {
					mod_arr_x[@ i] = irandom_range(pixel_offset * -1, pixel_offset);
					mod_arr_y[@ i] = irandom_range(pixel_offset * -1, pixel_offset);
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_arr_x[@ i];
				char_refs[@ i].Y += mod_arr_y[@ i];
			}
		}
	};
}

function __tds_fx_wshake(aargs) {
	var arg_frame_time_max = 5;
	var arg_pixel_offset = 1;
	if (array_length(aargs) == 2) {
		arg_frame_time_max = aargs[@ 0];
		arg_pixel_offset = aargs[@ 1];
	} else if (array_length(aargs) != 0) {
		show_error("tds error: incorrect number of arguments for effect \"wshake\"", true);
	}
	return {
		char_refs:		[],
		frame_time_max:	arg_frame_time_max,
		time:			0,
		pixel_offset:	arg_pixel_offset,
		mod_x:			0,
		mod_y:			0,
		update:			function() {
			time--;
			if (time <= 0) {
				time = frame_time_max;
				for (var i = 0; i < array_length(char_refs); i++) {
					mod_x = irandom_range(pixel_offset * -1, pixel_offset);
					mod_y = irandom_range(pixel_offset * -1, pixel_offset);
				}
			}
			for (var i = 0; i < array_length(char_refs); i++) {
				char_refs[@ i].X += mod_x;
				char_refs[@ i].Y += mod_y;
			}
		}
	};
}

function __tds_fx_chromatic(aargs) {
	return {
		char_refs:	[],
		rgb_change:	10
	};
}