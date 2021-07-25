function tds_draw(tds, X, Y) {
	__tds_update_fx(tds)
	__tds_draw_characters(tds, X, Y)
}

function __tds_update_fx(tds) {
	for (var i = 0; i < array_length(tds.fx); i++) {
		tds.fx[@ i].update()
	}
}

function __tds_draw_characters(tds, X, Y) {
	for (var i = 0; i < array_length(tds.characters); i++) {
		__tds_draw_char( tds.characters[@ i], X, Y)	
		if ( tds.characters[@ i].sprite == undefined) {
			X += string_width(tds.characters[@ i].character) * tds.characters[@ i].scale_x
		} else {
			X += sprite_get_width(tds.characters[@ i].sprite) * tds.characters[@ i].scale_x
		}
		__tds_character_init(tds.characters[@ i])
	}
}

function __tds_draw_char(char, X, Y) {
	draw_set_alpha(char.alpha)
	draw_set_color(char.c_color)
	draw_set_font(char.font)
	if (char.sprite == undefined) {
		draw_text_transformed(
			char.X + X,
			char.Y + Y,
			char.character,
			char.scale_x,
			char.scale_y,
			char.angle
		)
	} else {
		draw_sprite_ext(
			char.sprite, 
			0, 
			char.X + X, 
			char.Y + Y, 
			char.scale_x, 
			char.scale_y, 
			char.angle, 
			char.c_color, 
			char.alpha
		)
	}
}
