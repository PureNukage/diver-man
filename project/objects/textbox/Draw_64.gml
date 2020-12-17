var widthSpacer = 20
var heightSpacer = 40
draw_set_font(font_dialogue)
var width = string_width(text) + widthSpacer*2
//if width > 558 width = 558
width = 558
var height = string_height(text) + heightSpacer*2
var xx = display_get_gui_width()/2 - width/2
var yy = display_get_gui_height() - height - heightSpacer

draw_nine_tile(s_parchment_9slice, width, height, xx, yy, string(string_copy(text,1,textIndex)))

var scale = 5
var sprite = ID.myDialogue[2, ID.dialogueIndex]
draw_sprite_ext(sprite,0, xx-sprite_get_width(sprite)*scale/4,yy-sprite_get_height(sprite)*scale/2, scale,scale, 0,c_white,1)

draw_reset()
