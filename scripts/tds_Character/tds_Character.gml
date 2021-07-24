function __tds_Character(char) constructor {
	character =	char
	X = 0
	Y = 0
	alpha = 1
	c_color = c_white
	angle = 0
	scale_x = 1
	scale_y = 1
	font = tds_font_default
}

function __tds_character_init(char) {
	char.X = 0
	char.Y = 0
	char.c_color = c_white
	char.angle = 0
	char.scale_x = 1
	char.scale_y = 1
	char.alpha = 1
	char.font = tds_font_default
}
