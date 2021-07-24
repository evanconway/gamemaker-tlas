/*
	Tag Decorated String
	
	Special "strings" that can be changed and animated by html style tags.
*/
function Tag_Decorated_String(source_string) constructor {
	characters = []
	fx = []
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
				alpha:		1,
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
	for (var i = 0; i < array_length(tds.characters); i++) {
		__tds_init_character(tds.characters[@ i])
	}
	for (var i = 0; i < array_length(tds.fx); i++) {
		tds.fx[@ i].update()
	}
	for (var i = 0; i < array_length(tds.characters); i++) {
		var c = tds.characters[@ i]
		var c_x = c.X + X
		var c_y = c.Y + Y
		var c_char = c.character
		draw_set_alpha(c.alpha)
		draw_set_color(c.c_color)
		draw_set_font(c.font)
		draw_text_transformed(c_x, c_y, c_char, c.scaleX, c.scaleY, c.angle)
		X += string_width(c_char) * c.scaleX
	}
}

function __tds_init_character(char) {
	char.X = 0
	char.Y = 0
	char.c_color = c_white
	char.angle = 0
	char.scaleX = 1
	char.scaleY = 1
	char.alpha = 1
	char.font = tds_font_default
}

function __tds_get_fx_array(command_string) {
	var fx = []
	command_string = string_lower(command_string)
	var commands_raw_strings = __tds_string_split(command_string, " ")
	for (var i = 0; i < array_length(commands_raw_strings); i++) {
		var command_and_args = __tds_string_split(commands_raw_strings[@ i], ":")
		var command = command_and_args[@ 0]
		var args = []
		if (array_length(command_and_args) > 1) {
			args = __tds_string_split(command_and_args[@ 1], ",")
			__tds_args_strings_to_numbers(args)
		}
		array_push(fx, __tds_get_fx(command, args))
	}
	return fx
}

function __tds_args_strings_to_numbers(args) {
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
		return __tds_fx_shake(args)
	}
	if (command == "wshake") {
		return __tds_fx_wshake(args)
	}
	show_error("tds error: effect \"" + command + "\" not recognized", true)
}