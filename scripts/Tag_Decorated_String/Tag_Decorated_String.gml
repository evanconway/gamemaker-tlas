/*
	Tag Decorated String
	
	Special "strings" that can be changed and animated by html style tags.
*/
function Tag_Decorated_String(source_string) constructor {
	characters = []
	fx = []
	
	/*
		The fx in fx_curr gather character references during parsing. They are
	*/
	var fx_curr = []
	for (var i = 1; i <= string_length(source_string); i++) {
		var char = string_char_at(source_string, i)
		if (char == "<") {
			var end_of_commands = string_pos_ext(">", source_string, i)
			var commands = string_copy(source_string, i + 1, end_of_commands - i - 1)
			
			var new_fx = __tds_get_fx_array(commands)
			for (var f = 0; f < array_length(new_fx); f++) {
				array_push(fx_curr, new_fx[@ f])
			}
			
			// clear effects on empty tags
			if (commands == "") {
				for (var f = 0; f < array_length(fx_curr); f++) {
					array_push(fx, fx_curr[@ f])
				}
				fx_curr = []
			}
			
			i = end_of_commands
		} else {
			
			var new_character = {
				character:	char,
				X:			0,
				Y:			0,
				c_color:	draw_get_color(),
				angle:		0,
				scaleX:		1,
				scaleY:		1,
				font:		draw_get_font()
			}
			
			for (var f = 0; f < array_length(fx_curr); f++) {
				array_push(fx_curr[@ f].char_refs, new_character)
			}
			
			array_push(characters, new_character)
		}
	}
	
	for (var f = 0; f < array_length(fx_curr); f++) {
		array_push(fx, fx_curr[@ f])
	}
}

function tds_draw(tds, X, Y) {
	// init chars
	for (var i = 0; i < array_length(tds.characters); i++) {
		var char = tds.characters[@ i]
		char.X = 0
		char.Y = 0
		char.c_color = c_white
		char.angle = 0
		char.scaleX = 1
		char.scaleY = 1
	}
	
	for (var i = 0; i < array_length(tds.fx); i++) {
		tds.fx[@ i].update()
	}
	
	for (var i = 0; i < array_length(tds.characters); i++) {
		var c = tds.characters[@ i]
		var c_x = c.X + X
		var c_y = c.Y + Y
		var c_char = c.character
		draw_text_transformed(c_x, c_y, c_char, c.scaleX, c.scaleY, c.angle)
		X += string_width(c_char) * c.scaleX
	}
}

function __tds_get_fx_array(command_string) {
	var fx = []
	command_string = string_lower(command_string)
	var commands_raw_strings = __tds_string_split(command_string, " ")
	for (var i = 0; i < array_length(commands_raw_strings); i++) {
		
		// split raw string into command and args
		var raw_string_split = __tds_string_split(commands_raw_strings[@ i], ":")
		var command = raw_string_split[@ 0]
		var args = []
		if (array_length(raw_string_split) > 1) {
			args = __tds_string_split(raw_string_split[@ 1], ",")
			__tds_clean_args(args)
		}
		array_push(fx, __tds_get_fx(command, args))
	}
	return fx
}

// Accepts array of strings, replaces strings of numbers with actual numbers.
function __tds_clean_args(args) {
	for (var i = 0; i < array_length(args); i++) {
		try {
			var number = real(args[@ i])
			args[@ i] = number
		}
	}
}

function __tds_string_split(s, delimiter) {
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

function __tds_get_fx(command, args) {
	if (command == "shake") {
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
			mod_arr_x:		[],
			mod_arr_y:		[],
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
	
	if (command == "wshake") {
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
	
	show_error("tds error: effect \"" + command + "\" not recognized", true)
}