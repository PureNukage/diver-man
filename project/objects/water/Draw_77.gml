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

//var surface = surface_create(Width, Height)

//surface_set_target(surface)

//////	WIP CAUSTIC
//shader_set(shader_caustic)
//shader_set_uniform_f(caustic_resolution, Width, Height)
//shader_set_uniform_f(caustic_seconds, sec)

//draw_rectangle(0,0,Width,Height,false)

//shader_reset()

//surface_reset_target()

//draw_set_alpha(0.2)
//draw_surface(surface, 0,0)
//draw_set_alpha(1)

//surface_free(surface)


////	GODRAYS
//shader_set(shader_godrays)
//shader_set_uniform_f(u_resolution, Width, Height)
//shader_set_uniform_f(u_seconds, sec)

//draw_rectangle(0,0,Width,Height,false)

//shader_reset()