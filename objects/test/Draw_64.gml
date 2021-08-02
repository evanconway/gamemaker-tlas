if (keyboard_check_pressed(vk_space)) {
	active = true
}
if (active && array_length(chars) > 0) {
	var i = irandom_range(0, array_length(chars) - 1)
	var choice = chars[@ i]
	tds_start_entry_at(whatever, choice)
	array_delete(chars, i, 1)
}
tds_draw(whatever, 20, 40)
draw_set_color(c_lime)
draw_text(0, 0, fps_real)
