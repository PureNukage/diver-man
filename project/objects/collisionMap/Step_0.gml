if (instance_exists(class_unit) and place_meeting(x,y,class_unit))
{
	var ID = instance_place(x,y,class_unit)
	if ID.map != id and ID.groundY < y+z and ID.z < z {
		ID.depth = water.depth + 1
		depth = ID.depth - 1
		drawSurface = true
		drawNearbyMaps()
	}
	
	//	Loop through and set all objects depth
	var list = ds_list_create()
	var amountOfCollisions = instance_place_list(x,y,class_unit,list,true)
	if amountOfCollisions > 1 {
		for(var i=0;i<amountOfCollisions;i++) {
			var ID = list[| i]
			if ID.map != id and ID.groundY < y+z {
				ID.depth = water.depth + 1
				depth = ID.depth - 1
			}
		}
	}
}

if !foundNearbyMaps findNearbyMaps()