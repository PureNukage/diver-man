if altTileLayer == -1 createSurface()

//	Is this map on top of another map?
if map == -1 and place_meeting(x,y,collisionMap) {
	var list = ds_list_create()
	var count = instance_place_list(x,y,collisionMap,list,true)
	
	var tallestMap = -1
	for(var i=0;i<count;i++) {
		var Map = list[| i]
		if (tallestMap == -1 or Map.z+Map.height >= tallestMap.z+tallestMap.height)
		and rectangle_in_rectangle(bbox_left,bbox_top+z,bbox_right,bbox_bottom, Map.bbox_left,Map.bbox_top,Map.bbox_right,Map.bbox_bottom-Map.z) == 1 {
			tallestMap = Map	
		}
	}
	
	var ID = tallestMap
	//	Lets make sure the other map is actually colliding with us
	if rectangle_in_rectangle(bbox_left,bbox_top+z,bbox_right,bbox_bottom, 
	ID.bbox_left,ID.bbox_top,ID.bbox_right,ID.bbox_bottom-ID.z) == 1 {
		//	Is this map under us? 
		if ID.z+ID.height >= z+height {
			map = ID
			height += map.z + map.height
			ds_list_add(map.maps,id)
		}
	}

	ds_list_destroy(list)
}