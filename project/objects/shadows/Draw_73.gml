if instance_exists(mainmenu) and room != RoomMainMenu with mainmenu {
	draw_set_alpha(1)
	if surface_exists(surface) draw_surface(surface,camera_get_view_x(app.camera),camera_get_view_y(app.camera))
}