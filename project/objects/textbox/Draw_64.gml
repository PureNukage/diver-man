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

//draw_set_color(c_blue)
gpu_set_blendmode(bm_subtract)
var index = 0
for(var i=0;i<array_length(rows);i++) {
	//if i == 0 {
		var _startX = xx + (tilesWidth*pixels)/2 - string_width(rows[i])/2
		var _startY = yy + (tilesHeight*pixels)/2 - (string_height(text)*array_length(rows))/2
		//draw_line(_startX,_startY,_startX,_startY+string_height(text)) - ((array_length(rows)-1 - i)*string_height(text))
		
		var letter_width = string_width(rows[i])/string_length(rows[i])
		var letter_height = string_height(text)
		
		for(var c=0;c<string_length(rows[i]);c++) {
			var _x = _startX + (c * letter_width)	
			var _y = _startY + (i*letter_height)
			
			if textIndex < index 
			draw_rectangle(_x,_y,_x+letter_width-1,_y+letter_height-2,false)
			index++
		}
		
	//}
}
gpu_set_blendmode(bm_normal)

surface_reset_target()
draw_surface(surface,0,0)
surface_free(surface)

var scale = 5
var sprite = ID.myDialogue[2, ID.dialogueIndex]
draw_sprite_ext(sprite,0, xx,yy-sprite_get_height(sprite)*scale, scale,scale, 0,c_white,1)

draw_reset()
