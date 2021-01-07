if place_meeting(x,y,collisionMap) and map == -1 {
	var ID = instance_place(x,y,collisionMap)
	map = ID
	y += map.z
	z = map.z
}