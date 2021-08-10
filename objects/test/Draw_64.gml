tds_draw(whatever, 20, 40)
draw_set_color(c_lime)
draw_set_font(tds_font_default)
draw_text(0, 0, fps_real)

var red = __tds_chromatic_red_at(counter)
var green = __tds_chromatic_green_at(counter)
var blue = __tds_chromatic_blue_at(counter)
var color = "(" + string(red) + ", " + string(green) + ", " + string(blue) + ")"
draw_set_color(make_color_rgb(red, green, blue))
draw_text(100, 0, color)
counter += 5