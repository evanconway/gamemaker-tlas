source = "Call me <red>Ishmael<>. <alpha:0.5>Some years ago<>-<font:f_handwriting offset:0,-2>never mind how long precisely<>-having little or no <yellow float:1,3>money<> in my purse, and nothing <fade>particular<> to <shake>interest<> me on shore, I thought I would sail about a little and see the <aqua>watery part of the world<>. It is a way I have of driving off the spleen and regulating the <wshake>circulation<>. Whenever I find myself growing grim about the mouth; whenever it is a damp, drizzly November in my soul; whenever I find myself involuntarily pausing before coffin warehouses, and bringing up the rear of every funeral I meet; and especially whenever my hypos get such an upper hand of me, that it requires a strong moral principle to prevent me from deliberately stepping into the street, and methodically knocking people's hats off-then, I account it high time to get to sea as soon as I can. This is my substitute for pistol and ball. With a philosophical flourish Cato throws himself upon his sword; I quietly take to the ship. There is nothing surprising in this. If they but knew it, almost all men in their degree, some time or other, cherish very nearly the same feelings towards the ocean with me."
whatever = new Tag_Decorated_String()
tds_set_text(whatever, source)
tds_set_drawable_on_settext(whatever, true)
chars = array_create(tds_get_characters_size(whatever), 0)
for (var i = 0; i < array_length(chars); i++) {
	chars[@ i] = i
}
active = false

cursor = 0
function add_next() {
	if (cursor < array_length(chars)) {
		tds_start_entry_at(whatever, cursor)
		cursor++
	}
}

function add_random_char() {
	if (array_length(chars) <= 0) {
		return
	}
	var i = irandom_range(0, array_length(chars) - 1)
	var choice = chars[@ i]
	tds_start_entry_at(whatever, choice)
	array_delete(chars, i, 1)
}
