if on {
	
	////	256x256 Caustic Shader Tile
	var Width = 256
	var Height = 256
	
	//var loopAmount = 120
	//if time.stream <= loopAmount surface_save(surface,"causticSurface"+string(time.stream)+".png")
	
	////	Caustic Surface
	if !surface_exists(causticSurface) causticSurface = surface_create(room_width, room_height)
	surface_set_target(causticSurface)
	draw_clear_alpha(c_black, 0)
	
	draw_set_alpha(1)
	var border = 256
	var x1 = camera_get_view_x(app.camera)-border
	var y1 = camera_get_view_y(app.camera)-border
	var x2 = x1 + camera_get_view_width(app.camera)+(border*2)
	var y2 = y1 + camera_get_view_height(app.camera)+(border*2)
	
	var x1 = app.x - app.width/2
	var y1 = app.y - app.height/2
	var x2 = app.x + app.width/2
	var y2 = app.y + app.height/2
	
	var startW = floor(x1/256)
	var startH = floor(y1/256)
	var endW = floor(x2/256) + 1
	var endH = floor(y2/256) + 1
	
	//debug.log("Tiles Width: "+string(endW-startW))
	//debug.log("Tiles Height: "+string(endH-startH))
	
	for(var w=startW;w<endW;w++) {
		for(var h=startH;h<endH;h++) {
			//draw_surface(surface, w*Width,h*Height)
			draw_sprite(water.sprite_index,water.image_index,w*Width,h*Height)
			//draw_rectangle(w*Width,h*Height, w*Width+256,h*Height+256,true)
		}
	}
	
	////	Remove collisionMap cliffs
	if surface_exists(causticSurfaceCutout) {
		gpu_set_blendmode(bm_subtract)
		draw_surface_ext(causticSurfaceCutout,0,0,1,1,0,c_black,1)
		
		var List = ds_list_create()
		collision_rectangle_list(app.x-app.width/2,app.y-app.height/2, app.x+app.width/2,app.y+app.height/2 +200, class_unit,false,false,List,false)
		if instance_exists(player) and ds_list_find_index(List,player.id) == -1 ds_list_add(List,player.id)
		if !ds_list_empty(List) {
			for(var i=0;i<ds_list_size(List);i++) {
				with List[| i] {
					if object_get_parent(object_index) == class_rock continue
					if visible draw_sprite_ext(sprite_index,image_index,x,y-z-floatZ,image_xscale,image_yscale,image_angle,image_blend,image_alpha)	
				}
			}
		}
		ds_list_destroy(List)
		gpu_set_blendmode(bm_normal)
		
		////	Fill in the missing cliff caustic with black
		//surface_reset_target()
		//var SWidth = x2 - x1
		//var SHeight = y2 - y1
		//var Surface = surface_create(SWidth, SHeight)
		//surface_set_target(Surface)
		//draw_clear_alpha(c_black, 0)
		
		//draw_surface_ext(causticSurfaceCutout,-x1,-y1,1,1,0,c_black,1)
		
		//gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
		//draw_rectangle(0,0,SWidth,SHeight,false)
		//gpu_set_blendmode(bm_normal)
		
		//surface_reset_target()
		//surface_set_target(causticSurface)
		//draw_surface(Surface,x1,y1)
		//surface_free(Surface)
		
	}
	
	surface_reset_target()
	
	draw_set_alpha(0.15)
	draw_surface(causticSurface,0,0)
	
	draw_reset()
	
	//surface_free(causticSurface)
}
	
	