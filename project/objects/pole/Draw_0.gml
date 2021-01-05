draw_unit()

//	We're in the shade
if place_meeting(groundX,y,shade) {
	if !buffer_exists(shadeBuffer) {
		draw_shade()
	}
	else if !surface_exists(shadeSurface) {
		var spriteWidth = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)
		var spriteHeight = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)
		shadeSurface = surface_create(spriteWidth,spriteHeight)
		buffer_set_surface(shadeBuffer,shadeSurface,0)
	}
	else {
		var xOffset = sprite_get_xoffset(sprite_index)
		var yOffset = sprite_get_yoffset(sprite_index)
		var XX = floor(x) - xOffset + sprite_get_bbox_left(sprite_index)
		var YY = floor(y) - yOffset + sprite_get_bbox_top(sprite_index) - z
		draw_surface_ext(shadeSurface,XX,YY,1,1,0,c_white,clamp(image_alpha,0,0.5))	
	}
}