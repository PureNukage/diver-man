drawSurface = false

if map == -1 and place_meeting(x,y,collisionMap) {
	var ID = instance_place(x,y,collisionMap)
	if rectangle_in_rectangle(bbox_left,bbox_top+z,bbox_right,bbox_bottom, 
	ID.bbox_left,ID.bbox_top+ID.z,ID.bbox_right,ID.bbox_bottom) == 1 {
		map = ID
		height += map.z
	}
}