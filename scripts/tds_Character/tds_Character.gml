function __tds_Character(new_character, new_style, new_animations, new_line_index) constructor {
	character = new_character
	added = false
	style = __tds_style_copy(new_style)
	char_x = 0
	char_y = 0
	draw_set_font(style.font)
	char_width = string_width(character) * style.scale_x
	char_height = string_height(character) * style.scale_y
	line_index = new_line_index
	animations = new_animations
	sprite = undefined
}

function __tds_character_set_sprite(character, sprite) {
	character.sprite = sprite
	character.char_width = sprite_get_width(sprite) * character.style.scale_x
	character.char_height = sprite_get_height(sprite) * character.style.scale_y
}
