/*
	Tag Decorated String
	
	Special "strings" that can be changed and animated by html style tags.
*/
function Tag_Decorated_String(source_string) constructor {
	array = array_create(0, undefined)
	
	// effects to be added are stored in arrays
	fx_curr_enter = []
	fx_curr_present = []
	fx_curr_exit = []
	
	for (var i = 0; i < string_length(source_string); i++) {
		// create a special character struct for each character in the string
		// each fx array is a copy of the current fx arrays
		var _char_struct = {
			character:	undefined,
			fx_enter:	fx_curr_enter,
			fx_present:	fx_curr_present,
			fx_exit:	fx_curr_exit
		}
		
		array_push(array, {
			character:			string_char_at(source_string, i + 1), // recall strings 1 based
			fx_enter:		[],
			fx_present:	[],
			fx_exit:		[]
		})
	}
}


function tds_draw(tag_decorated_string, x, y) {
	arr = tag_decorated_string.array
	for (var i = 0; i < array_length(arr); i++) {
		var _char = arr[@ i].character
		draw_text(x, y, _char)
		draw_text_ext_transformed_color()
		x += string_width(_char)
	}
}
