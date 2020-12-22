on = false

function log(String) {
	
	var Time = "[" + string(time.stream) + "] "
	
	var Object = string_upper(object_get_name(other.object_index))
	
	var fullMessage = Time + Object + " " + String
	
	show_debug_message(fullMessage)
}
	
function draw_button_ext(x,y,width,height,text) {
	
	var clicked = false
	
	draw_set_color(c_black)
	draw_rectangle(x-2,y-2,x+width+2,y+height+2,false)
	
	if point_in_rectangle(mouse_gui_x,mouse_gui_y, x,y,x+width,y+height) {
		draw_set_color(c_ltgray)
		if input.mouseLeftPress {
			clicked = true	
		}
	} else {
		draw_set_color(c_gray)
	}
	draw_rectangle(x,y,x+width,y+height,false)
	
	draw_set_color(c_black)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(x+width/2,y+height/2,text)
	
	return clicked
}