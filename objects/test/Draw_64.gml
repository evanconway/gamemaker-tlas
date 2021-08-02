if (keyboard_check_pressed(vk_space)) {
	active = true
}
if (active && array_length(chars) > 0) {
	add_random_char()
	add_random_char()
	add_random_char()
	add_random_char()
}
tds_draw(whatever, 20, 40)
draw_set_color(c_lime)
draw_text(0, 0, fps_real)
