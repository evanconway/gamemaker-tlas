
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
	var result = tds_fx_map_create()
	
	// parse out commands and arguments from fx_string
	fx_string = string_lower(fx_string)
	var split_spaces = tds_string_split(fx_string, " ")
	for (var i = 0; i < array_length(split_spaces); i++) {
		
		var command_args = tds_string_split(split_spaces[@ i], ":")
		var command = tds_command_string_to_enum(command_args[@ 0])
		var args = []
		
		if (array_length(command_args) == 2) {
			args = tds_string_split(command_args[@ 1], ",")
		}
		
		if (array_length(command_args) > 2) {
			show_error("tds error: improper number of : in command", true)
		}
		
		// apply command and args to effects
		
		// handle commands with string arguments first
		if (command == TDS_FX.FONT) {
			result[? command].mod_font = args[0]
		}
		
		// convert args to numbers, and handle all other commands
		for (var i = 0; i < array_length(args); i++) {
			args[@ i] = real(string_digits(args[@ i]))
		}
		
		if (command == TDS_FX.XY) {
			result[? command].mod_x = args[0]
			result[? command].mod_y = args[1]
		}
		
		if (command == TDS_FX.WAVE) {
		
		}
		
		if (command == TDS_FX.FLOAT) {
		
		}
		
		if (command == TDS_FX.SHAKE) {
		
		}
		
		if (command == TDS_FX.WSHAKE) {
		
		}
		
		if (command == TDS_FX.ALPHA) {
		
		}
		
		if (command == TDS_FX.PULSE) {
		
		}
		
		if (command == TDS_FX.BLINK) {
		
		}
		
		if (command == TDS_FX.COLOR) {
		
		}
		
		if (command == TDS_FX.CHROMATIC) {
		
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

// return fx enum of given string
function tds_command_string_to_enum(s) {
	if (s == "xy") {
		return TDS_FX.XY
	}
	
	if (s == "wave") {
		return TDS_FX.WAVE
	}
	
	if (s == "float") {
		return TDS_FX.FLOAT
	}
	
	if (s == "shake") {
		return TDS_FX.SHAKE
	}
	
	if (s == "wshake") {
		return TDS_FX.WSHAKE
	}
	
	if (s == "alpha") {
		return TDS_FX.ALPHA
	}
	
	if (s == "pulse") {
		return TDS_FX.PULSE
	}
	
	if (s == "blink") {
		return TDS_FX.BLINK
	}
	
	if (s == "color") {
		return TDS_FX.COLOR
	}
	
	if (s == "chromatic") {
		return TDS_FX.CHROMATIC
	}
	
	if (s == "font") {
		return TDS_FX.FONT
	}
	
	if (s == "rotation") {
		return TDS_FX.ROTATION
	}
	
	if (s == "wobble") {
		return TDS_FX.WOBBLE
	}
	
	if (s == "wwobble") {
		return TDS_FX.WWOBBLE
	}
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
