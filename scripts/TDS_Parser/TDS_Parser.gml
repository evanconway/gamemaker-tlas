
enum TDS_FX {
	// xy
	XY,
	WAVE,
	FLOAT,
	SHAKE,
	WSHAKE,
	
	// alpha
	ALPHA,
	PULSE,
	BLINK,
	
	// color
	COLOR,
	CHROMATIC,
	
	// font
	FONT,
	
	// rotation
	ROTATION,
	WOBBLE,
	WWOBBLE,
	
	// final enum value is number of enum values
	NUM_OF_FX
}

function tds_string_split(s, delimiter) {
	var result = []
	var delimiter_length = string_length(delimiter)
	for (var i = 1; i <= string_length(s);) {
		var next = string_pos_ext(delimiter, s, i)
		if (next > 0) {
			var substr = string_copy(s, i, next - i)
			if (substr != "") {
				array_push(result, substr)
			}	
			i = next + delimiter_length
		} else {
			array_push(result, string_copy(s, i, string_length(s)))
			i = string_length(s) + 1
		}
	}
	return result
}

// return map of fx structs with settings based on fx_string argument
function tds_parser(fx_string) {
	var result = tds_fx_map_create()
	
	/*
		Commands for fx are given with the syntax: command:argument1,argument2,...
	
		The first step is to create a map of the effects and their arguments.
		The key in the map will be the name of the effect, or the command for
		it. The value will be an array of the arguments the user gave. 
	*/
	var a = tds_string_split(fx_string, " ")
	
	return result
}

// return map of init fx structs
function tds_fx_map_create() {
	var result = ds_map_create()
	
	// xy 
	ds_map_add(result, TDS_FX.XY, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.WAVE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.FLOAT, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.SHAKE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	ds_map_add(result, TDS_FX.WSHAKE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_x:	0,
		mod_y:	0
	})
	
	// alpha
	
	ds_map_add(result, TDS_FX.ALPHA, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_alpha:	0
	})
	
	ds_map_add(result, TDS_FX.PULSE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_alpha:	0
	})
	
	ds_map_add(result, TDS_FX.BLINK, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_alpha:	0
	})
	
	// color
	
	ds_map_add(result, TDS_FX.COLOR, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_color:	0
	})
	
	ds_map_add(result, TDS_FX.CHROMATIC, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_color:	0
	})
	
	// font
	
	ds_map_add(result, TDS_FX.FONT, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_font:	0
	})
	
	// rotation
	
	ds_map_add(result, TDS_FX.ROTATION, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_rotation:	0
	})
	
	ds_map_add(result, TDS_FX.WOBBLE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_rotation:	0
	})
	
	ds_map_add(result, TDS_FX.WWOBBLE, {
		active:	false,
		index:	0,
		update:	function() {
			return false
		},
		mod_rotation:	0
	})

	return result
}
