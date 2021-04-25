list = ds_list_create()
listUsed = ds_list_create()
listUsed[| 0] = 0
listUsed[| 1] = 1
listUsed[| 2] = 2
listUsed[| 3] = 3
listUsed[| 4] = 4

personAdded = -1
function add_person() {
	if ds_list_size(list) < 5 {
		var randomX = choose(-400,400)
		var randomIndex = irandom_range(0,ds_list_size(listUsed)-1)
		var number = listUsed[| randomIndex]
		ds_list_delete(listUsed, randomIndex)
		var newDestX = -1
		var newDestY = -1
		switch(number) {
			case 0: 
				newDestX = x 
				newDestY = y+100
			break
			case 1: 
				newDestX = x-50
				newDestY = y+50
			break
			case 2: 
				newDestX = x-100 
				newDestY = y+25
			break
			case 3: 
				newDestX = x+50
				newDestY = y+50
			break
			case 4: 
				newDestX = x+100 
				newDestY = y+25
			break
		}
		var Person = instance_create_layer(x+randomX,y,"Instances",crowdAdult)
		ds_list_add(list,Person)
		Person.move_to(newDestX,300)
		Person.number = number
	}
}

function remove_person() {
	if !ds_list_empty(list) {
		var Index = irandom_range(0,ds_list_size(list)-1)
		var Person = list[| Index]
		ds_list_delete(list, Index)
		var randomX = choose(0, room_width)
		ds_list_add(listUsed, Person.number)
		var Y = choose(-100,100)
		Person.move_to(randomX, Person.y+Y)
		Person.Delete = true
	}
}