cliffDepth = bbox_bottom-1
if (map == -1 or (map > -1 and !map.drawSurface))  { // and place_meeting(x,y,player) or place_meeting(x,y,class_enemy) or place_meeting(x,y,class_npc)
	var list = ds_list_create()
	var count = collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom+z+height,class_unit,true,true,list,true)
	var lowestY = -1
	for(var i=0;i<count;i++) {
		var Unit = list[| i]
		var ObjectIndex = Unit.object_index
		if ObjectIndex == player or (object_get_parent(ObjectIndex) != class_foliage and object_get_parent(ObjectIndex) != class_rock) {
			if lowestY == -1 or Unit.groundY > lowestY.groundY {
				if (Unit.z < z+height or (Unit.map != id and Unit.y <= bbox_top+z)) and (Unit.y < bbox_bottom -1 and Unit.groundY < bbox_bottom-1) {
					lowestY = Unit
				}
			}
		}
	}
	if lowestY > -1 {
		var ID = lowestY 
                    
		//var oldMask = ID.mask_index
		//ID.mask_index = ID.sprite_index
		if ID.y < bbox_bottom - 1 and ID.groundY < bbox_bottom-1  {
			if (ID.z < z+height) or (ID.map != id and ID.y <= bbox_top+z) {
				if ID.map == -1 or (ID.map > -1 and !ID.map.ramp) {
					debug.log(string(id)+" drawing")
					depth = ID.depth - 1
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
							Map.depth = depth - (Map.z+Map.height) - i
						}
					}
					ds_list_destroy(List)
				} else debug.log(string(id)+" NOT drawing 3")
			} else debug.log(string(id)+" NOT drawing 2")
		}
		else debug.log(string(id)+" NOT drawing 1")
		//ID.mask_index = oldMask
	}
	ds_list_destroy(list)
}
else {
	depth = cliffDepth*-1	
}
	
if !surface_exists(surface) and buffer_exists(surfaceBuffer) {
	surface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	buffer_set_surface(surfaceBuffer, surface, 0)
}

if !surface_exists(cookieSurface) and buffer_exists(cookieBuffer) {
	cookieSurface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	buffer_set_surface(cookieBuffer, cookieSurface, 0)
}

if !surface_exists(inverseSurface) and buffer_exists(inverseSurfaceBuffer) {
	inverseSurface = surface_create((sprite_get_width(sprite_index)*image_xscale)+inverseSurfaceExtraPixels,(sprite_get_height(sprite_index)*image_yscale)+inverseSurfaceExtraPixels)
	buffer_set_surface(inverseSurfaceBuffer, inverseSurface, 0)
	//if altTileLayer == "Tiles_Stairs" and room = RoomCityHub surface_save(inverseSurface,"stairsSurface.png")
}

if !foundNearbyMaps findNearbyMaps()