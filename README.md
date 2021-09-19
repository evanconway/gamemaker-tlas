# Tag Decorated Strings
A an easy, fast way to make animated text in GameMaker Studio 2. Compatible with all Windows VM, YYC, and HTML5!

This library is a rewrite of another project: https://github.com/AceOfHeart5/Text_Boxes. This new library aims to achieve the same functionality, but with cleaner code, Better performance, clearer features, and an all around better interface.

This library is a work in progress! The features listed may not work correctly yet, and more features will be added later!

# Installation

Once completed I'll host a build on itch.io, but for now you'll need a copy of GameMaker Studio 2 to build the project yourself. Clone/download the project to your machine, open it in GameMaker, then go to Tools > Create Local Package. Use whatever you want for the publisher, display name, and package id fields and add only the Tag Decorated Strings folder to the Asset Package list. Click ok. You now have a GameMaker package which can imported into any of your projects.

# How To Use

Here's an example of how to create and display a Tag Decorated String. First, TDS are structs. Create a new one like you would any other struct:

`my_tds = new Tag_Decorated_String()`

Now set the text of the TDS:

`// tds_set_text(tds, text_string)`
`tds_set_text(my_tds, "The quick brown fox jumps over the lazy dog.")`

Finally, in a draw event, use the draw function to display your TDS:

`// tds_draw(tds, x, y)`
`tds_draw(whatever, 20, 40)`
