switch(particles)
{
	case particles.jellyfish:
		
		
		
		if timer == -1 {
			
			if amount < amountMax {
				var scatter = 92
				var X = x
				var Y = y
				var Amount = amount
				for(var i=0;i<(amountMax - amount);i++) {
					var Jellyfish = createParticle(X,Y, particles.jellyfish, -1, 0)
					Jellyfish.temporary = false
					Jellyfish.myEmitter = id
					
					var flip1 = choose(0,1)
					var flip2 = choose(0,1)
					if flip1 {
						if flip2 X -= scatter
						else X += scatter
					} else {
						if flip2 Y -= scatter
						else Y += scatter
					}
					Jellyfish.moveDirection = moveDirection
					Amount++
				}
				amount = Amount
			}	
			
			timer = 120
		}
		else timer--
		
	break
}