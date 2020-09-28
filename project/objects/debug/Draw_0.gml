if on {
	
	if instance_exists(class_unit) with class_unit {
		draw_set_color(c_red)
		draw_set_alpha(0.5)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	}
	
	if instance_exists(class_enemy) with class_enemy {
		draw_set_color(c_white)
		draw_set_alpha(1)
		draw_path(path, groundX,groundY, true)
		
		var xx = x - 30
		var yy = y - 30
		draw_text(xx,yy, "x: "+string(x)) yy += 15
		draw_text(xx,yy, "y: "+string(y)) yy += 15
	}
	
	draw_set_alpha(0.25)
	mp_grid_draw(grid.mpGrid)
	
	draw_reset()
	
}