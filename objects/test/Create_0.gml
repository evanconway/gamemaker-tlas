/// @description Insert description here
// You can write your code in this editor

massive_string = ""
for (var i = 0; i < 10; i ++) {
	massive_string += "The <wshake>quick<> brown fox <shake>jumps<> over the lazy dog."
}

//thing = new Tag_Decorated_String("The quick brown fox <shake>jumps<> over the lazy dog. Let's go to the ocean. <shake:3,1 wshake:10,10>Surfing<> <wshake>waves<> is super fun!")
thing = new Tag_Decorated_String(massive_string)
