if (instance_exists(class_unit) and place_meeting(x,y,class_unit))
{
	var ID = -1
	var IDlist = ds_list_create()
	var amount = instance_place_list(x,y,class_unit,IDlist,true)
	for(var i=0;i<amount;i++) {
		var _id = IDlist[| i]
		if _id.object_index == player {
			ID = _id
			i = 100
		}
	}
	
	//var ID = instance_place(x,y,class_unit)
	if ID > -1 {
		if ID.map != id {
			var canDraw = false
			with ID if place_meeting(x,y,other.id) and y <= (other.bbox_bottom - other.width) canDraw = true
			if canDraw {
				depth = ID.depth - 1
				drawSurface = true
				drawNearbyMaps()
			}
		}
	
		//	Loop through and set all objects depth
		var list = ds_list_create()
		var amountOfCollisions = instance_place_list(x,y,class_unit,list,true)
		if amountOfCollisions > 1 {
			for(var i=0;i<amountOfCollisions;i++) {
				var ID = list[| i]
				if ID.map != id and ID.groundY < y+z {
					depth = ID.depth - 1
				}
			}
		}
	}
}

if instance_exists(player) and point_in_rectangle(player.x,player.y,bbox_left-64,bbox_top-64,bbox_right+64,bbox_bottom+64) {
	var oldMask = player.mask_index
	player.mask_index = player.sprite_index
	if place_meeting(x,y,player) {
		if player.bbox_top < bbox_bottom-z and player.bbox_bottom < bbox_bottom and player.z < z {
			depth = player.depth - 1
			drawSurface = true
			drawNearbyMaps()
		}
	}
	player.mask_index = oldMask
}

if !foundNearbyMaps findNearbyMaps()