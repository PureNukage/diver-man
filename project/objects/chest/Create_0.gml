event_inherited()

image_speed = 0

highlight = false

treasure = treasure.gold

opened = false
opening = false
function open() {
	if image_speed == 0 {
		image_speed = 1
	}
	
	else {
		if animation_end {
			image_speed = 0
			image_index = image_number-1
			opening = false
			opened = true
			
			bubbleTimer = 0
			bubbleTimerMax = 0
			bubbles()
		}
	}
}


function empty() {
	sprite_index = s_treasurechest_empty
	
	sound.playSoundEffect(sound_coins)
	
	player.gold += 300
}