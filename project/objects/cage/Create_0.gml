event_inherited()

shadowEllipse = false

//startingGame = false
lowered = true
inUse = false
liftDirection = down
filled = false
function lift(up_or_down) {
	
	if filled {
		player.muted = true
		player.sprite_index = s_diverman_idle
		player.x = x
		player.y = y-z
		player.groundX = x
		player.groundY = y-z
	}
	
	var Z = 0
	switch(up_or_down)
	{
		case up:
			Z = 2	
		break
		
		case down:
			Z = -2
			
			if !app.underwater {
				if z <= -100 and app.roomTransitionTo == -1 {
					app.roomTransition(Room1, 5)	
				}
			}
		break
	}
	
	if !app.paused z += Z
	
	if lowered and z >= 360 {
		debug.log("Cage has been lifted")	
		inUse = false
		lowered = false
		
		//liftDirection = down
		//room_goto(RoomMainMenu)
		//app.cameraRefresh()
		//app.underwaterChange(false)
		
		//	We're underwater, lets surface
		if app.underwater and room != RoomDock {
			app.roomTransition(RoomDock, 5)
			app.underwaterChange(false)
		}
	}
	else if (app.underwater and !lowered and z <= 0) or (!app.underwater and !lowered and z <= -360) {
		debug.log("Cage has been lowered")
		inUse = false
		lowered = true
		if !app.underwater z = -360
		
		if filled and app.underwater {
			player.muted = false
			player.groundX = x
			player.groundY = y
		}
		
		liftDirection = up
		
		//	We're on the surface
		if !app.underwater and room == RoomDock {
			//app.roomTransition(Room1, 5)
			//room_goto(Room1)
			//app.cameraRefresh = true
			//app.underwaterChange(true)
		}
		
		//liftDirection = up
		
	}
	
	////	Assemble the pieces to the cage (plus the player!)
	draw_sprite(s_cage_floor,0,x,y-z)
	
	if filled draw_sprite_ext(player.sprite_index,player.image_index, x,y-z, player.image_xscale,player.image_yscale,player.image_angle,player.image_blend,player.image_alpha)
	
	draw_sprite(s_cage_roof,0,x,y-z)
	draw_sprite(s_cage_bars,0,x,y-z)
	
}
	
function useLift(up_or_down, Filled) {
	
	liftDirection = up_or_down
	
	if Filled {
		filled = true	
	}
	
	inUse = true
	
	if !app.underwater {
		if instance_exists(crane) crane.image_speed = 1
	}
	
}