if input.keyInteract {
	on = true
	player.muted = true
	
	app.cameraFocus(x,y,"~",0)
	app.zoom_level = 0.70
	
	if !instance_exists(dancingCrowdManager) instance_create_layer(x,y,"Instances",dancingCrowdManager)
	dancingCrowdManager.add_person()
	
	add_dance()
	
}

if input.keyArrowUp y--
if input.keyArrowDown y++

depth = -y - 50