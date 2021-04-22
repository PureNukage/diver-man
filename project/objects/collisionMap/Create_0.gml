ID = app.collisionMaps
app.collisionMaps++

z = 0
width = sprite_get_height(sprite_index)*image_yscale
height = 0

centerX = bbox_left + (sprite_width/2)
centerY = bbox_top + (sprite_height/2)

cliffDepth = -(bbox_bottom-1)

surface = -1
surfaceBuffer = -1
inverseSurfaceBuffer = -1
inverseSurface = -1
inverseSurfaceExtraPixels = 256

cookieBuffer = -1
cookieSurface = -1

drawSurface = false

ramp = false

map = -1
maps = ds_list_create()

inList = false

depth = -1

sand = false
rock = -1
altTileLayer = -1

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

function createSurface() {
	
	var bufferName = room_get_name(room) + string(ID)
	
	if app.mode == mode_DEBUG {
	
		////	Room size surface
		var Surface = surface_create(room_width, room_height)
	
		surface_set_target(Surface)
		draw_clear_alpha(c_black, 0)
	
		if sand var layerString = "Tiles_Sand"
		else var layerString = "Tiles_Rocks"
	
		if is_string(altTileLayer) and layer_exists(altTileLayer) {
			layerString = altTileLayer	
		}
	
		var LayerID = layer_get_id(layerString)
		var tileLayerID = layer_tilemap_get_id(LayerID)
	
		if rock == -1 draw_tilemap(tileLayerID, 0,0)
		else with rock draw_self()
	
		surface_reset_target()
	
		////	Cliff size surface
		var finalSurface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
	
		surface_copy_part(finalSurface,0,0, Surface, x,y, sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
	
		var width = surface_get_width(finalSurface)
		var height = surface_get_height(finalSurface)
	
		if surfaceBuffer > -1 and buffer_exists(surfaceBuffer) buffer_delete(surfaceBuffer)
		surfaceBuffer = buffer_create(width*height*4, buffer_grow, 1)
		buffer_get_surface(surfaceBuffer, finalSurface, 0)
		buffer_save(surfaceBuffer, bufferName+"finalSurface.sav")
	
		////	Inverse surface used for shadow masks
		var inverseSurface = surface_create((sprite_get_width(sprite_index)*image_xscale)+inverseSurfaceExtraPixels,(sprite_get_height(sprite_index)*image_yscale)+inverseSurfaceExtraPixels)
		surface_set_target(inverseSurface)
		draw_clear_alpha(c_black, 0)
	
		draw_set_color(c_black)
		draw_set_alpha(1)
		draw_rectangle(0,0,(sprite_get_width(sprite_index)*image_xscale)+inverseSurfaceExtraPixels,(sprite_get_height(sprite_index)*image_yscale)+inverseSurfaceExtraPixels,false)
	
		gpu_set_blendmode(bm_subtract)
		draw_surface_ext(finalSurface,inverseSurfaceExtraPixels/2,inverseSurfaceExtraPixels/2,1,1,0,c_black,1)
		gpu_set_blendmode(bm_normal)
	
		//	Factor in the cliff
		var oX = x - inverseSurfaceExtraPixels/2
		var oY = y - inverseSurfaceExtraPixels/2
		draw_set_color(c_blue)
		draw_rectangle(bbox_left-oX,bbox_bottom-z-oY,bbox_right-oX,bbox_bottom-oY,false)
	
		surface_reset_target()
	
		if inverseSurfaceBuffer > -1 and buffer_exists(inverseSurfaceBuffer) buffer_delete(inverseSurfaceBuffer)
		inverseSurfaceBuffer = buffer_create((((sprite_get_width(sprite_index)*image_xscale)+inverseSurfaceExtraPixels)+((sprite_get_height(sprite_index)*image_yscale)+inverseSurfaceExtraPixels))*4, buffer_grow, 1)
		buffer_get_surface(inverseSurfaceBuffer, inverseSurface, 0)
		buffer_save(inverseSurfaceBuffer, bufferName+"inverseSurface.sav")
	
		//surface_save(inverseSurface,"inverseSurface"+string(id)+".png")
	
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
		buffer_save(cookieBuffer, bufferName+"cookieCutSurface.sav")
	
		surface_free(Surface)
		surface_free(inverseSurface)
		surface_free(cookieCutSurface)
		surface_free(finalSurface)
		
	}
	//	app.mode == mode_PRODUCTION
	else {
		
		if surfaceBuffer > -1 and buffer_exists(surfaceBuffer) buffer_delete(surfaceBuffer)
		surfaceBuffer = buffer_load(bufferName + "finalSurface.sav")
		
		if inverseSurfaceBuffer > -1 and buffer_exists(inverseSurfaceBuffer) buffer_delete(inverseSurfaceBuffer)
		inverseSurfaceBuffer = buffer_load(bufferName + "inverseSurface.sav")
		
		if cookieBuffer > -1 and buffer_exists(cookieBuffer) buffer_delete(cookieBuffer)
		cookieBuffer = buffer_load(bufferName + "cookieCutSurface.sav")
		
	}
	
}

createSurface()