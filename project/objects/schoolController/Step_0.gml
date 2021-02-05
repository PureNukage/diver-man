event_inherited()

switch(state) {
	case state.free:
		
		if !moving {
			if timer > -1 {
				player_check()
				timer--
			}
			else {
				random_move(64)
				timer = irandom_range(120,180)
			}
		}
		else {
			if point_distance(x,y,xprevious,yprevious) < 1 {
				attemptingToMove++	
			}
			if attemptingToMove >= 100 {
				if timer > -1 timer--
				else {
					attemptingToMove = 0
					moving = false
				}
			}	
		}
		
	break
}

