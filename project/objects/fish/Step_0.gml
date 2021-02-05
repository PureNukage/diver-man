event_inherited()

switch(state) {
	case state.free:
		
		if !moving {
			if timer > -1 {
				player_check()
				timer--
			}
			else {
				random_move(128)
				timer = irandom_range(30,60)
			}
		}
		else {
			if speedBurst {
				maxMovespeed = 1 
				speedBurst = false
			}
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
		
		if school > -1 and !point_in_rectangle(x,y, school.x-school.width/2,school.y-school.height/2, school.x+school.width/2,school.y+school.height/2) and !speedBurst {
			move_to(irandom_range(school.x-school.width/2, school.x+school.width/2), irandom_range(school.y-school.height/2, school.y+school.height/2))
			speedBurst = true
			maxMovespeed = 3
		}
		
	break
}