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

`tds_set_text(my_tds, "The quick brown fox jumps over the lazy dog.")`

Finally, in a draw event, use the draw function to display your TDS:

`tds_draw(my_tds, 20, 40)`

# Tags

Tag Decorated Strings, as the name suggests, can be decorated/styled/animated with html style tags. The format for tags is always <command:var1,var2,var3,...>. All styles/animations for a TDS are reset with an empty tag <>

## color
`<color>`
The following colors are recognized by TDS: red, blue, green, yellow, orange, purple, black, white, grey, ltgrey, dkgrey, teal, aqua, fuchsia, lime, maroon, navy, olive, silver, brown, and pink.

## rgb
`<rgb:red_int, green_int, blue_int>`
For any colors not listed above, a rgb color can be chosen with this tag.

## font
`<font:font_asset_name>`

## scale
`<scale:x_scale,y_scale>`

## angle
`<angle:angle_degrees>`

## alpha
`<alpha:alpha_int>`

## offset
`<offset:x_offset,y_offset>`

## fade
`<fade:alpha_min,alpha_max,cycle_time_ms>`

## shake
`<shake:time_ms,magnitude>`

## tremble
`<tremble:time_ms,magnitude>`

## chromatic
`<chromatic:change_ms,steps_per_change,char_offset>`

## wchromatic
`<wchromatic:change_ms,steps_per_change>`

## wave
`<wave:change_ms,magnitude,char_offset>`

## float
`<float:change_ms,magnitude>`

## wobble
`<wobble:cycle_time,max_angle>`
