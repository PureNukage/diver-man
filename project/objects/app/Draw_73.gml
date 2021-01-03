if surface_exists(water.causticSurface) {
	//draw_surface(water.causticSurface, player.x,player.y)	
}
//	Pause
if paused and surface_exists(pauseSurface) {
	draw_surface(pauseSurface,camera_get_view_x(camera),camera_get_view_y(camera))
}