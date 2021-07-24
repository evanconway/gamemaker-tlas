function tds_draw(tds, X, Y) {
	__tds_init_characters(tds);
	__tds_update_fx(tds);
	__tds_draw_characters(tds, X, Y);
}

function __tds_init_characters(tds) {
	for (var i = 0; i < array_length(tds.characters); i++) {
		__tds_character_init(tds.characters[@ i]);
	}
}

function __tds_update_fx(tds) {
	for (var i = 0; i < array_length(tds.fx); i++) {
		tds.fx[@ i].update();
	}
}

function __tds_draw_characters(tds, X, Y) {
	for (var i = 0; i < array_length(tds.characters); i++) {
		var c = tds.characters[@ i];
		__tds_draw_char(c, X, Y);
		X += (string_width(c.character) * c.scale_x);
	}
}

function __tds_draw_char(char, X, Y) {
	var c_x = char.X + X;
	var c_y = char.Y + Y;
	var c_scale_x = char.scale_x;
	var c_scale_y = char.scale_y;
	var c_char = char.character;
	var c_angle = char.angle;
	draw_set_alpha(char.alpha);
	draw_set_color(char.c_color);
	draw_set_font(char.font);
	draw_text_transformed(c_x, c_y, c_char, c_scale_x, c_scale_y, c_angle);
}
