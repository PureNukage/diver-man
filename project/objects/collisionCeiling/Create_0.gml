tileLayer = ""
sprite = -1

function create_surface(_tileLayer) {
	var surface = surface_create(room_width, room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	var Layer = layer_tilemap_get_id(_tileLayer)
	draw_tilemap(Layer,0,0)
	
	surface_reset_target()
	
	sprite = sprite_create_from_surface(surface, bbox_left,bbox_top, abs(bbox_right-bbox_left), abs(bbox_bottom-bbox_top), false, false, 0,0)
	
	surface_free(surface)
}