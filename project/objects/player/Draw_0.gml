//draw_shadow()
//	How many shadows do we have? 
var list = ds_list_create()
var list2 = ds_list_create()
var amount = collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom,collisionMap,true,true,list,true)
for(var i=0;i<amount;i++) {
	var Z = list[| i].z
	
	if list[| i] == map {
		ds_list_add(list2, list[| i])
	}
	else {
		if ds_list_find_index(list2,list[| i]) == -1 ds_list_add(list2, list[| i]) 
	}
}
var amount = ds_list_size(list2)

//	Draw the base shadow
draw_shadow_ext(0, -1)

//	Draw the map shadows
for(var i=0;i<amount;i++) {
	var Map = list2[| i]
	var Z = Map.z + Map.height
	if Map.ramp {
		var Z = clamp(floor(((groundX-Map.bbox_left) / (Map.bbox_right - Map.bbox_left)) * (Map.z)),0,Map.z)
		Z += Map.height		
	}
	
	if (z >= Z or map == Map) {
		if y >= Map.bbox_top+Map.z {
			draw_shadow_ext(Z, Map)
		}
	}
}

draw_reset()
	
ds_list_destroy(list)
ds_list_destroy(list2)

draw_unit()

//	We're in the shade
if place_meeting(groundX,y,shade) and !muted {
	draw_shade()
}