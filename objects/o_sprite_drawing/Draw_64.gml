var str = ""

for (var i = 0; i < 1000; i++) {
	str += "$"
}
for (var i = 0; i < 999; i++) {
	str = string_copy(str, 1, string_length(str) - 1)
}

draw_text(0, 0, str)