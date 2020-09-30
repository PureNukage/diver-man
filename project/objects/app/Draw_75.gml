if paused {
	draw_set_alpha(0.5)
	draw_set_color(c_black)
	
	var cX = display_get_gui_width()/2
	var cY = display_get_gui_height()/2
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(cX,cY, "PAUSED")
}