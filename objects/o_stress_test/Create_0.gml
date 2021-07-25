var str = "<shake float fade chromatic font:f_handwriting>"
for (var i = 0; i < 3; i++) {
	str += "The quick brown fox jumps over the lazy dog. "
}
tds_strings = []
for (var i = 0; i < 36; i++) {
	tds_strings[@ i] = new Tag_Decorated_String(str)
}
