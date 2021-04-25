event_inherited()

mask_index = s_coin_collision

stage = 0

gui_x = x - camera_get_view_x(app.camera)
gui_y = y - z - floatZ - camera_get_view_y(app.camera)

floating = true

//detectCollision = false

floatZ = 32

image_xscale = 0
image_yscale = 0

maxMovespeed = 1
interactibility = false

if place_meeting(x,y,collisionMap) {
	var Map = instance_place(x,y,collisionMap)
	map = Map
	z = Map.z
	y += z
}