event_inherited()

depth = -y

var wholeY = bbox_bottom - (sprite_get_height(sprite_index)/2)
var zeroY = y - sprite_get_yoffset(sprite_index)
var cameraY = camera_get_view_y(app.camera)

if cameraY < zeroY image_alpha = 0
else if cameraY >= zeroY and cameraY < wholeY {
	image_alpha = (cameraY-zeroY) / (wholeY - zeroY)
}
else {
	image_alpha = 1	
}