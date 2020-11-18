//	Spawn the min amount of adults
//if ds_list_size(adults) < adultsMin {
//	//var amount = adultsMin - ds_list_size(adults)
//	//repeat(amount) 
//	create_adult(irandom_range(0,room_width), irandom_range(320, room_height-50))
//}

if on {
	if ds_list_size(adults) < adultsMax and adultSpawnerTimer == -1 {
		var X = x
		var Y = y
		var leftOrRight = choose(0,1)
		if leftOrRight {
			x = -100
		}
		else {
			x = room_width+100
		}
		Y = irandom_range(320, room_height-50)
		create_adult(X,Y)	
	}


	if adultSpawnerTimer > -1 adultSpawnerTimer--
	else adultSpawnerTimer = 15

	debug.log(string(ds_list_size(adults)))
}