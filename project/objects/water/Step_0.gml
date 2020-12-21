if on if !app.paused sec += 1 / room_speed

if causticBuffer == -1 generate_caustic_map()

if !surface_exists(collisionMapsSurface) {
	collisionMapsSurface = surface_create(room_width, room_height)
	buffer_set_surface(collisionMapsBuffer,collisionMapsSurface,0)
}

for(var i=0;i<heightMapCount;i++) {
	if !surface_exists(heightMaps[i][2]) {
		heightMaps[i][2] = surface_create(room_width, room_height)
		buffer_set_surface(heightMaps[i][1],heightMaps[i][2],0)	
	}
}