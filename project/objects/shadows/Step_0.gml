if !surface_exists(surface) and buffer_exists(surfaceBuffer) {
	surface = surface_create(room_width, room_height)
	buffer_set_surface(surfaceBuffer, surface, 0)
}

if app.paused {
	depth = -app.depth - 10
}
else depth = -1