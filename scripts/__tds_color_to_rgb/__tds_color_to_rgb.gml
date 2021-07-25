function __tds_color_to_rgb(command, aargs) {
	if (command == "red") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_red)
		aargs[@ 1] = color_get_green(c_red)
		aargs[@ 2] = color_get_blue(c_red)
		return "rgb"
	}
	if (command == "blue") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_blue)
		aargs[@ 1] = color_get_green(c_blue)
		aargs[@ 2] = color_get_blue(c_blue)
		return "rgb"
	}
	if (command == "green") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_green)
		aargs[@ 1] = color_get_green(c_green)
		aargs[@ 2] = color_get_blue(c_green)
		return "rgb"
	}
	if (command == "yellow") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_yellow)
		aargs[@ 1] = color_get_green(c_yellow)
		aargs[@ 2] = color_get_blue(c_yellow)
		return "rgb"
	}
	if (command == "orange") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_orange)
		aargs[@ 1] = color_get_green(c_orange)
		aargs[@ 2] = color_get_blue(c_orange)
		return "rgb"
	}
	if (command == "purple") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_purple)
		aargs[@ 1] = color_get_green(c_purple)
		aargs[@ 2] = color_get_blue(c_purple)
		return "rgb"
	}
	if (command == "black") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_black)
		aargs[@ 1] = color_get_green(c_black)
		aargs[@ 2] = color_get_blue(c_black)
		return "rgb"
	}
	if (command == "white") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_white)
		aargs[@ 1] = color_get_green(c_white)
		aargs[@ 2] = color_get_blue(c_white)
		return "rgb"
	}
	if (command == "gray" || command == "grey") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_gray)
		aargs[@ 1] = color_get_green(c_gray)
		aargs[@ 2] = color_get_blue(c_gray)
		return "rgb"
	}
	if (command == "ltgray" || command == "ltgrey") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_ltgray)
		aargs[@ 1] = color_get_green(c_ltgray)
		aargs[@ 2] = color_get_blue(c_ltgray)
		return "rgb"
	}
	if (command == "dkgray" || command == "dkgrey") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_dkgray)
		aargs[@ 1] = color_get_green(c_dkgray)
		aargs[@ 2] = color_get_blue(c_dkgray)
		return "rgb"
	}
	if (command == "teal") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_teal)
		aargs[@ 1] = color_get_green(c_teal)
		aargs[@ 2] = color_get_blue(c_teal)
		return "rgb"
	}
	if (command == "aqua") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_aqua)
		aargs[@ 1] = color_get_green(c_aqua)
		aargs[@ 2] = color_get_blue(c_aqua)
		return "rgb"
	}
	if (command == "fuchsia") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_fuchsia)
		aargs[@ 1] = color_get_green(c_fuchsia)
		aargs[@ 2] = color_get_blue(c_fuchsia)
		return "rgb"
	}
	if (command == "lime") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_lime)
		aargs[@ 1] = color_get_green(c_lime)
		aargs[@ 2] = color_get_blue(c_lime)
		return "rgb"
	}
	if (command == "maroon") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_maroon)
		aargs[@ 1] = color_get_green(c_maroon)
		aargs[@ 2] = color_get_blue(c_maroon)
		return "rgb"
	}
	if (command == "navy") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_navy)
		aargs[@ 1] = color_get_green(c_navy)
		aargs[@ 2] = color_get_blue(c_navy)
		return "rgb"
	}
	if (command == "olive") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_olive)
		aargs[@ 1] = color_get_green(c_olive)
		aargs[@ 2] = color_get_blue(c_olive)
		return "rgb"
	}
	if (command == "silver") {
		array_resize(aargs, 3)
		aargs[@ 0] = color_get_red(c_silver)
		aargs[@ 1] = color_get_green(c_silver)
		aargs[@ 2] = color_get_blue(c_silver)
		return "rgb"
	}
	if (command == "brown") {
		array_resize(aargs, 3)
		aargs[@ 0] = 102
		aargs[@ 1] = 51
		aargs[@ 2] = 0
		return "rgb"
	}
	if (command == "pink") {
		array_resize(aargs, 3)
		aargs[@ 0] = 255
		aargs[@ 1] = 51
		aargs[@ 2] = 255
		return "rgb"
	}
	return command
}