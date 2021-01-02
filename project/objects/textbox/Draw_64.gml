if live_call() return live_result

var widthSpacer = 20
var heightSpacer = 40
draw_set_font(font_dialogue)
var width = string_width(text) + widthSpacer*2
//if width > 558 width = 558
width = 558
var height = string_height_ext(text,string_height(text),width-(widthSpacer*2)) + heightSpacer*2
var xx = display_get_gui_width()/2 - width/2
var yy = display_get_gui_height() - height - heightSpacer

draw_nine_tile(s_parchment_9slice, width, height, xx, yy, string(string_copy(text,1,textIndex)))

var surface = surface_create(display_get_gui_width(),display_get_gui_height())
surface_set_target(surface)
draw_clear_alpha(c_black, 0)

var pixels = 42
var tilesWidth = ceil(width / pixels)
var tilesHeight = ceil(height / pixels)

draw_set_color(c_black)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_ext(xx+(tilesWidth*pixels)/2, yy+(tilesHeight*pixels)/2, text, string_height(text), width)

var textWidth = string_width_ext(text,string_height(text),width)
var textHeight = string_height_ext(text,string_height(text),width)
var _x = (xx+(tilesWidth*pixels)/2) - (textWidth/2)
var _y = (yy+(tilesHeight*pixels)/2) - (textHeight/2)
var _xx = _x + textWidth
var _yy = _y + textHeight

var rows = textHeight / string_height(text)
var array = [[]]
draw_set_color(c_red)
for(var i=0;i<rows;i++) {
	if i < rows-1 array[i, 0] = string_width_ext(text,string_height(text),width)
	//else array[i, 0] = abs(string_width_ext(text,string_height(text),width) - (i*string_width(text)))
	else array[i, 0] = (string_width(text) - (i*string_width_ext(text,string_height(text),width)))
	//else array[i, 0] = string_width_ext(text,string_height(text),width)
	//debug.log(string(i) + ": "+string(array[i,0]))
	
	_x = (xx+(tilesWidth*pixels)/2) - (array[i,0]/2)
	//draw_rectangle(_x,_y,_x+array[i,0],_y+string_height(text)-2,true)
	_y += string_height(text)-2
}

//draw_set_color(c_red)
//draw_rectangle(_x,_y,_xx,_yy,true)

gpu_set_blendmode(bm_subtract)
var _x = (xx+(tilesWidth*pixels)/2) - (textWidth/2)
var _y = (yy+(tilesHeight*pixels)/2) - (textHeight/2)
var _xx = _x + textWidth
var _yy = _y + textHeight
var row = 0
for(var i=0;i<string_length(text);i++) {
	
	//draw_set_color(c_green)
	var startX = xx + (tilesWidth*pixels/2) - (array[row,0]/2)
	//var startY = (yy+(tilesHeight*pixels)/2) - textHeight/2 + (row*string_height(text))
	//draw_rectangle(startX,startY,startX,startY+string_height(text)-2,true)
	
	var endX = startX + array[row,0]
	//draw_rectangle(endX,startY,endX,startY+string_height(text)-2,true)
	
	//draw_set_color(c_blue)
	var letter_width = string_width(text)/string_length(text)
	var letter_height = string_height(text)-2
	if i > textIndex {
		draw_rectangle(_x,_y,_x+letter_width-1,_y+letter_height,false)
	}
	_x += letter_width
	if rows > 1 and (_x > endX-letter_width) and row < rows-1 {
		row++
		_x = (xx+(tilesWidth*pixels/2) - (array[row,0]/2))
		_y += letter_height+2
	}
}
gpu_set_blendmode(bm_normal)

surface_reset_target()
draw_surface(surface,0,0)
surface_free(surface)

var scale = 5
var sprite = ID.myDialogue[2, ID.dialogueIndex]
draw_sprite_ext(sprite,0, xx,yy-sprite_get_height(sprite)*scale, scale,scale, 0,c_white,1)

draw_reset()
