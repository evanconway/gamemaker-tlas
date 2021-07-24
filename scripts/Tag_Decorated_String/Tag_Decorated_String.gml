function Tag_Decorated_String(source_string) constructor {
	characters = []
	fx = []
	var fx_temp = []
	for (var i = 1; i <= string_length(source_string); i++) {
		var char = string_char_at(source_string, i)
		if (char == "<") {
			__tds_handle_commands_at_i(source_string, i, fx, fx_temp)
			i = string_pos_ext(">", source_string, i)
		} else {
			__tds_handle_new_character(char, fx_temp, characters)
		}
	}
	for (var f = 0; f < array_length(fx_temp); f++) {
		array_push(fx, fx_temp[@ f])
	}
}

function __tds_handle_commands_at_i(source_string, index, fx_arr_main, fx_arr_temp) {
	var commands = __tds_get_commands_at_i(source_string, index)
	__tds_parse_commands_into_arr(commands, fx_arr_temp)
	if (commands == "") {
		__tds_fx_arr_append_and_clear(fx_arr_main, fx_arr_temp)
	}
}

function __tds_handle_new_character(char, fx_array, char_array) {
	var new_character = new __tds_Character(char)
	for (var i = 0; i < array_length(fx_array); i++) {
		array_push(fx_array[@ i].char_refs, new_character)
	}
	array_push(char_array, new_character)
}

function __tds_get_commands_at_i(source_string, index) {
	var end_of_commands = string_pos_ext(">", source_string, index)
	var commands = string_copy(source_string, index + 1, end_of_commands - index - 1)
	return commands
}

function __tds_parse_commands_into_arr(command_string, fx_array) {
	var new_fx = __tds_get_fx_array(command_string)
	for (var f = 0; f < array_length(new_fx); f++) {
		array_push(fx_array, new_fx[@ f])
	}
}

function __tds_fx_arr_append_and_clear(fx_arr_append_to, fx_arr_to_clear) {
	for (var i = 0; i < array_length(fx_arr_to_clear); i++) {
		array_push(fx_arr_append_to, fx_arr_to_clear[@ i])
	}
	array_resize(fx_arr_to_clear, 0)
}

function __tds_get_fx_array(command_string) {
	var fx = []
	command_string = string_lower(command_string)
	var commands_raw_strings = __tds_string_split(command_string, " ")
	for (var i = 0; i < array_length(commands_raw_strings); i++) {
		var command_and_aargs = __tds_string_split(commands_raw_strings[@ i], ":")
		var command = command_and_aargs[@ 0]
		var aargs = []
		if (array_length(command_and_aargs) > 1) {
			aargs = __tds_string_split(command_and_aargs[@ 1], ",")
			__tds_aargs_strings_to_numbers(aargs)
		}
		array_push(fx, __tds_get_fx(command, aargs))
	}
	return fx
}

function __tds_aargs_strings_to_numbers(aargs) {
	for (var i = 0; i < array_length(aargs); i++) {
		try {
			var number = real(aargs[@ i])
			aargs[@ i] = number
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

function __tds_get_fx(command, aargs) {
	if (command == "shake") {
		return __tds_fx_shake(aargs)
	}
	if (command == "wshake") {
		return __tds_fx_wshake(aargs)
	}
	show_error("tds error: effect \"" + command + "\" not recognized", true)
}
