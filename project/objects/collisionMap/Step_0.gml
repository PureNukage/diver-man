//if (instance_exists(class_unit) and place_meeting(x,y-height,class_unit))
//{
//	var ID = -1
//	var IDlist = ds_list_create()
//	var amount = instance_place_list(x,y,class_unit,IDlist,true)
//	for(var i=0;i<amount;i++) {
//		var _id = IDlist[| i]
//		if _id.object_index == player {
//			ID = _id
//			i = 100
//		}
//	}
	
//	//var ID = instance_place(x,y,class_unit)
//	if ID > -1 {
//		if ID.map != id {
//			var canDraw = false
//			with ID if place_meeting(x,y,other.id) and y <= (other.bbox_bottom - other.width) canDraw = true
//			if canDraw {
//				depth = ID.depth - 1
//				drawSurface = true
//				drawNearbyMaps()
//			}
//		}
	
//		//	Loop through and set all objects depth
//		var list = ds_list_create()
//		var amountOfCollisions = instance_place_list(x,y,class_unit,list,true)
//		if amountOfCollisions > 1 {
//			for(var i=0;i<amountOfCollisions;i++) {
//				var ID = list[| i]
//				if ID.map != id and ID.groundY < y+z {
//					depth = ID.depth - 1
//				}
//			}
//		}
//	}
//}

//if live_call() return live_result

if instance_exists(player) and point_in_rectangle(player.x,player.y,bbox_left-64,bbox_top-64,bbox_right+64,bbox_bottom+64) {
	var oldMask = player.mask_index
	player.mask_index = player.sprite_index
	//debug.log("map: "+string_upper(string(id))+" colliding with player")
	if place_meeting(x,y,player) {
		var Z = player.z
		if player.map > -1 Z += player.map.height
		if player.bbox_top < bbox_bottom-z and player.bbox_bottom < bbox_bottom and Z < z+height {
			//debug.log("map: "+string_upper(string(id))+" drawing in front of player")
			depth = player.depth - 1
			drawSurface = true
			drawNearbyMaps()
		}
	}
	player.mask_index = oldMask
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
}

if !foundNearbyMaps findNearbyMaps()