function __tds_get_animations(commands) {
	var result = []
	for (var i = 0; i < array_length(commands); i++) {
		var animation = __tds_animation(commands[@ i].command, commands[@ i].aargs)
		if (animation != undefined) {
			array_push(result, animation)
		}
	}
	if (array_length(result) <= 0) {
		result = undefined
	}
	return result
}

function __tds_animation(command, aargs) {
	if (command == "fade") {
		return new __tds_animation_Fade(aargs)
	}
	return undefined
}

global.tds_animation_default_fade_alpha_min = 0.3
global.tds_animation_default_fade_alpha_max = 1
global.tds_animation_default_fade_cycle_time = 1000
function tds_animation_default_fade(alpha_min, alpha_max, cycle_time) {
	global.tds_animation_default_fade_alpha_min = alpha_min
	global.tds_animation_default_fade_alpha_max = alpha_max
	global.tds_animation_default_fade_cycle_time = cycle_time
}

function __tds_animation_Fade(aargs) constructor {
	var temp = new __tds_Style()
	temp.font = undefined
	temp.s_color = undefined
	temp.alpha= undefined
	temp.scale_x = undefined
	temp.scale_y = undefined
	temp.mod_x = undefined
	temp.mod_y = undefined
	temp.mod_angle = undefined
	style = temp
	command = "fade"
	params = aargs
	alpha_min = global.tds_animation_default_fade_alpha_min
	alpha_max = global.tds_animation_default_fade_alpha_max
	cycle_time = global.tds_animation_default_fade_cycle_time
	if (array_length(aargs) == 2) {
		alpha_min = aargs[@ 0]
		alpha_max = aargs[@ 1]
	} else if (array_length(aargs) == 3) {
		alpha_min = aargs[@ 0]
		alpha_max = aargs[@ 1]
		cycle_time = aargs[@ 2]
	} else if (array_length(aargs) != 0) {
		show_error("TDS Error: Improper number of args for fade animation!", true)
	}
	update = function(time_ms) {
		var check = time_ms % (cycle_time * 2)
		if (check <= cycle_time) {
			check = cycle_time - check
		} else {
			check -= cycle_time
		}
		var new_alpha = alpha_min + check/cycle_time * (alpha_max - alpha_min)
		style.alpha = new_alpha
	}
}

function __tds_animations_copy(animations) {
	if (animations == undefined) {
		return undefined
	}
	var result = []
	for (var i = 0; i < array_length(animations); i++) {
		var a = animations[@ i]
		array_push(result, __tds_animation(a.command, a.params))
	}
	return result
}

function __tds_aargs_tostring(aargs) {
	result = ""
	for (var i = 0; i < array_length(aargs); i++) {
		result += string(aargs[@ i])
	}
	return result
}

function __tds_animation_hash(animations) {
	if (animations == undefined) {
		return ""
	}
	var result = ""
	for (var i = 0; i < array_length(animations); i++) {
		var a = animations[@ i]
		result += a.command
		result += __tds_aargs_tostring(a.params)
	}
	return result
}