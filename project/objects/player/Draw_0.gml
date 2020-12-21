//draw_shadow()
//	How many shadows do we have? 
var list = ds_list_create()
var list2 = ds_list_create()
var amount = collision_rectangle_list(bbox_left,bbox_top-z,bbox_right,y,collisionMap,true,true,list,true)
for(var i=0;i<amount;i++) {
	var Z = list[| i].z
	if list[| i] == map {
		ds_list_add(list2, list[| i])
	}
	else {
		if map > -1 and map.z == Z {} else
		if ds_list_find_index(list2,Z) == -1 ds_list_add(list2, list[| i]) 
	}
}
var amount = ds_list_size(list2)
debug.log(string(amount))

//	Draw the base shadow
draw_shadow_ext(0, -1)

//	Draw the map shadows
for(var i=0;i<amount;i++) {
	var Map = list2[| i]
	var Z = Map.z
	if (z > Z or map == Map) draw_shadow_ext(Z, Map)
}

draw_reset()
	
ds_list_destroy(list)
ds_list_destroy(list2)

draw_unit()

//	We're in the shade
if place_meeting(groundX,y,shade) and !muted {
	draw_shade()
}