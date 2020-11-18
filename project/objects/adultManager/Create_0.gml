on = true
adultsMin = 25
adultsMax = 40
adultSpawnerTimer = -1

adults = ds_list_create()

function create_adult(x, y) {
	var Adult = instance_create_layer(x,y,"Instances",adult)
	//Adult.leftOrRight = leftOrRight
	ds_list_add(adults, Adult)
}

//repeat(adultsMin) {
//	create_adult(irandom_range(0,room_width), irandom_range(320, room_height-50))
//}