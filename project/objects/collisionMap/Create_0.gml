z = 0
width = sprite_get_height(sprite_index)*image_yscale

centerX = bbox_left + (sprite_width/2)
centerY = bbox_top + (sprite_height/2)

surface = -1
surfaceBuffer = -1
inverseSurfaceBuffer = -1

cookieBuffer = -1
cookieSurface = -1

drawSurface = false

depth = -1

sand = false
rock = -1

arrayNearbyMaps = []
foundNearbyMaps = false
function findNearbyMaps() {
	for(var i=0;i<4;i++) {
		var X = 0
		var Y = 0
		arrayNearbyMaps[i] = -1
		switch(i)
		{
			case up:
				Y = -1	
			break
			case right:
				X = 1
			break
			case down:
				Y = 1
			break
			case left:
				X = -1
			break
		}
		
		if place_meeting(x+X,y+Y,collisionMap) {
			var ID = instance_place(x+X,y+Y,collisionMap)	
			if ID.z > -1 {
				arrayNearbyMaps[i] = ID
			}
		}
		
		foundNearbyMaps = true
		
	}
}
	
function drawNearbyMaps() {
	if foundNearbyMaps {
		for(var i=0;i<4;i++) {
			if arrayNearbyMaps[i] > -1 and instance_exists(arrayNearbyMaps[i]) {
				var ID = arrayNearbyMaps[i]
				if ID.z >= z and player.map != ID and player.groundY <= ID.bbox_bottom - ID.width {
					ID.drawSurface = true
					ID.depth = depth
				}
			}
		}
	}
}

function createSurface() {
	var surface = surface_create(room_width, room_height) // sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale
	
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	var layerString = ""
	
	if sand layerString = "Tiles_Sand"
	else layerString = "Tiles_Rocks"
	
	var LayerID = layer_get_id(layerString)
	var tileLayerID = layer_tilemap_get_id(LayerID)
	
	if rock == -1 draw_tilemap(tileLayerID, 0,0)
	else with rock draw_self()
	
	surface_reset_target()
	
	var finalSurface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
	
	surface_copy_part(finalSurface,0,0, surface, x,y, sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
	
	var width = surface_get_width(finalSurface)
	var height = surface_get_height(finalSurface)
	
	
	if buffer_exists(surfaceBuffer) buffer_delete(surfaceBuffer)
	
	surfaceBuffer = buffer_create(width*height*4, buffer_grow, 1)
	
	buffer_get_surface(surfaceBuffer, finalSurface, 0)
	
	////	Inverse surface used for shadow masks
	var inverseSurface = surface_create(room_width, room_height)
	surface_set_target(inverseSurface)
	draw_clear_alpha(c_black, 0)
	
	draw_set_color(c_black)
	draw_set_alpha(1)
	draw_rectangle(0,0,room_width,room_height,false)
	
	gpu_set_blendmode(bm_subtract)
	draw_surface_ext(finalSurface,x,y,1,1,0,c_black,1)
	gpu_set_blendmode(bm_normal)
	
	//	Correct for the cliff 
	//	todo
	
	surface_reset_target()
	
	//	Cookie Cutter surface
	var cookieCutSurface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	surface_set_target(cookieCutSurface)
	draw_clear_alpha(c_black, 0)
	
	draw_set_alpha(1)
	draw_set_color(c_black)
	draw_rectangle(0,0,sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale,false)
	
	gpu_set_blendmode(bm_subtract)
	draw_surface_ext(finalSurface,0,0,1,1,0,c_black,1)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	if cookieBuffer > -1 and buffer_exists(cookieBuffer) buffer_delete(cookieBuffer)
	cookieBuffer = buffer_create((sprite_get_width(sprite_index)*image_xscale)*(sprite_get_height(sprite_index)*image_yscale)*4,buffer_grow,1)
	buffer_get_surface(cookieBuffer, cookieCutSurface, 0)
	
	if inverseSurfaceBuffer > -1 and buffer_exists(inverseSurfaceBuffer) buffer_delete(inverseSurfaceBuffer)
	inverseSurfaceBuffer = buffer_create(room_width*room_height*4, buffer_grow, 1)
	buffer_get_surface(inverseSurfaceBuffer, inverseSurface, 0)
	
	surface_free(surface)
	surface_free(inverseSurface)
	surface_free(cookieCutSurface)
	
}

createSurface()