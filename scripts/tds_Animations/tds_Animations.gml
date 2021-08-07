function __tds_get_animations(commands) {
	var result = []
	for (var i = 0; i < array_length(commands); i++) {
		var animation = __tds_animation(commands[@ i].command, commands[@ i].aargs)
		if (animation != undefined) {
			array_push(result, animation)
		}
	}
	return result
}

function __tds_animation(command, aargs) {
	if (command == "fade") {
		return new __tds_animation_Fade(aargs)
	}
	return undefined
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
	command = "fade"
	params = aargs
	style = temp
	update = function() {
		style.alpha = 0.3
	}
}

function __tds_animations_copy(animations) {
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
	var result = ""
	for (var i = 0; i < array_length(animations); i++) {
		var a = animations[@ i]
		result += a.command
		result += __tds_aargs_tostring(a.params)
	}
	return result
}