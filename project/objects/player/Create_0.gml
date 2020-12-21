event_inherited()

shadeStatic = false

running = false

state = state.free

staminaMax = 100
stamina = staminaMax
gold = app.gold

jumping = -1

attack = 0

dancing = false

suitOn = app.suitOn

muted = false

jumpHalt = false

mask_index = s_diverman_collision

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
		
		//debug.log("making footprint")
	}
}
//	Not stepping
else {
	if madeFootprint madeFootprint = false
}
//debug.log("image_index: "+string(image_index))
}