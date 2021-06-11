event_inherited()

shadeStatic = false

running = false
runningPress = false

state = state.free

gold = app.gold

jumping = -1

attack = 0

oxygenMax = 100
oxygen = oxygenMax

dancing = false

hasWrench = true

suitOn = app.suitOn

muted = false

jumpHalt = false

mask_index = s_diverman_collision

////	Inventory
inventory = ds_list_create()
inventoryOpen = false

questJournalOpen = false

function inventory_open() {
	inventoryOpen = true
	app.zoom_level = 0.70
	canMove = false
}

function inventory_close() {
	inventoryOpen = false
	app.zoom_level = 1
	canMove = true
}

function create_item(item_index) {
	var Item = new _create_item(item_index)
	ds_list_add(inventory, Item)
}

function remove_item(item_list_index) {
	if item_list_index > -1 ds_list_delete(inventory, item_list_index)
	else debug.log("ERROR Trying to remove -1 item from inventory")
}

function item_check(item_index) {
	for(var i=0;i<ds_list_size(inventory);i++) {
		var Item = inventory[| i]
		if Item.index == item_index return i
	}
	return -1
}

function _create_item(item_index) constructor {
	index = item_index
	
	switch(item_index) {
		case item.sandwich:
			image = s_sandwich
			text = "Sandwich"
			description = "A sandwich made with love. Restores HP"
		break
		case item.watch:
			image = s_watch_image
			text = "Watch"
			description = "A watch passed down from your parents"
		break 
		case item.necklace:
			image = s_necklace_image
			text = "Necklace"
			description = "A necklace belonging to the Wife"
		break
	}
}

function footprint() {
	var footstepLeft = 0
	var footstepRight = 0
	
	if sprite_index == s_diverman_walk {
		var footstepLeft = 0
		var footstepRight = 5
	}
	
	else if sprite_index == s_diverman_sprint {
		var footstepLeft = 3
		var footstepRight = 8
	}
	else {
			
	}
	
	if floor(image_index) == footstepLeft or floor(image_index) == footstepRight {
	if !madeFootprint {
		var X = groundX
		var dustSprite = -1
		switch(sign(image_xscale))
		{
			//	Facing Right
			case 1:
				//	Right foot
				if floor(image_index) == footstepRight {
					var X = x
					if sprite_index == s_diverman_walk dustSprite = s_diverman_walk_dustpoofs_right
					else dustSprite = s_diverman_running_dustpoofs_right
				} 
				//	Left foot
				else {
					var X = x - 18
					if sprite_index == s_diverman_walk dustSprite = s_diverman_walk_dustpoofs_left
					else dustSprite = s_diverman_running_dustpoofs_left
				}
			break
			//	Facing Left
			case -1:
				//	Right foot
				if floor(image_index) == footstepRight {
					var X = x + 18
					if sprite_index == s_diverman_walk dustSprite = s_diverman_walk_dustpoofs_right
					else dustSprite = s_diverman_running_dustpoofs_right
				} 
				//	Left foot
				else {
					var X = x
					if sprite_index == s_diverman_walk dustSprite = s_diverman_walk_dustpoofs_left
					else dustSprite = s_diverman_running_dustpoofs_left
				}
			break
		}
		var Footprint = createParticle(X,groundY, particles.footprint, 180, 0)
		Footprint.sprite_index = s_footprint
		Footprint.image_xscale = round(image_xscale)
		Footprint.z = z
		madeFootprint = true
		
		var dustpoof = create_particle(dustSprite, particles.dustpoof, x, groundY)
		dustpoof.image_xscale = round(image_xscale)
		dustpoof.depth = player.depth - 5
		
		sound.playSoundEffect(choose(Step_water_1_1_0, Step_water_2_1_0,Step_water_3_1_0, Step_water_4_1_0, Step_water_5_1_0, Step_water_6_1_0))
		//debug.log("making footprint")
	}
}
//	Not stepping
else {
	if madeFootprint madeFootprint = false
}
//debug.log("image_index: "+string(image_index))
}