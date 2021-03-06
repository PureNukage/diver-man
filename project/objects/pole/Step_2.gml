event_inherited()

if depthY {
	depth = -y
	//	If the map under us is being drawn, lets make sure we're on top of it
	if map > -1 and map.drawSurface {
		depth = map.depth - 10 //- y
	}
}

var wholeY = bbox_bottom - ((sprite_get_height(sprite_index)*image_yscale)/2) - z
var zeroY = y - (sprite_get_yoffset(sprite_index)*image_yscale) - z
var cameraY = camera_get_view_y(app.camera)

if cameraY < zeroY image_alpha = 0
else if cameraY >= zeroY and cameraY < wholeY {
	image_alpha = (cameraY-zeroY) / (wholeY - zeroY)
}
else {
	image_alpha = 1	
}