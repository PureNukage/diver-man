//event_inherited()	

z = 0

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
	
	treasure = -1
}

bubbleTimer = -1
bubbleTimerMax = irandom_range(120,180)
function bubbles() {
	if bubbleTimer > 0 bubbleTimer--
	else {
		
		bubbleTimer = irandom_range(120,180)
		
		var bubbleCount = irandom_range(3,6)
		
		for(var i=0;i<bubbleCount;i++) {
			
			var Size = random_range(0.3,0.8)
			
			var scatter = 12
			var scatterX = irandom_range(x - scatter, x + scatter)
			var scatterY = irandom_range(y - 32 - scatter, y - 32 + scatter)
			
			var Speed = irandom_range(1,2)
		
			var Bubble = createParticle(scatterX,scatterY,particles.bubble,irandom_range(30,60),Speed)
			Bubble.image_xscale = Size
			Bubble.image_yscale = Size
			
		}
		
		sound.playSoundEffect(choose(sound_bubbles_0, sound_bubbles_1, sound_bubbles_2))
		
	}
}