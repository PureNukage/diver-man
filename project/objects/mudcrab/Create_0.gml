event_inherited()

interactibility = false

maxMovespeed = 0.5

if place_meeting(x,y,collisionMap) {
	var Map = instance_place(x,y,collisionMap)
	map = Map
	z = Map.z
	y += z
}