var widthSpacer = 20
var heightSpacer = 40
draw_set_font(font_dialogue)
var width = string_width(text) + widthSpacer*2
//if width > 558 width = 558
width = 558
var height = string_height(text) + heightSpacer*2
var xx = display_get_gui_width()/2 - width/2
var yy = display_get_gui_height() - height - heightSpacer

//draw_set_color(c_black)
//draw_rectangle(xx-2,yy-2, xx+width+2,yy+height+2, false)
//draw_set_color(c_dkgray)
//draw_rectangle(xx,yy, xx+width,yy+height, false)

var pixels = 42
var tilesWidth = ceil(width / pixels)
var tilesHeight = ceil(height / pixels)
var XX = xx
var YY = yy
//debug.log(string(tilesWidth))
//debug.log(string(tilesHeight))
for(var w=0;w<tilesWidth;w++) {
	for(var h=0;h<tilesHeight;h++) {
		//	Top left corner
		if w == 0 and h == 0 {
			draw_sprite_part(s_parchment_9slice,0, 0,0,pixels,pixels, XX,YY)
		}
		//	Top piece
		else if w > 0 and w < tilesWidth-1 and h == 0 {
			draw_sprite_part(s_parchment_9slice,0, pixels,0, pixels,pixels, XX,YY)
		}
		//	Top right corner
		else if w == tilesWidth-1 and h == 0 {
			draw_sprite_part(s_parchment_9slice,0, pixels*2+2,0, pixels,pixels, XX,YY)	
		}
		//	Left side piece
		else if w == 0 and h > 0 and h < tilesHeight-1 {
			draw_sprite_part(s_parchment_9slice,0, 0,pixels, pixels,pixels, XX,YY)	
		}
		//	Bottom left corner
		else if w == 0 and h == tilesHeight-1 {
			draw_sprite_part(s_parchment_9slice,0, 0,pixels*2+2, pixels,pixels, XX,YY)		
		}
		//	Bottom piece
		else if w > 0 and w < tilesWidth-1 and h == tilesHeight-1 {
			draw_sprite_part(s_parchment_9slice,0, pixels,pixels*2+2, pixels,pixels, XX,YY)		
		}
		//	Bottom right corner
		else if w == tilesWidth-1 and h == tilesHeight-1 {
			draw_sprite_part(s_parchment_9slice,0, pixels*2+2,pixels*2+2, pixels,pixels, XX,YY)	
		}
		//	Right side piece
		else if w == tilesWidth-1 and h < tilesHeight-1 and h > 0 {
			draw_sprite_part(s_parchment_9slice,0, pixels*2+2,pixels*1, pixels,pixels, XX,YY)		
		}
		//	Center tile
		else {
			draw_sprite_part(s_parchment_9slice,0, pixels,pixels, pixels,pixels, XX,YY)		
		}
		YY += pixels
	}
	YY = yy
	XX += pixels
}

draw_set_color(c_black)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
var String = string(string_copy(text,1, textIndex))
//draw_text(xx+(tilesWidth*pixels)/2, yy+(tilesHeight*pixels)/2, string(string_copy(text,1, textIndex)))
draw_text_ext(xx+(tilesWidth*pixels)/2, yy+(tilesHeight*pixels)/2, String, string_height(String), 430)

var scale = 5
var sprite = ID.myDialogue[2, ID.dialogueIndex]
draw_sprite_ext(sprite,0, xx-sprite_get_width(sprite)*scale/4,yy-sprite_get_height(sprite)*scale/2, scale,scale, 0,c_white,1)

draw_reset()
