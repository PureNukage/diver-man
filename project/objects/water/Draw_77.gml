if on {
	////	UNDERWATER
	shader_set(shader_quake)
	shader_set_uniform_f(q_seconds, sec)

	var Width = window_get_width()
	var Height = window_get_height()
	draw_surface_stretched(application_surface,0,0, Width, Height)
	//draw_surface(application_surface, 0,0)
	//draw_rectangle(0,0,app.width,app.height,false)

	shader_reset()
}

else {
	var Width = window_get_width()
	var Height = window_get_height()
	draw_surface_stretched(application_surface,0,0, Width, Height)	
}