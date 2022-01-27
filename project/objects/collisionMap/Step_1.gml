drawSurface = false

cliffDepth = bbox_bottom-1
if (map == -1 or (map > -1 and !map.drawSurface))  {
	var list = ds_list_create()
	var spacer = 10
	var count = collision_rectangle_list(bbox_left-spacer,bbox_top-spacer,bbox_right+spacer,bbox_bottom+z+height+spacer,class_unit,true,true,list,true)
	var lowestY = -1
	for(var i=0;i<count;i++) {
		var Unit = list[| i]
		if instance_exists(Unit) {
			var ObjectIndex = Unit.object_index
			if ObjectIndex == player or (object_get_parent(ObjectIndex) != class_foliage and object_get_parent(ObjectIndex) != class_rock) {
				if lowestY == -1 or Unit.groundY > lowestY.groundY {
					if (Unit.z < z+height or (Unit.map != id and Unit.y <= bbox_top+z)) and (Unit.y < bbox_bottom+height-1 and Unit.groundY < bbox_bottom-1) {
						lowestY = Unit
					}
				}
			}
		}
	}
	if lowestY > -1 {
		var ID = lowestY 
                    
		//var oldMask = ID.mask_index
		//ID.mask_index = ID.sprite_index
		if ID.y < bbox_bottom+height - 1 and ID.groundY < bbox_bottom-1  {
			if (ID.z < z+height) {//or (ID.map != id and ID.y <= bbox_top+z) {
				if ID.map == -1 or (ID.map > -1 and !ID.map.ramp) {
					depth = ID.depth - 10
					drawSurface = true
					for(var i=0;i<ds_list_size(maps);i++) {
						var Map = maps[| i]
						Map.drawSurface = true
						Map.depth = depth - 1
					}
					var List = ds_list_create()
					var count = collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom,collisionMap,true,true,List,true)
					for(var i=0;i<count;i++) {
						var Map = List[| i]
						if Map.bbox_bottom > bbox_bottom and Map != map {
							Map.drawSurface = true
							Map.depth = depth - ((Map.z+Map.height)/16) - i
						}
					}
					ds_list_destroy(List)
				}
			}
		}
		//ID.mask_index = oldMask
	}
	ds_list_destroy(list)
}
else {
	depth = cliffDepth*-1	
}