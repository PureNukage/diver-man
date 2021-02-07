if place_meeting(x,y,collisionMap) and map == -1 {
	var list = ds_list_create()
	var count = instance_place_list(x,y,collisionMap,list,true)
	var highestMap = -1
	for(var i=0;i<count;i++) {
		var ID = list[| i]
		if highestMap == -1 or ID.z+ID.height > highestMap.z+highestMap.height {
			highestMap = ID	
		}
	}
	if highestMap > -1 {
		map = highestMap
		y += map.z
		z = map.z
	}
}