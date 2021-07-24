function tds_draw(tds, X, Y) {
	__tds_init_characters(tds)
	__tds_update_fx(tds)
	for (var i = 0; i < array_length(tds.characters); i++) {
		var c = tds.characters[@ i]
		var c_x = c.X + X
		var c_y = c.Y + Y
		var c_char = c.character
		draw_set_alpha(c.alpha)
		draw_set_color(c.c_color)
		draw_set_font(c.font)
		draw_text_transformed(c_x, c_y, c_char, c.scale_x, c.scale_y, c.angle)
		X += string_width(c_char) * c.scale_x
	}
}

function __tds_init_characters(tds) {
	for (var i = 0; i < array_length(tds.characters); i++) {
		__tds_character_init(tds.characters[@ i])
	}
}

function __tds_update_fx(tds) {
	for (var i = 0; i < array_length(tds.fx); i++) {
		tds.fx[@ i].update()
	}
}
