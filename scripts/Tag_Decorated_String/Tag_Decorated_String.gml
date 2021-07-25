function Tag_Decorated_String(source_string) constructor {
	characters = []
	fx = []
	var fx_temp = []
	for (var i = 1; i <= string_length(source_string); i++) {
		var char = string_char_at(source_string, i)
		if (char == "<") {
			__tds_handle_sprite(source_string, i, characters, fx_temp)
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

function __tds_handle_sprite(source_string, index, characters, fx_temp) {
	var string_commands = __tds_get_commands_at_i(source_string, index)
	var string_arr = __tds_string_split(string_commands, ":")
	if (array_length(string_arr) == 2 && string_arr[@ 0] == "sprite") {
		if (array_length(string_arr) == 1) {
			show_error("tds error: sprite command missing value", true)
		}
		var sprite_id = asset_get_index(string_arr[@ 1])
		if (!sprite_exists(sprite_id)) {
			show_error("tds error: sprite \"" + string_arr[@ 1] + "\" does not exist.", true)
		}
		var sprite_char = new __tds_Character("")
		sprite_char.sprite = sprite_id
		for (var i = 0; i < array_length(fx_temp); i++) {
			array_push(fx_temp[@ i].char_refs, sprite_char)
		}
		array_push(characters, sprite_char)
	}
}

function __tds_handle_commands_at_i(source_string, index, fx_arr_main, fx_arr_temp) {
	var string_commands = __tds_get_commands_at_i(source_string, index)
	__tds_parse_commands_into_arr(string_commands, fx_arr_temp)
	if (string_commands == "") {
		__tds_arr_append_and_clear(fx_arr_main, fx_arr_temp)
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
	var command_string = string_copy(source_string, index + 1, end_of_commands - index - 1)
	return command_string
}

function __tds_parse_commands_into_arr(command_string, fx_array) {
	var new_fx = __tds_get_fx_array(command_string)
	for (var i = 0; i < array_length(new_fx); i++) {
		array_push(fx_array, new_fx[@ i])
	}
}

function __tds_arr_append_and_clear(arr_append_to, arr_to_clear) {
	for (var i = 0; i < array_length(arr_to_clear); i++) {
		array_push(arr_append_to, arr_to_clear[@ i])
	}
	array_resize(arr_to_clear, 0)
}

function __tds_get_fx_array(command_string) {
	var fx = []
	command_string = string_lower(command_string)
	var commands_raw_strings = __tds_string_split(command_string, " ")
	for (var i = 0; i < array_length(commands_raw_strings); i++) {
		var command_and_aargs = __tds_string_split(commands_raw_strings[@ i], ":")
		var command = command_and_aargs[@ 0]
		var aargs = [] // aargs instead of args due to YYC error
		if (array_length(command_and_aargs) > 1) {
			aargs = __tds_string_split(command_and_aargs[@ 1], ",")
			__tds_aargs_strings_to_numbers(aargs)
		}
		var new_fx = __tds_get_fx(command, aargs)
		if (new_fx != undefined) {
			array_push(fx, new_fx)
		}
	}
	return fx
}

function __tds_aargs_strings_to_numbers(aargs) {
	for (var i = 0; i < array_length(aargs); i++) {
		try {
			var number = real(aargs[@ i])
			aargs[@ i] = number
		} catch (e) {
			// do nothing
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
