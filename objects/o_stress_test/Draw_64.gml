draw_set_font(tds_font_default)
draw_set_color(c_lime)
draw_set_alpha(1)
draw_text(0, 0, fps_real)
for (var i = 0; i < array_length(tds_strings); i++) {
	tds_draw(tds_strings[@ i], 0, 20 + 20 * i)
}
