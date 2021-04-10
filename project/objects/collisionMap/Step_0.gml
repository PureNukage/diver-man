if map > -1 and map.drawSurface and !drawSurface {
	depth = map.depth - 1
	drawSurface = true
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
	//if altTileLayer == "Tiles_Stairs" and room = RoomCityHub surface_save(inverseSurface,"stairsSurface.png")
}

//if !foundNearbyMaps findNearbyMaps()