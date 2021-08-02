function Tag_Decorated_String() constructor {
	source = ""
	characters = []
	default_style = new __tds_Style()
	max_width = 500
	drawables = undefined
	create_drawables_on_set_text = true
}

function tds_get_characters_size(tds) {
	return array_length(tds.characters)
}

function tds_get_character_at(tds, index) {
	return tds.characters[@ index].character
}

function tds_start_entry_at(tds, character_index) {
	with (tds) {
		__tds_drawables_add(character_index)
	}
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
					line_index++
					line_width = __tds_start_new_line(line_index)
				}
			}
		}
		__tds_set_characters_xy()
	}
}

function __tds_start_new_line(new_line_index) {
	var i = array_length(characters)-1
	var new_line_width = 0
	while (characters[@ i].character != " ") {
		characters[@ i].line_index = new_line_index
		new_line_width += characters[@ i].char_width
		i--
	}
	return new_line_width
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
		if (create_drawables_on_set_text) {
			__tds_drawables_add(i)
		}
	}
	ds_map_destroy(line_heights)
}

function __tds_drawables_add(char_index) {
	var c = characters[@ char_index]
	if (c.added) {
		return
	}
	c.added = true
	var drawable = {
		previous:	undefined,
		next:		undefined,
		i_start:	char_index,
		i_end:		char_index,
		content:	c.character,
		style:		__tds_style_copy(c.style)
	}
	if (drawables == undefined) {
		drawables = drawable
		return
	}
	var left = __tds_get_drawable_left(drawable.i_start)
	var right = __tds_get_drawable_right(drawable.i_start)
	if (left != undefined) {
		left.next = drawable
	}
	drawable.previous = left
	if (right != undefined) {
		right.previous = drawable
	}
	drawable.next = right
	var merged = __tds_drawable_merge(left, drawable)
	if (merged) {
		__tds_drawable_merge(left, right)
	} else {
		__tds_drawable_merge(drawable, right)
	}
}

function __tds_drawable_merge(a, b) {
	if (a == undefined || b == undefined) {
		return false
	}
	if (characters[@ a.i_start].line_index != characters[@ b.i_start].line_index) {
		return false
	}
	if (__tds_style_equal(a.style, b.style) && a.i_end == b.i_start - 1) {
		a.content += b.content
		a.i_end += (b.i_end - b.i_start + 1)
		a.next = b.next
	}
	return true
}

function __tds_get_drawable_left(target_index) {
	if (drawables == undefined) {
		return undefined
	}
	var result = drawables
	if (drawables.i_start > target_index) {
		return undefined
	}
	while (result.next != undefined && result.next.i_end < target_index) {
		result = result.next
	}
	return result
}

function __tds_get_drawable_right(target_index) {
	if (drawables == undefined) {
		return undefined
	}
	var result = drawables
	while (result != undefined && result.i_start < target_index) {
		result = result.next
	}
	return result
}

function tds_draw(tds, X, Y) {
	var cursor = tds.drawables
	var char_x
	var char_y
	var style_x
	var style_y
	var scale_x
	var scale_y
	var draw_x
	var draw_y
	var angle
	while (cursor != undefined) {
		char_x = tds.characters[@ cursor.i_start].char_x
		char_y = tds.characters[@ cursor.i_start].char_y
		style_x = cursor.style.mod_x
		style_y = cursor.style.mod_y
		scale_x = cursor.style.scale_x
		scale_y = cursor.style.scale_y
		draw_x = X + char_x + style_x
		draw_y = Y + char_y + style_y
		angle = cursor.style.mod_angle
		draw_set_font(cursor.style.font)
		draw_set_color(cursor.style.s_color)
		draw_set_alpha(cursor.style.alpha)
		draw_text_transformed(draw_x, draw_y, cursor.content, scale_x, scale_y, angle)
		cursor = cursor.next
	}
	draw_set_color(c_fuchsia)
	draw_rectangle(X, Y, X + tds.max_width, Y + 1000, true)
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
