event_inherited()

shadeStatic = false

running = false

state = state.free

staminaMax = 100
stamina = staminaMax
gold = app.gold 

attack = 0

dancing = false

suitOn = app.suitOn

muted = false

mask_index = s_diverman_collision

function footprint() {
	var footstepIndex1 = 0
	var footstepIndex2 = 0
	
	if sprite_index == s_diverman_walk {
		var footstepIndex1 = 2
		var footstepIndex2 = 7	
	}
	
	else if sprite_index == s_diverman_sprint {
		var footstepIndex1 = 3
		var footstepIndex2 = 8
	}
	else {
			
	}
	
	if floor(image_index) == footstepIndex1 or floor(image_index) == footstepIndex2 {
	if !madeFootprint {
		var X = groundX
		switch(sign(image_xscale))
		{
			//	Facing Right
			case 1:
				//	Right foot
				if floor(image_index) == footstepIndex1 {
					var X = x
				} 
				//	Left foot
				else {
					var X = x - 18
				}
			break
			//	Facing Left
			case -1:
				//	Right foot
				if floor(image_index) == footstepIndex2 {
					var X = x + 18
				} 
				//	Left foot
				else {
					var X = x
				}
			break
		}
		var Footprint = createParticle(X,groundY, particles.footprint, 180, 0)
		Footprint.sprite_index = s_footprint
		Footprint.image_xscale = round(image_xscale)
		Footprint.z = z
		madeFootprint = true
		debug.log("making footprint")
	}
}
//	Not stepping
else {
	if madeFootprint madeFootprint = false
}
debug.log("image_index: "+string(image_index))
}