event_inherited()

hasDialogue = false

on = false

dances = 6

list = ds_list_create()
list_active = ds_list_create()

list_offset_start = 135
list_offset = list_offset_start
list_speed = 1
list_success = 0
mistakes = 0
sentPersonAway = false
function list_unpack() {
	var amount = 3 - ds_list_size(list_active)
	for(var i=0;i<amount;i++) {
		if !ds_list_empty(list) {
			ds_list_add(list_active, list[| 0])
			ds_list_delete(list, 0)
		}
	}
}

function list_remove_one() {
	ds_list_delete(list_active, 0)
	list_unpack()
	list_offset += 45
	//list_speed += 0.10
}

function add_dance() {
	dances--
	//	Add the key presses to the list
	var amount = 20
	var amount = irandom_range(12,20)
	for(var i=0;i<amount;i++) {
		ds_list_add(list, choose(up, down, left, right))
	}	
}