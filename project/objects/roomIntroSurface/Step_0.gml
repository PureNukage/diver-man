if !surface_exists(surface) and surfaceBuffer > -1 and buffer_exists(surfaceBuffer) {
	surface = surface_create(720,768)
	buffer_set_surface(surfaceBuffer,surface,0)
}

if brotherX > 0 and !createdBrother {
	if instance_exists(brother) instance_destroy(brother)
	var Bro = instance_create_layer(brotherX,brotherY,"Instances",brother)
	Bro.move_to(976,224)
	createdBrother = true
}

//	Delete self once player runs far enough away
if camera_get_view_x(app.camera) > 800 {
	instance_destroy()	
}