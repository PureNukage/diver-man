////	Should we draw over the player?
if instance_exists(player) and rectangle_in_rectangle(player.bbox_left,player.bbox_top,player.bbox_right,player.bbox_bottom, bbox_left-64,bbox_top-64,bbox_right+64,bbox_bottom+64) == 1 and (map == -1 or (map > -1 and !map.drawSurface)) {
	
	var oldMask = player.mask_index
	player.mask_index = player.sprite_index
	//	If we're colliding with the top of the cliff
	if player.groundY < bbox_bottom-1 and rectangle_in_rectangle(player.bbox_left,player.bbox_top-player.z,player.bbox_right,player.bbox_bottom-player.z, bbox_left,bbox_top,bbox_right,bbox_bottom-z) > 0 {
		if player.z < z+height {
			depth = player.depth - 1
			drawSurface = true
			//drawNearbyMaps()
			for(var i=0;i<ds_list_size(maps);i++) {
				var Map = maps[| i]
				Map.drawSurface = true
				Map.depth = depth - 1 - i
			}
		}
	}
	player.mask_index = oldMask
	
}
	
if !surface_exists(surface) and buffer_exists(surfaceBuffer) {
	surface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	buffer_set_surface(surfaceBuffer, surface, 0)
}

if !surface_exists(cookieSurface) and buffer_exists(cookieBuffer) {
	cookieSurface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	buffer_set_surface(cookieBuffer, cookieSurface, 0)
}

if !surface_exists(inverseSurface) and buffer_exists(inverseSurfaceBuffer) {
	inverseSurface = surface_create((sprite_get_width(sprite_index)*image_xscale)+inverseSurfaceExtraPixels,(sprite_get_height(sprite_index)*image_yscale)+inverseSurfaceExtraPixels)
	buffer_set_surface(inverseSurfaceBuffer, inverseSurface, 0)
}

if !foundNearbyMaps findNearbyMaps()