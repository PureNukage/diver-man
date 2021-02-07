if stage == 2 {
	var Lerp = 0.05
	var endX = 530
	var endY = 30
	gui_x = lerp(gui_x, endX, Lerp)
	gui_y = lerp(gui_y, endY, Lerp)
	image_xscale = lerp(image_xscale, 0.5, Lerp)
	image_yscale = lerp(image_yscale, 0.5, Lerp)
	draw_sprite_ext(s_coin,0,gui_x,gui_y,image_xscale,image_yscale, 0,c_white,1)
	if point_distance(gui_x,gui_y, endX,endY) < 20 {
		player.gold++
		app.gold++
		instance_destroy()	
	}
}