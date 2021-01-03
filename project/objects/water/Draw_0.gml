//if live_call() return live_result 

if on {

	if !surface_exists(causticSurface) {
		causticSurface = surface_create(room_width, room_height)	
	
		surface_set_target(causticSurface)
		draw_clear_alpha(c_black, 0)
	
		surface_reset_target()
	}
	
	var Width = 256
	var Height = 256

	var surface = surface_create(Width, Height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	////	WIP CAUSTIC
	shader_set(shader_caustic)

	shader_set_uniform_f(caustic_resolution, Width, Height)
	shader_set_uniform_f(caustic_seconds, sec)

	draw_rectangle(0,0,Width,Height,false)
	
	shader_reset()
	
	surface_reset_target()
	
	surface_set_target(causticSurface)
	
	draw_set_alpha(1)
	var WW = room_width / Width
	var HH = room_height / Height
	for(var w=0;w<WW;w++) {
		for(var h=0;h<HH;h++) {
			draw_surface(surface, w*Width,h*Height)
		}
	}
	
	////	Remove collisionMap cliffs
	if causticBuffer > -1 {
		var Surface = surface_create(room_width, room_height)
		buffer_set_surface(causticBuffer,Surface,0)
		gpu_set_blendmode(bm_subtract)
		draw_surface_ext(Surface,0,0,1,1,0,c_black,1)
		gpu_set_blendmode(bm_normal)
		surface_free(Surface)
	}
	
	surface_reset_target()
	
	if !surface_exists(causticSurfaceOriginal) {
		causticSurfaceOriginal = surface_create(room_width,room_height)	
	}
	surface_copy(causticSurfaceOriginal,0,0,surface)
	surface_free(surface)
	
	draw_set_alpha(0.15)
	draw_surface(causticSurface,0,0)
}
	
	