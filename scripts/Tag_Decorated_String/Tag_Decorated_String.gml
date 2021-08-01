function Tag_Decorated_String() constructor {
	source = ""
	characters = []
	default_style = new __tds_Style()
	max_width = 280
	//lines = []
}

function tds_set_text(tds, new_source_string) {
	with (tds) {
		source = new_source_string
		var line_width = 0
		var line_index = 0
		for (var i = 1; i <= string_length(source); i++) {
			var char = string_char_at(source, i)
			if (char == "<") {
				var commands = __tds_get_commands_at(i)
				i = string_pos_ext(">", source, i)
			} else {
				var c = new __tds_Character(char, default_style, line_index, 0, 0)
				array_push(characters, c)
				line_width += c.char_width
				if (char != " " && line_width > max_width) {
					line_width = c.char_width
					line_index++
					__tds_start_new_line(line_index)
				}
			}
		}
		__tds_set_characters_xy()
	}
}

function __tds_start_new_line(new_line_index) {
	var i = array_length(characters)-1
	var start_index = 0
	while (characters[@ i].character != " ") {
		characters[@ i].line_index = new_line_index
		start_index = i
		i--
	}
}

function __tds_set_characters_xy() {
	var line_heights = ds_map_create()
	for (var i = 0; i < array_length(characters); i++) {
		var c = characters[@ i]
		if (ds_map_exists(line_heights, c.line_index)) {
			if (c.char_height > line_heights[? c.line_index]) {
				line_heights[? c.line_index] = c.char_height
			}
		} else {
			ds_map_add(line_heights, c.line_index, c.char_height)
		}
	}
	var X = 0
	var Y = 0
	var line_i_prev = 0
	var c
	for (var i = 0; i < array_length(characters); i++) {
		c = characters[@ i]
		if (c.line_index != line_i_prev) {
			X = 0
			Y += line_heights[? line_i_prev]
			line_i_prev = c.line_index
		}
		c.char_x = X
		X += c.char_width
		c.char_y = Y
	}
	ds_map_destroy(line_heights)
}

function tds_draw(tds, X, Y) {
	for (var i = 0; i < array_length(tds.characters); i++) {
		var char = tds.characters[@ i]
		var draw_x = X + char.char_x
		var draw_y = Y + char.char_y
		draw_text(draw_x, draw_y, char.character)
	}
}

function __tds_get_commands_at(start_i) {
	var end_i = string_pos_ext(">", source, start_i)
	var commands_all = string_copy(source, start_i + 1, end_i - start_i - 1)
	var commands_indv = __tds_string_split(commands_all, " ")
	return commands_indv
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
