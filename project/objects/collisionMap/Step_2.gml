if map > -1 and map.drawSurface and !drawSurface {
	depth = map.depth - 1
	drawSurface = true
}

//if drawSurface {
//	var list = ds_list_create()
//	var count = collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom,collisionMap,true,true,list,true)
//	for(var i=0;i<count;i++) {
//		var Map = list[| i]
//		Map.drawSurface = true
//		Map.depth = cliffDepth*-1
//	}
//	ds_list_destroy(list)
//}