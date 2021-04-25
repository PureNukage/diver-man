if !payingAttention {
	if leftOrRight {
		x += 3
		image_xscale = 1
	}
	else {
		x -= 3 
		image_xscale = -1	
	}
}

if x < -150 or x > room_width+150 {
	var index = ds_list_find_index(adultManager.adults, id)
	ds_list_delete(adultManager.adults, index)
	instance_destroy()
}

if notPaying {
	image_blend = c_red	
	if payingAttention payingAttention = false
}
else if payingAttention {
	image_blend = c_yellow	
	completion++
	if completion >= 100 {
		player.gold += 1
		app.gold += 1
		notPaying = true
		payingAttention = false
		happyCustomer = true
		sound.playSoundEffect(sound_coins)
	}
	
	if !playerDance.dancing {
		notPaying = true
		payingAttention = false
	}
}

if happyCustomer {
	image_blend = c_green	
}