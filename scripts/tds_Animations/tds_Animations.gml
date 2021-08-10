function __tds_get_animations(commands, char_index) {
	var result = []
	for (var i = 0; i < array_length(commands); i++) {
		var animation = __tds_get_animation(commands[@ i].command, commands[@ i].aargs, char_index)
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
		array_push(result, __tds_get_animation(a.command, a.params, a.character_index))
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

function __tds_get_animation(command, aargs, char_index) {
	if (command == "fade") {
		return new __tds_animation_Fade(aargs, char_index)
	}
	if (command == "shake") {
		return new __tds_animation_Shake(aargs, char_index)
	}
	if (command == "wshake") {
		return new __tds_animation_WShake(aargs, char_index)
	}
	return undefined
}

function __tds_Animation(name, aargs, char_index) constructor {
	style = __tds_get_undefined_style()
	command = name
	params = aargs
	character_index = char_index
	mergeable = true
}

global.tds_animation_default_fade_alpha_min = 0.3
global.tds_animation_default_fade_alpha_max = 1
global.tds_animation_default_fade_cycle_time = 1000

function tds_animation_default_fade(alpha_min, alpha_max, cycle_time) {
	global.tds_animation_default_fade_alpha_min = alpha_min
	global.tds_animation_default_fade_alpha_max = alpha_max
	global.tds_animation_default_fade_cycle_time = cycle_time
}

function __tds_animation_Fade(aargs, char_index) : __tds_Animation("fade", aargs, char_index) constructor {
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

global.tds_animation_default_shake_time = 80
global.tds_animation_default_shake_magnitude = 1

function __tds_animation_default_shake(time, magnitude) {
	global.tds_animation_default_shake_time = time
	global.tds_animation_default_shake_magnitude = magnitude
}

function __tds_animation_Shake(aargs, char_index) : __tds_Animation("shake", aargs, char_index) constructor {
	mergeable = false
	shake_time = global.tds_animation_default_shake_time
	shake_magnitude = global.tds_animation_default_shake_magnitude
	if (array_length(aargs) == 2) {
		shake_time = aargs[@ 0]
		shake_magnitude = aargs[@ 1]
	} else if (array_length(aargs) != 0) {
		show_error("TDS Error: Improper number of args for shake animation!", true)
	}
	update = function(time_ms) {
		var index_x = floor(time_ms / shake_time) + character_index * 1000
		var index_y= index_x + 4321
		style.mod_x = floor(shake_magnitude * 2 * __tds_random(index_x)) - shake_magnitude
		style.mod_y = floor(shake_magnitude * 2 * __tds_random(index_y)) - shake_magnitude
	}
}

global.tds_animation_default_wshake_time = 80
global.tds_animation_default_wshake_magnitude = 2

function __tds_animation_default_wshake(time, magnitude) {
	global.tds_animation_default_wshake_time = time
	global.tds_animation_default_wshake_magnitude = magnitude
}

function __tds_animation_WShake(aargs, char_index) : __tds_Animation("wshake", aargs, char_index) constructor {
	shake_time = global.tds_animation_default_wshake_time
	shake_magnitude = global.tds_animation_default_wshake_magnitude
	if (array_length(aargs) == 2) {
		shake_time = aargs[@ 0]
		shake_magnitude = aargs[@ 1]
	} else if (array_length(aargs) != 0) {
		show_error("TDS Error: Improper number of args for wshake animation!", true)
	}
	update = function(time_ms) {
		var index_x = floor(time_ms / shake_time) + character_index * 1000
		var index_y= index_x + 4321
		style.mod_x = floor(shake_magnitude * 2 * __tds_random(index_x)) - shake_magnitude
		style.mod_y = floor(shake_magnitude * 2 * __tds_random(index_y)) - shake_magnitude
	}
}