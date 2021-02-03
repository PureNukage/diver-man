event_inherited()

switch(state) {
	case state.free:
	
		//	Knocked up by player jumping
		stunCheck()
		
		if timer > -1 timer--
		else {
			//	Walk up and down
			if !moving {
				var ran_x = irandom_range(x-16,x+16)
				var ran_y = irandom_range(y-16,y+16)
				move_to(ran_x,ran_y)
				timer = irandom_range(90,120)
	
			}
			else {
				if point_distance(x,y,xprevious,yprevious) < 1 {
					attemptingToMove++	
				}
				if attemptingToMove >= 100 {
					attemptingToMove = 0
					moving = false
				}
			}
		}
	break
	case state.stunned:
		if timer > -1 timer--
		else {
			state = state.free	
		}
	break
}
