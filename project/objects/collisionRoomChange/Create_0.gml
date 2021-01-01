Room = -1

function replace_with_collision() {
	var Col = instance_create_layer(x,y,"Collisions",collision)
	Col.image_xscale = image_xscale
	Col.image_yscale = image_yscale
	instance_destroy()
	grid.mpGrid_build()
}