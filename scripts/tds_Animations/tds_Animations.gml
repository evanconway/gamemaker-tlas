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
	var result = ""
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

function __tds_animation(command, aargs) {
	if (command == "fade") {
		return new __tds_animation_Fade(aargs)
	}
	if (command == "wshake") {
		return new __tds_animation_WShake(aargs)
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
	style = __tds_get_undefined_style()
	command = "fade"
	params = aargs
	alpha_min = global.tds_animation_default_fade_alpha_min
	alpha_max = global.tds_animation_default_fade_alpha_max
	cycle_time = global.tds_animation_default_fade_cycle_time
	if (array_length(aargs) == 3) {
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

global.tds_animation_default_wshake_time = 80
global.tds_animation_default_wshake_magnitude = 2

function __tds_animation_default_wshake(time, magnitude) {
	global.tds_animation_default_wshake_time = time
	global.tds_animation_default_wshake_magnitude = magnitude
}

function __tds_animation_WShake(aargs) constructor {
	style = __tds_get_undefined_style()
	command = "wshake"
	params = aargs
	shake_time = global.tds_animation_default_wshake_time
	shake_magnitude = global.tds_animation_default_wshake_magnitude
	if (array_length(aargs) == 2) {
		shake_time = aargs[@ 0]
		shake_magnitude = aargs[@ 1]
	} else if (array_length(aargs) != 0) {
		show_error("TDS Error: Improper number of args for wshake animation!", true)
	}
	update = function(time_ms) {
		var index_x = floor (time_ms / shake_time)
		var index_y= index_x + 54321
		style.mod_x = floor(shake_magnitude * 2 * __tds_random(index_x)) - shake_magnitude
		style.mod_y = floor(shake_magnitude * 2 * __tds_random(index_y)) - shake_magnitude
	}
}
