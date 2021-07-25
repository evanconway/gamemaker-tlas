var str = ""
var add_effects = true
if (add_effects) {
	str += "<shake float fade:0,1,0.01,1 chromatic scale:1.2,0.8 font:f_handwriting>"
}
for (var i = 0; i < 3; i++) {
	str += "The quick brown fox jumps over the lazy dog. "
}
tds_strings = []
for (var i = 0; i < 1; i++) {
	tds_strings[@ i] = new Tag_Decorated_String(str)
}
