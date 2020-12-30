if on {
	
	//	Draw the mask box
	if instance_exists(class_unit) with class_unit {
		//draw_set_color(c_red)
		//draw_set_alpha(0.5)
		//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	}
	
	//	Draw the enemies path
	if instance_exists(class_enemy) with class_enemy {
		draw_set_color(c_white)
		draw_set_alpha(1)
		draw_path(path, groundX,groundY, true)
		
		var xx = x - 30
		var yy = y - 30
		draw_text(xx,yy, "x: "+string(x)) yy += 15
		draw_text(xx,yy, "y: "+string(y)) yy += 15
	}
	
	//	Draw the player ground lines
	if instance_exists(player) with player {
		draw_set_color(c_yellow)
		draw_rectangle(x-32,y-z-2,x+32,y-z+2,false)
		
		draw_set_color(c_aqua)
		draw_rectangle(x-32,groundY-2,x+32,groundY+2,false)
		
		////	Draw attack hitbox
		if state == state.attack {
			var x1 = x - sprite_get_xoffset(sprite_index) + sprite_get_bbox_left(sprite_index)
			var y1 = y - sprite_get_yoffset(sprite_index) + sprite_get_bbox_top(sprite_index)
			var x2 = x1 + sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)
			var y2 = y1 + sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)
			draw_rectangle(x1,y1, x2,y2, false)	
		}
	}
	
	//	Draw rock collisionMaps
	//if instance_exists(class_rock) with class_rock if instance_exists(heightMap) with heightMap {
	//	draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,0.5)
	//}
	
	if instance_exists(collisionMap) with collisionMap {
		draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,0.5)	
	}
	
	//	Draw the grid
	//draw_set_alpha(0.25)
	//mp_grid_draw(grid.mpGrid)
	
	draw_reset()
	
}