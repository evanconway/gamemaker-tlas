function __tds_fx_entr_fadein(aargs) {
	return {
		char_refs:		[],
		active:			[],
		mod_alpha:		[],
		percent_change:	0.02,
		frame_time_max:	1,
		time:			[],
		add_char_ref:	function(char) {
			array_push(char_refs, char)
			array_push(mod_alpha, 0)
			array_push(time, 0)
			array_push(active, false)
		},
		update:			function() {
			for (var i = 0; i < array_length(char_refs); i++) {
				if (active[@ i]) {
					time[@ i]--
					if (time[@ i] <= 0) {
						time[@ i] = frame_time_max
						mod_alpha[@ i] += percent_change
						if (mod_alpha[@ i] >= 1) {
							mod_alpha[@ i] = 1
						}
					}
					char_refs[@ i].alpha *= mod_alpha
					if (mod_alpha[@ i] == 1) {
						array_delete(char_refs, i, 1)
						array_delete(active, i, 1)
						array_delete(mod_alpha, i, 1)
						array_delete(time, i, 1)
						i--
					}
				}
			}
		}
	}
}

function __tds_get_fx_entr(command, aargs) {
	if (command == "fadein") {
		return new __tds_fx_entr_fadein(aargs)
	}
	show_error("tds error: effect \"" + command + "\" not recognized", true)
}
