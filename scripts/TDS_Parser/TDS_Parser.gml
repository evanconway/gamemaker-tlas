
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

// return map of fx structs with settings based on fx_string argument
function tds_parser(fx_string) {
	var result = tds_fx_map_create()
	
	
	
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
