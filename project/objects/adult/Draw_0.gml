event_inherited()

//	Draw the completion bar
if payingAttention {
	
	var width = 64
	var height = 20
	var xx = x - 32
	var yy = y-sprite_get_height(sprite_index)
	
	draw_set_color(c_black)
	draw_rectangle(xx,yy,xx+width,yy+height,false)
	var Width = (completion / 100) * width
	draw_set_color(c_green)
	draw_rectangle(xx,yy,xx+Width,yy+height,false)
}