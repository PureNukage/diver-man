if on {
	
	var XX = 15
	var YY = 15
	draw_set_color(c_black)
	
	draw_text(XX,YY, "mouse_x: "+string(mouse_x)) YY += 15
	draw_text(XX,YY, "mouse_y: "+string(mouse_y)) YY += 15
	
	with player {
		draw_text(XX,YY, "z: "+string(z)) YY += 15
	}
	
}