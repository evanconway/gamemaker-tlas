function Tag_Decorated_String() constructor {
	source = ""
	characters = []
	default_style = new __tds_Style()
	max_width = 500
	drawables = undefined
	create_drawables_on_set_text = true
	update_time_ms = 0
}

function tds_set_drawable_on_settext(tds, boolean) {
	tds.create_drawables_on_set_text = boolean
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
		var commands = []
		var style = default_style
		var animations = undefined // could be array
		for (var i = 1; i <= string_length(source); i++) {
			var char = string_char_at(source, i)
			if (char == "<") {
				commands = __tds_get_commands_at(i)
				i = string_pos_ext(">", source, i)
			} else {
				style = __tds_get_style(default_style, commands)
				animations = __tds_get_animations(commands, i)
				var c = new __tds_Character(char, style, animations, line_index)
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

function __tds_Drawable(char_index, character) constructor {
	previous = undefined
	next = undefined
	i_start = char_index
	i_end = char_index
	content = character.character
	style = __tds_style_copy(character.style)
	animations = __tds_animations_copy(character.animations)
	anim_hash = __tds_animation_hash(animations)
	mergeable = true
	for (var i = 0; i < array_length(animations); i++) {
		if (!animations[@ i].mergeable) {
			mergeable = false
			i = array_length(animations)
		}
	}
	update = function() {
	
	}
}

function __tds_drawables_add(char_index) {
	var c = characters[@ char_index]
	if (c.added) {
		return
	}
	c.added = true
	var drawable = new __tds_Drawable(char_index, c)
	if (drawables == undefined) {
		drawables = drawable
		return
	}
	__tds_drawable_merge_bothsides(drawable)
}

function __tds_drawable_merge_bothsides(drawable) {
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
	while (drawables.previous != undefined) {
		drawables = drawables.previous
	}
}

function __tds_drawable_merge(a, b) {
	if (a == undefined || b == undefined) {
		return false
	}
	if (!a.mergeable || !b.mergeable) {
		return false
	}
	if (a.anim_hash != b.anim_hash) {
		return false
	}
	if (characters[@ a.i_start].line_index != characters[@ b.i_start].line_index) {
		return false
	}
	if (a.i_end != b.i_start - 1) {
		return false
	}
	if (!__tds_style_equal(a.style, b.style)) {
		return false
	}
	a.content += b.content
	a.i_end += (b.i_end - b.i_start + 1)
	a.next = b.next
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

function __tds_drawable_init(drawable) {
	var c = characters[@ drawable.i_start]
	drawable.style.mod_angle = c.style.mod_angle
	drawable.style.s_color = c.style.s_color
	drawable.style.font = c.style.font
	drawable.style.alpha = c.style.alpha
	drawable.style.mod_x = c.style.mod_x
	drawable.style.mod_y = c.style.mod_y
	drawable.style.scale_x = c.style.scale_x
	drawable.style.scale_y = c.style.scale_y
}

function __tds_drawable_update(drawable) {
	if (drawable.animations == undefined) {
		return
	}
	__tds_drawable_init(drawable)
	for (var i = 0; i < array_length(drawable.animations); i++) {
		drawable.animations[@ i].update(update_time_ms)
		var s = drawable.animations[@ i].style
		if (s.mod_angle != undefined) {
			drawable.style.mod_angle += s.mod_angle
		}
		if (s.s_color != undefined) {
			drawable.style.s_color = s.s_color
		}
		if (s.font != undefined) {
			drawable.style.font = s.font
		}
		if (s.alpha != undefined) {
			drawable.style.alpha *= s.alpha
		}
		if (s.mod_x != undefined) {
			drawable.style.mod_x += s.mod_x
		}
		if (s.mod_y != undefined) {
			drawable.style.mod_y += s.mod_y
		}
		if (s.scale_x != undefined) {
			drawable.style.scale_x *= s.scale_x
		}
		if (s.scale_y != undefined) {
			drawable.style.scale_y *= s.scale_y
		}
	}
}

function tds_update_custom_time(tds, time_ms) {
	with (tds) {
		update_time_ms += time_ms
		var cursor = drawables
		while (cursor != undefined) {
			__tds_drawable_update(cursor)
			cursor = cursor.next
		}
	}
}

function tds_update(tds) {
	tds_update_custom_time(tds, 1000 / 60)
}

function tds_draw_no_update(tds, X, Y) {
	with (tds) {
		var cursor = drawables
		while (cursor != undefined) {
			var char_x = characters[@ cursor.i_start].char_x
			var char_y = characters[@ cursor.i_start].char_y
			var style_x = cursor.style.mod_x
			var style_y = cursor.style.mod_y
			var scale_x = cursor.style.scale_x
			var scale_y = cursor.style.scale_y
			var draw_x = X + char_x + style_x
			var draw_y = Y + char_y + style_y
			var angle = cursor.style.mod_angle
			draw_set_font(cursor.style.font)
			draw_set_color(cursor.style.s_color)
			draw_set_alpha(cursor.style.alpha)
			draw_text_transformed(draw_x, draw_y, cursor.content, scale_x, scale_y, angle)
			cursor = cursor.next
		}
		draw_set_color(c_fuchsia)
		draw_rectangle(X, Y, X + max_width, Y + 480, true)
	}
}

function tds_draw(tds, X, Y) {
	tds_update(tds)
	tds_draw_no_update(tds, X, Y)
}

function __tds_get_commands_at(start_i) {
	var end_i = string_pos_ext(">", source, start_i)
	var commands_all = string_copy(source, start_i + 1, end_i - start_i - 1)
	var commands_indv = __tds_string_split(commands_all, " ")
	var result = array_create(array_length(commands_indv), undefined)
	for (var i = 0; i < array_length(commands_indv); i++) {
		var command_and_aargs = __tds_string_split(commands_indv[@ i], ":")
		var c = command_and_aargs[@ 0]
		var a = []
		if (array_length(command_and_aargs) > 1) {
			a = __tds_string_split(command_and_aargs[@ 1], ",")
			__tds_arr_string_to_nums(a)
		}
		result[@ i] = {
			command:	c,
			aargs:		a
		}
	}
	return result
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

function __tds_arr_string_to_nums(array) {
	for (var i = 0; i < array_length(array); i++) {
		try {
			var number = real(array[@ i])
			array[@ i] = number
		} catch (e) {
			// do nothing
		}
	}
}