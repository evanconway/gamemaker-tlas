global.tds_animation_random_array = array_create(1000000, 0)
for (var i = 0; i < array_length(global.tds_animation_random_array); i++) {
	global.tds_animation_random_array[@ i] = random(1)
}

function __tds_random(value) {
	value %= array_length(global.tds_animation_random_array)
	return global.tds_animation_random_array[@ floor(value)]
}

function __tds_chromatic_red_at(index) {
	index %= 1536
	if (index >= 0 && index < 256) {
		return 255
	}
	if (index >= 256 && index < 512) {
		return 511 - index
	}
	if (index >= 512 && index < 768) {
		return 0
	}
	if (index >= 768 && index < 1024) {
		return 0
	}
	if (index >= 1024 && index < 1280) {
		return index - 1024
	}
	if (index >= 1280 && index < 1536) {
		return 255
	}
}

function __tds_chromatic_green_at(index) {
	index %= 1536
	if (index >= 0 && index < 256) {
		return index
	}
	if (index >= 256 && index < 512) {
		return 255
	}
	if (index >= 512 && index < 768) {
		return 255
	}
	if (index >= 768 && index < 1024) {
		return 1023 - index
	}
	if (index >= 1024 && index < 1280) {
		return 0
	}
	if (index >= 1280 && index < 1536) {
		return 0
	}
}

function __tds_chromatic_blue_at(index) {
	index %= 1536
	if (index >= 0 && index < 256) {
		return 0
	}
	if (index >= 256 && index < 512) {
		return 0
	}
	if (index >= 512 && index < 768) {
		return index - 512
	}
	if (index >= 768 && index < 1024) {
		return 255
	}
	if (index >= 1024 && index < 1280) {
		return 255
	}
	if (index >= 1280 && index < 1536) {
		return 1535 - index
	}
}
