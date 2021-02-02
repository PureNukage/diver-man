if on if !app.paused sec += 1 / room_speed

if causticBuffer == -1 generate_caustic_map()

if !surface_exists(causticSurfaceCutout) and buffer_exists(causticBuffer) {
	causticSurfaceCutout = surface_create(room_width, room_height)
	buffer_set_surface(causticBuffer,causticSurfaceCutout,0)
}

if !surface_exists(collisionMapsSurface) and buffer_exists(collisionMapsBuffer) {
	collisionMapsSurface = surface_create(room_width, room_height)
	buffer_set_surface(collisionMapsBuffer,collisionMapsSurface,0)
}