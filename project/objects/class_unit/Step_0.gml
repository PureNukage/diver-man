if interactibility {
	if point_distance(x,y, player.x,player.y) < 60 and app.roomTransitionTo == -1 {
		interactable = true
	}
	else {
		if interactable {
			interactable = false		
		}
	}
}

if interactCD > -1 {
	interactCD--
	interactable = false	
}

if shadeStatic and !surface_exists(shadeSurface) and buffer_exists(shadeBuffer) {
	var spriteWidth = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)
	var spriteHeight = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)
	shadeSurface = surface_create(spriteWidth,spriteHeight)
	buffer_set_surface(shadeBuffer,shadeSurface,0)
	//surface_save(shadeSurface,"shadeSurface"+string(id)+".png")
}

if depthY depth = -y