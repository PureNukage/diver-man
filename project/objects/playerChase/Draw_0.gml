//	If we're dancing, draw the ring
if dancing {
	draw_set_color(c_black)
	draw_set_alpha(0.2)
	var width = 120
	var height = 90
	draw_ellipse(x-width/2,y-height/2,x+width/2,y+height/2, false)
}

draw_shadow()

draw_unit()

//	We're in the shade
if place_meeting(groundX,y,shade) and !muted {
	draw_shade()
}

//	DEBUG
if debug.on {
	draw_set_alpha(1)
	draw_set_color(c_black)
	draw_text(x,y-70,string(backgroundX))
}