function __tds_Character(new_character, new_style, new_line_index, X, Y) constructor {
	character = new_character
	style = __tds_style_copy(new_style)
	char_x = X
	char_y = Y
	draw_set_font(style.font)
	char_width = string_width(character) * style.scale_x
	char_height = string_height(character) * style.scale_y
	line_index = new_line_index
}
