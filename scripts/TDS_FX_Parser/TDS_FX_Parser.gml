
enum TDS_FX {
	// xy
	XY,
	WAVE,
	FLOAT,
	SHAKE,
	WSHAKE,
	
	// alpha
	ALPHA,
	PULSE,
	BLINK,
	
	// color
	COLOR,
	CHROMATIC,
	
	// font
	FONT,
	
	// rotation
	ROTATION,
	WOBBLE,
	WWOBBLE,
	
	// final enum value is number of enum values
	NUM_OF_FX
}

// return map of fx structs with settings based on fx_string argument
function tds_parser(fx_string) {
	
	// parse out commands and arguments from fx_string
	fx_string = string_lower(fx_string)
	var split_spaces = tds_string_split(fx_string, " ")
	for (var i = 0; i < array_length(split_spaces); i++) {
		
		var command_args = tds_string_split(split_spaces[@ i], ":")
		var command = command_args[@ 0]
		var args = []
		
		if (array_length(command_args) == 2) {
			args = tds_string_split(command_args[@ 1], ",")
		}
		
		if (array_length(command_args) > 2) {
			show_error("tds error: improper number of : in command", true)
		}
		
		// apply command and args to effects
		
		// handle commands with string arguments first
		if (command == "font") {
			result[? command].mod_font = args[0]
		}
		
		// convert args to numbers, and handle all other commands
		for (var i = 0; i < array_length(args); i++) {
			args[@ i] = real(string_digits(args[@ i]))
		}
		
		if (command == "xy") {
			result[? TDS_FX.XY].mod_x = args[0]
			result[? TDS_FX.XY].mod_y = args[1]
		}
		
		if (command == "wave") {
		
		}
		
		if (command == "float") {
		
		}
		
		if (command == "shake") {
		
		}
		
		if (command == "wshake") {
		
		}
		
		if (command == "alpha") {
		
		}
		
		if (command == "pulse") {
		
		}
		
		if (command == "blink") {
		
		}
		
		if (command == "color") {
		
		}
		
		if (command == "chromatic") {
		
		}
	}
	
	
	return result
}

// return map of init fx structs
function tds_fx_map_create() {
	var result = ds_map_create()
	
	// xy 
	ds_map_add(result, TDS_FX.XY, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.WAVE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.FLOAT, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.SHAKE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.WSHAKE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	// alpha
	
	ds_map_add(result, TDS_FX.ALPHA, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_alpha:	0
	})
	
	ds_map_add(result, TDS_FX.PULSE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_alpha:	0
	})
	
	ds_map_add(result, TDS_FX.BLINK, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_alpha:	0
	})
	
	// color
	
	ds_map_add(result, TDS_FX.COLOR, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_color:	0
	})
	
	ds_map_add(result, TDS_FX.CHROMATIC, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_color:	0
	})
	
	// font
	
	ds_map_add(result, TDS_FX.FONT, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_font:	0
	})
	
	// rotation
	
	ds_map_add(result, TDS_FX.ROTATION, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_rotation:	0
	})
	
	ds_map_add(result, TDS_FX.WOBBLE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_rotation:	0
	})
	
	ds_map_add(result, TDS_FX.WWOBBLE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_rotation:	0
	})

	return result
}

function tds_string_split(s, delimiter) {
	var result = []
	var delimiter_length = string_length(delimiter)
	for (var i = 1; i <= string_length(s);) {
		var next = string_pos_ext(delimiter, s, i - 1)
		if (next > 0) {
			var substr = string_copy(s, i, next - i)
			if (substr != "") {
				array_push(result, substr)
			}	
			i = next + delimiter_length
		} else {
			array_push(result, string_copy(s, i, string_length(s)))
			i = string_length(s) + 1
		}
	}
	return result
}
