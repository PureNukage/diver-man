event_inherited()

Crane = -1

shadowEllipse = false
drawShadow = false
drawUnit = false

interactibility = true

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
		if app.cameraFocusOnPlayer app.cameraFocusOnPlayer = false
		//if instance_exists(rope) rope.depth = depth + 1
	}
	
	var Z = 0
	switch(up_or_down)
	{
		case up:
			Z = 2
			
			////	Underwater
			if app.underwater {
				if z >= 100 and app.roomTransitionTo == -1 {
					var Room = RoomDocks
					if Room == -1 Room = RoomDocks
					app.roomTransition(Room, 5)
				}
				
				if z < 360 {
					app.cameraFocus(x,y+z,1,true)	
				}
			}
			////	Surface
			else {
				if z < 240 and Crane > -1 {
					app.cameraFocus(x,Crane.y,"~",false)	
				}
				else {
					app.cameraFocus(x,y-z-180,1,true)
				}	
			}
		
		break
		
		case down:
			Z = -2
			
			////	Underwater
			if app.underwater {

				
				if z > 0 {
					app.cameraFocus(x,y+z,1,true)
				}
				else {
					app.cameraFocus(player.x,player.y,1,true)	
				}
			}
			////	Surface
			else {
				if z < 0 and Crane > -1 {
					app.cameraFocus(x,Crane.y,"~",false)	
				}
				
				if z <= -100 and app.roomTransitionTo == -1 {
					app.roomTransition(RoomDocks_Underwater, 5)	
				}
			}
			


		break
	}
	
	z += Z
	
	if lowered and z >= 360 {
		debug.log("Cage has been lifted")	
		inUse = false
		lowered = false
		
		liftDirection = down
		
		if filled filled = false
		
		player.canMove = true
		player.muted = false
		player.groundY -= 32
		player.y -= 32
		
		z = 0
		y -= 360
		
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
			filled = false
		}
		
		liftDirection = up
		
	}
	
	if filled draw_sprite_ext(player.sprite_index,player.image_index, x+(2*player.image_xscale),y-z-12, player.image_xscale,player.image_yscale,player.image_angle,player.image_blend,player.image_alpha)
	
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
	//	Underwater
	else {
		//	Clear the rope
		for(var i=1;i<rope.verticeCount-1;i++) {
			rope.delete_vertex(i)	
		}
	}
	
}