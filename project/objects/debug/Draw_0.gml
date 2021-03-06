if on {
	
	//	Draw the mask box
	if instance_exists(class_unit) with class_unit {
		//draw_set_color(c_red)
		//draw_set_alpha(0.5)
		//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	}
	
	var border = 256
	var x1 = app.x - app.width/2
	var y1 = app.y - app.height/2
	var x2 = app.x + app.width/2
	var y2 = app.y + app.height/2
	
	var startW = floor(x1/256)
	var startH = floor(y1/256)
	var endW = floor(x2/256) + 1
	var endH = floor(y2/256) + 1
	draw_set_color(c_red)
	
	draw_rectangle(x1,y1,x2,y2,true)
	
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
		
	//	Draw the NPC ground lines
	if instance_exists(class_npc) with class_npc {
		draw_set_color(c_yellow)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		
		draw_set_color(c_aqua)
		draw_rectangle(x-32,groundY-2,x+32,groundY+2,false)	
	}
	
	if instance_exists(class_rock) with class_rock {
		draw_set_color(c_yellow)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		
		draw_set_color(c_aqua)
		draw_rectangle(x-32,groundY-2,x+32,groundY+2,false)		
	}	
	
	//	Draw the player ground lines
	if instance_exists(player) with player {
		draw_set_color(c_yellow)
		//draw_rectangle(x-32,y-2,x+32,y+2,false)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
		
		draw_set_color(c_aqua)
		draw_rectangle(x-32,groundY-2,x+32,groundY+2,false)
		
		//draw_set_color(c_green)
		//draw_rectangle(x-32,groundY+z,x+32,groundY+z+2,false)
		
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
	
	////	Selected unit
	//if selected_unit == -1 {
	//	if input.mouseLeftPress and instance_position(mouse_x,mouse_y,class_rock) {
	//		selected_unit = instance_position(mouse_x,mouse_y,class_rock)	
	//	}
	//}
	//else {
	//	if input.mouseLeftPress selected_unit = -1
		
	//	//	Draw the selected units z_layer
	//	if selected_unit.object_index == mudcrab and selected_unit.map > -1 {
	//		draw_set_alpha(0.5)
	//		var Z = selected_unit.z
	//		if selected_unit.map.ramp {
	//			Z = selected_unit.map.z
	//		}
	//		var Index = grid.return_z_index(Z)
	//		if Index > -1 mp_grid_draw(grid.mp_grids[Index, 0])	
	//	}
	//}
	
	draw_set_alpha(1)
	if instance_exists(collisionMap) with collisionMap {
		//if drawSurface draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,0.5)
		
		//	Draw the height lines
		if !ramp {
			draw_set_color(c_yellow)
			draw_rectangle(bbox_left,bbox_top+height+z,bbox_right,bbox_bottom+height,true)
		
			draw_set_color(c_blue)
			draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom-z,true)
		}
		//	Ramp
		else {
			draw_set_color(c_yellow)
			draw_rectangle(bbox_left,bbox_top+height+z,bbox_right,bbox_bottom+height,true)
			
			draw_set_color(c_blue)
			draw_line(bbox_left,bbox_bottom,bbox_right,bbox_bottom-z)
			draw_set_color(c_red)
			draw_line(bbox_left,bbox_top+z,bbox_right,bbox_top)
		}
	}
	
	////	Draw the height maps
	//var startCellX = floor(camera_get_view_x(app.camera)/grid.cellWidth)
	//var startCellY = floor(camera_get_view_y(app.camera)/grid.cellHeight)
	//var Width = floor(camera_get_view_width(app.camera)/grid.cellWidth)+1
	//var Height = floor(camera_get_view_height(app.camera)/grid.cellHeight)+1
	//draw_set_alpha(0.5)
	//for(var w=startCellX;w<startCellX+Width;w++) {
	//	for(var h=startCellY;h<startCellY+Height;h++) {
	//		if point_in_rectangle(w,h,0,0,grid.gridWidth-1,grid.gridHeight-1) {
	//			var Color = c_white
	//			if grid.cell[w,h].top > 0 {
	//				Color = c_blue
	//				draw_set_alpha(0.5)
	//			}
	//			else draw_set_alpha(0)
	//			draw_set_color(Color)
	//			draw_rectangle(w*grid.cellWidth,h*grid.cellHeight,(w*grid.cellWidth)+grid.cellWidth,(h*grid.cellHeight)+grid.cellHeight,false)	
	//		}
	//	}
	//}
	
	
	//	Draw the grid
	//draw_set_alpha(0.25)
	//mp_grid_draw(grid.mpGrid)
	
	draw_reset()
	
}