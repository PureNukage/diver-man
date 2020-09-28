hspd = 0
vspd = 0
onGround = true
groundX = x
groundY = y
grav = 0.2
z = 0
xx = 0
yy = 0
xscale = 1
yscale = 1
moveForce = 0
moveDirection = -1
knockbackForce = 0
knockbackDirection = -1
thrust = 0
map = -1

mask_index = s_diverman_collision

madeFootprint = false

function setThrust(Thrust) {
	onGround = false
	thrust = Thrust
}

function applyThrust() {
	
	thrust -= grav
	z += thrust
		
	if y-z >= groundY {
		onGround = true
		y = groundY
		thrust = 0
		if map > -1 and map.z > -1 z = map.z
		else z = 0
		
		////	Footprints
		if object_index == player {
			////	Footsteps
			switch(sign(image_xscale))
			{
				//	Facing Right
				case 1:
					//	Right foot
					if floor(image_index) == 2 {
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
					if floor(image_index) == 6 {
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
			
			if sign(image_xscale) == 1 {
				var XX = X + (16*image_xscale)		
			} else {
				var XX = X - (16*image_xscale)
			}
			var Footprint2 = createParticle(XX,groundY, particles.footprint, 180, 0)
			Footprint2.sprite_index = s_footprint
			Footprint2.image_xscale = round(image_xscale)
			Footprint2.z = z
		}
	}
	
	
}

function setForce(force, direction) {
	
	xx = lengthdir_x(force, direction)
	yy = lengthdir_y(force, direction)

}

function changeMap(Map) {
	
	var oldMap = -1
	var Z = -1
	
	if map == -1 Z = 0
	else Z = map.z
	
	oldMap = map
	
	//	Changing to a map
	if Map > -1 {
		
		if Map.z == -1 {
			if rectangle_in_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom, Map.x,Map.y, Map.x+(sprite_get_width(Map.sprite_index)*Map.image_xscale), Map.y+(sprite_get_height(Map.sprite_index)*Map.image_yscale)) != 1 {
				exit	
			}
		}
		
		//	I am stepping down
		if Z > Map.z {
			if Map.z == -1 {
				onGround = false	
			} else {
				groundY = groundY + Map.z
				if groundY > y-z onGround = false
			}
		}
		//	I am jumping up
		else {
			groundY = groundY - Map.z
		}
		
	}
	//	Changing to no map/z = 0
	else {
		groundY = groundY + map.z

		if groundY >= y-z {
			onGround = false
			z -= 1	
		}
	}
	
	map = Map
}

function applyMovement() {
	
	for(var X=0;X<abs(xx);X++) {
		if !place_meeting(groundX + sign(xx), groundY, collision) {
			if place_meeting(groundX + sign(xx), groundY, collisionMap) {
				var Map = instance_place(groundX + sign(xx), groundY, collisionMap)
				if (z >= Map.z or map == Map) {
					groundX += sign(xx)
					if (map == -1 or (map > -1 and map != Map)) and instance_place(groundX + sign(xx), (groundY-z), Map) {
						changeMap(Map)
					}
				} 
				//	We're not high enough to enter this map
				else {
					if groundY < Map.y + Map.z {
						groundX += sign(xx)	
					}
				}
			//	Not colliding with collision or a collisionMap
			}
			else {
				groundX += sign(xx)
				if map > -1 {
					changeMap(-1)	
				}
			}
		}
		//	Collision happening
		else {
			var Collision = instance_place(groundX + sign(xx), groundY, collision)
			if Collision.topWall {
				//	If we are higher than the topWall
				if z >= Collision.map.z {
					if map == -1 or map != Collision.map {
						changeMap(Collision.map) 
					} else if map == Collision.map {
						changeMap(-1)
					}
				}
				else if map == Collision.map {
					changeMap(-1)
				}
			}
		}
	}
	
	for(var Y=0;Y<abs(yy);Y++) {
		if !place_meeting(groundX, groundY + sign(yy), collision) {
			if place_meeting(groundX, groundY + sign(yy), collisionMap) {
				var Map = instance_place(groundX, groundY + sign(yy), collisionMap)
				if (z >= Map.z or map == Map) {
					groundY += sign(yy)
					if !onGround y += sign(yy)
					if (map == -1 or (map > -1 and map != Map)) and instance_place(groundX, (groundY-z) + sign(yy), Map) {
						changeMap(Map)
					}
				}
				//	We're not high enough to enter this map
				else {
					if groundY + sign(yy) < Map.y + Map.z {
						groundY += sign(yy)
						if !onGround y += sign(yy)
					}					
				}
			}
			//	Not colliding with collision or collisionMap
			else {
				groundY += sign(yy)
				if !onGround y += sign(yy)	
				if map > -1 {
					changeMap(-1)
				}	
			}
		}
		//	Hitting collision
		else {
			var Collision = instance_place(groundX, groundY + sign(yy), collision)
			if Collision.topWall {
				if z >= Collision.map.z {
					if map == -1 or map != Collision.map {
						map = Collision.map
						groundY -= map.z
						while place_meeting(groundX,groundY,Collision) {
							groundY -= 1	
						}
						//changeMap(Collision.map) 
					} else if map == Collision.map {
						groundY += map.z
						while place_meeting(groundX,groundY,Collision) {
							groundY += 1	
						}
						if groundY > y-z onGround = false
						map = -1	
						//changeMap(-1)
					}
				}
				else if map == Collision.map {
					groundY += map.z
					while place_meeting(groundX,groundY,Collision) {
						groundY += 1	
					}
					if groundY > y-z onGround = false
					map = -1
					//changeMap(-1)
				}
			}
		}
	}
	
	xx = 0
	yy = 0
	
}

function draw_shadow() {
	
	draw_set_color(c_black)
	
	var Z = 0
	if map > -1 Z = map.z
	var Alpha = (1 - ((z) / (100+Z))) * .25
	
	draw_set_alpha(Alpha)

	var Z = 0
	if map > -1 Z = map.z
	else if !onGround Z = 0

	var extraWidth = 6
	draw_ellipse(bbox_left-extraWidth,bbox_top-Z,bbox_right+extraWidth,bbox_bottom-Z,false)
	
	draw_reset()
	
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
			
			//var Bubble = instance_create_layer(scatterX,scatterY,"Instances",particle)
			//Bubble.image_xscale = Size
			//Bubble.image_yscale = Size
			//Bubble.Speed = Speed
			//Bubble.duration = irandom_range(30,60)
			//Bubble.durationMax = Bubble.duration
			//Bubble.particles = particles.bubble
			var Bubble = createParticle(scatterX,scatterY,particles.bubble,irandom_range(30,60),Speed)
			Bubble.image_xscale = Size
			Bubble.image_yscale = Size
			
		}
		
	}
}