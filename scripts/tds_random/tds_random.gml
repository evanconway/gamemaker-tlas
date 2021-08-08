global.tds_animation_random_array = array_create(1000000, 0)
for (var i = 0; i < array_length(global.tds_animation_random_array); i++) {
	global.tds_animation_random_array[@ i] = random(1)
}

function __tds_random(value) {
	value %= array_length(global.tds_animation_random_array)
	return global.tds_animation_random_array[@ floor(value)]
}
