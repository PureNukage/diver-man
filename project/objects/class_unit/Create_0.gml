hspd = 0
vspd = 0
canMove = true
onGround = true
groundX = x
groundY = y
grav = 0.2
detectCollision = true
maxMovespeed = 2
jumpHalt = false
z = 0
xx = 0
yy = 0
xscale = 1
yscale = 1
flee = false
moveForce = 0
moveDirection = -1
knockbackForce = 0
knockbackDirection = -1
thrust = 0
map = -1
damaged = false
damagedTimer = -1
flash = false
flashDuration = -1
hpMax = 5
hp = hpMax
shadowEllipse = true
interactibility = false
interactable = false
interactCD = -1
drawShadow = true
drawUnit = true
depth = -y
path = path_add()
pos = 1
xGoto = -1
yGoto = -1
timer = -1
depthY = true
image_index = irandom_range(0,image_number-1)

madeFootprint = false

function setDamage(amount, _flashDuration) {
	hp -= amount
	
	damaged = true
	damagedTimer = 45
	
	if _flashDuration > 0 {
		flash = true
		flashDuration = _flashDuration
	}
	else {
		flash = false
		flashDuration = -1
	}
}

function applyDamage() {
	
	//	Damage timer
	if damagedTimer > 0 {
		damagedTimer--	
	}
	else if damagedTimer <= 0 {
		damaged = false
		damagedTimer = -1
	}
	
	//	Flash timer
	if flashDuration > 0 {
		flashDuration--	
	}
	else if flashDuration <= 0 {
		flash = false
		flashDuration = -1
	}
}

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
		
		if moveForce > 0 moveForce -= 3
		
		////	Sand poof
		if object_index == player and app.underwater {
			var Poof = instance_create_layer(x,y,"Instances",particle)
			Poof.particles = particles.dustpoof
			Poof.sprite_index = s_diverman_jumping_dustpoofs
			Poof.duration = 30
			
			sound.playSoundEffect(sound_jumpdown_water)
		
			//jumpHaltDuration = 30
			jumpHalt = true
			//canMove = false
		}
		
		
		////	Footprints
		if object_index == player and app.underwater {
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
				//	Smooth loop to lower groundY (looking for collision)
				for(var i=0;i<map.z;i++) {
					if !place_meeting(groundX,groundY + 1, collision) {
						if !place_meeting(groundX,groundY + 1, collisionMap) groundY += 1	
						else {
							var ID = instance_place(groundX, groundY + 1, collisionMap)
							if (map.z - i) > ID.z {
								//	We're above the map
								if groundY + 1 < ID.bbox_top + ID.width {
									groundY += 1
								}
								//	Lower us onto the map
								else if groundY + 1 >= ID.bbox_bottom-ID.width {
									groundY += 1	
								}
							}
						}
					}
				}

				if groundY > y-z {
					onGround = false
					z -= 1	
				}
			}
		}
		//	I am jumping up
		else {
			groundY = y - Map.z
		}
		
	}
	//	Changing to no map/z = 0
	else {
		
		//	Smooth loop to lower groundY (looking for collision)
		var above_or_below = -1	//	0 = above, 1 = below
		for(var i=0;i<map.z;i++) {
			if !place_meeting(groundX, groundY + 1, collision) {
				if !place_meeting(groundX,groundY + 1, collisionMap) groundY += 1	
				else {
					var ID = instance_place(groundX, groundY + 1, collisionMap)
					//	We're above the map
					//if groundY + 1 < ID.bbox_top + ID.width {
					if groundY + 1 < ID.bbox_bottom - ID.width {
						groundY += 1
						if above_or_below == -1 above_or_below = 0
					}
					//	Lower us onto the map
					else if groundY + 1 >= ID.bbox_bottom-ID.z {
						if above_or_below == 1 groundY += 1
						if above_or_below == -1 above_or_below = 1
					}
					else if (map.z - i) > ID.z {
						groundY += 1
					}
				}
			}
		}

		if groundY >= y-z {
			onGround = false
			z -= 1	
		}
	}
	
	map = Map
}

function applyMovement() {
	
	var subX = (abs(xx) - floor(abs(xx))) * sign(xx)
	var subY = (abs(yy) - floor(abs(yy))) * sign(yy)
	
	for(var X=0;X<abs(xx);X++) {
		//	Not colliding with collision
		if !detectCollision or !place_meeting(groundX + sign(xx), groundY, collision) {
			//	Not colliding with a collisionMap
			if !detectCollision or !place_meeting(groundX + sign(xx), groundY, collisionMap) {
				groundX += sign(xx)
				if map > -1 {
					changeMap(-1)
				}
			}
			//	Colliding with a map
			else {
				var Map = instance_place_highest(groundX + sign(xx), groundY, collisionMap)
				//	We are higher than it or its our map
				if (z >= Map.z ) {
					groundX += sign(xx)
					if (map == -1 or Map != map) {
						//	Check if we're actually on it
						if y > Map.bbox_bottom - Map.width and y-z < Map.bbox_top + Map.width and place_meeting(groundX, groundY, Map) and place_meeting(groundX, y, Map) {
							changeMap(Map)
						} else if map > -1 {
							//	If we're not colliding with current map anymore
							if !place_meeting(groundX + sign(xx), groundY, map) and groundY > Map.bbox_top + Map.width + 16 {
								changeMap(-1)
							}
						}
					}
					else if map == Map and groundY >= (Map.bbox_top + Map.width + 16) {
						changeMap(-1)	
					}
				}
				else {
					var collisionCount = maps_collision_count(x,y)
					//	We're behind this map
					if map != Map and map == -1 and groundY <= Map.bbox_bottom - Map.width and collisionCount == 0 {
						groundX += sign(xx)
					}
					else {
						//	Check if we're actually on it
						if map == Map and groundY <= (Map.bbox_top + Map.width + 16) {
							groundX += sign(xx)	
						}
						//	Not on the map, fall
						else {
							//if map > -1 changeMap(-1)	
						}
					}
				}
			}
		}
	}
	
	for(var Y=0;Y<abs(yy);Y++) {
		//	Not colliding with collision
		if !detectCollision or !place_meeting(groundX, groundY + sign(yy), collision) {
			//	Not colliding with a collisionMap
			if !detectCollision or !place_meeting(groundX, groundY + sign(yy), collisionMap) {
				groundY += sign(yy)
				if !onGround y += sign(yy)
				if map > -1 {
					changeMap(-1)
				}
			}
			//	Colliding with a map
			else {
				var Map = instance_place_highest(groundX, groundY + sign(yy), collisionMap)
				//	We are higher than it
				if (z >= Map.z) {
					groundY += sign(yy)
					if !onGround y += sign(yy)
					if map == -1 or map != Map {
						if y > Map.bbox_bottom - Map.width and y-z < Map.bbox_top + Map.width and place_meeting(groundX, groundY, Map) and place_meeting(groundX, y, Map) {
							changeMap(Map)
						} else if map > -1 {
							if !place_meeting(groundX, groundY + sign(yy), map) and groundY > Map.bbox_top + Map.width + 16 changeMap(-1)
						}
					}
					else if map == Map and groundY + sign(yy) >= (Map.bbox_top + Map.width + 16) {
						changeMap(-1)	
					}
				}
				else {
					var collisionCount = maps_collision_count(x,y)
					//	We're behind this map 
					if map != Map and groundY + sign(yy) <= Map.bbox_bottom - Map.width {
						groundY += sign(yy)
						if !onGround y += sign(yy)
					}
					else {
						//	Check if we're actually on it
						if map == Map and groundY + sign(yy) <= (Map.bbox_top + Map.width + 16) {	
							groundY += sign(yy)
							if !onGround y += sign(yy)
						}
						//	We are not on the map, fall
						else if map > -1 {
							//changeMap(-1)
						}
					}
				}
			}
		}
	}
		
	if subX > 0 {
		//	Not colliding with collision
		if !detectCollision or !place_meeting(groundX + subX, groundY, collision) {
			//	Not colliding with a collisionMap
			if !detectCollision or !place_meeting(groundX + subX, groundY, collisionMap) {
				groundX += subX
				if map > -1 {
					changeMap(-1)
				}
			}
			//	Colliding with a map
			else {
				var Map = instance_place_highest(groundX + subX, groundY, collisionMap)
				//	We are higher than it or its our map
				if (z >= Map.z ) {
					groundX += subX
					if (map == -1 or Map != map) {
						//	Check if we're actually on it
						if y > Map.bbox_bottom - Map.width and y-z < Map.bbox_top + Map.width and place_meeting(groundX, groundY, Map) and place_meeting(groundX, y, Map) {
							changeMap(Map)
						} else if map > -1 {
							//	If we're not colliding with current map anymore
							if !place_meeting(groundX + subX, groundY, map) changeMap(-1)
						}
					}
					else if map == Map and groundY >= (Map.bbox_top + Map.width + 16) {
						changeMap(-1)	
					}
				}
				else {
					var collisionCount = maps_collision_count(x,y)
					//	We're behind this map
					if map != Map and map == -1 and groundY <= Map.bbox_bottom - Map.width and collisionCount == 0 {
						groundX += subX
					}
					else {
						//	Check if we're actually on it
						if map == Map and groundY <= (Map.bbox_top + Map.width + 16) {
							groundX += subX
						}
						//	Not on the map, fall
						else {
							//if map > -1 changeMap(-1)	
						}
					}
				}
			}
		}
	}
	
	if subY > 0 {
		//	Not colliding with collision
		if !detectCollision or !place_meeting(groundX, groundY + subY, collision) {
			//	Not colliding with a collisionMap
			if !detectCollision or !place_meeting(groundX, groundY + subY, collisionMap) {
				groundY += subY
				if !onGround y += subY
				if map > -1 {
					changeMap(-1)
				}
			}
			//	Colliding with a map
			else {
				var Map = instance_place_highest(groundX, groundY + subY, collisionMap)
				//	We are higher than it
				if (z >= Map.z) {
					groundY += subY
					if !onGround y += subY
					if map == -1 or map != Map {
						if y > Map.bbox_bottom - Map.width and y-z < Map.bbox_top + Map.width and place_meeting(groundX, groundY, Map) and place_meeting(groundX, y, Map) {
							changeMap(Map)
						} else if map > -1 {
							if !place_meeting(groundX + sign(xx), groundY, map) changeMap(-1)
						}
					}
					else if map == Map and groundY + subY >= (Map.bbox_top + Map.width + 16) {
						changeMap(-1)	
					}
				}
				else {
					var collisionCount = maps_collision_count(x,y)
					//	We're behind this map 
					if map != Map and groundY + subY <= Map.bbox_bottom - Map.width {
						groundY += subY
						if !onGround y += subY
					}
					else {
						//	Check if we're actually on it
						if map == Map and groundY + subY <= (Map.bbox_top + Map.width + 16) {	
							groundY += subY
							if !onGround y += subY
						}
						//	We are not on the map, fall
						else if map > -1 {
							//changeMap(-1)
						}
					}
				}
			}
		}	
	}
		
	
	//debug.log("xx: "+string(floor(abs(xx))))
	//debug.log("yy: "+string(floor(abs(yy))))
	//debug.log("subX: "+string(subX))
	//debug.log("subY: "+string(subY))
	
	
	xx = 0
	yy = 0
	
}
	
function draw_unit() {
	if flash shader_set(shader_flash)
	draw_sprite_ext(sprite_index,image_index,floor(x),floor(y-z),image_xscale,image_yscale,image_angle,image_blend,image_alpha)	
	shader_reset()
}

function draw_shadow() {
	
	draw_set_color(c_black)
	
	var Z = 0
	if map > -1 Z = map.z
	var Alpha = (1 - ((z) / (100+Z))) * .25
	
	Alpha = clamp(Alpha, 0.1, 1)
	
	draw_set_alpha(Alpha)

	var Z = 0
	if map > -1 Z = map.z
	else if !onGround Z = 0

	var extraWidth = 6 * ((1 - ((z) / (100+Z))))
	if shadowEllipse draw_ellipse(bbox_left-extraWidth,bbox_top-Z,bbox_right+extraWidth,bbox_bottom-Z,false)
	else draw_rectangle(bbox_left-extraWidth,bbox_top-Z,bbox_right+extraWidth,bbox_bottom-Z,false)
	
	draw_reset()
	
}

function draw_shadow_ext(_z, _map) {
	
	draw_set_color(c_black)
	
	var zDrop = 160	//	How much z until the shadow is no longer visible
	
	//	This should have it be a solid circle if right under the player and invisible if >= zDrop
	var Alpha = ((zDrop - (z - _z)) / zDrop) * .4
	
	var surface = surface_create(room_width, room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	draw_set_alpha(1)
	var widthBase = 20
	var Width = widthBase * ((zDrop - (z - _z)) / zDrop)
	//debug.log(string(Width))
	var correction = 12
	if shadowEllipse draw_ellipse(bbox_left+correction-Width,bbox_top-_z,bbox_right-correction+Width,bbox_bottom-_z,false)
	else draw_rectangle(bbox_left,bbox_top-_z,bbox_right,bbox_bottom-_z,false)
	
	if _map > -1 {
		var cutterSurface = surface_create(room_width,room_height)
		var index = -1
		for(var i=0;i<water.heightMapCount;i++) {
			if water.heightMaps[i][0] == _z index = i
		}
		if index > -1 and surface_exists(water.heightMaps[index][2]) {
			gpu_set_blendmode(bm_subtract)
			draw_surface_ext(water.heightMaps[index][2],0,0,1,1,0,c_black,1)
			gpu_set_blendmode(bm_normal)
		}
		
		surface_free(cutterSurface)
	}
	//	Use every map as a mask for the base shadow
	else if map > -1 and _map == -1 {
		gpu_set_blendmode(bm_subtract)	
		if surface_exists(water.collisionMapsSurface) draw_surface_ext(water.collisionMapsSurface,0,0,1,1,0,c_black,1)
		gpu_set_blendmode(bm_normal)
	}
	
	surface_reset_target()
	
	draw_set_alpha(Alpha)
	draw_surface(surface,0,0)
	
	surface_free(surface)

}

shadeStatic = true
shadeBuffer = -1
shadeSurface = -1
function draw_shade() {
	
	var xOffset = sprite_get_xoffset(sprite_index)
	var yOffset = sprite_get_yoffset(sprite_index)
	var XX = floor(x) - xOffset + sprite_get_bbox_left(sprite_index)
	var YY = floor(y) - yOffset + sprite_get_bbox_top(sprite_index) - z
	var spriteWidth = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)
	var spriteHeight = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)
	
	var surface = -1
	var surface2 = -1
	var surface3 = -1
	var surface4 = -1
	var surfaceFinal = -1
	
	if !shadeStatic or !buffer_exists(shadeBuffer) {
		
		if !buffer_exists(shadeBuffer) {
			shadeBuffer = buffer_create(spriteWidth*spriteHeight*4, buffer_grow, 1)	
		}
	
		var bbox_width = floor(abs(bbox_right-bbox_left))
		var bbox_height = floor(abs(bbox_bottom-bbox_top))
		var surface = surface_create(bbox_width, bbox_height)
		surface_set_target(surface)
		draw_clear_alpha(c_black, 0)
		surface_reset_target()
		
		var shadowSurface = surface_create(room_width, room_height)
		surface_set_target(shadowSurface)
		draw_clear_alpha(c_white, 0)
		surface_reset_target()
		buffer_set_surface(shadows.surfaceBuffer,shadowSurface,0)
	
		surface_copy_part(surface,0,0,shadowSurface, floor(bbox_left)+z,floor(bbox_top), bbox_width,bbox_height)
		
		surface_free(shadowSurface)

		//	Draw the surface stretched on top of the sprite_index
		var surface2 = surface_create(room_width,room_height)
		surface_set_target(surface2)
		draw_clear_alpha(c_black, 0)
	
		var ratioWidth = spriteWidth / bbox_width
		var ratioHeight = spriteHeight / bbox_height
		draw_surface_ext(surface, XX,YY, ratioWidth,ratioHeight, 0, c_white, 1)
		//draw_surface_ext(lighting.surface,0,0,1,1,0,c_white,lighting.darkness)
	
		surface_reset_target()
		draw_set_alpha(1)
		
	
		var surface3 = surface_create(spriteWidth,spriteHeight)
		surface_set_target(surface3)
		draw_clear_alpha(c_black, 0)
	
		draw_set_color(c_black)
		draw_set_alpha(1)
		draw_rectangle(0,0,spriteWidth,spriteHeight,false)
		surface_reset_target()
	
		var surface4 = surface_create(spriteWidth,spriteHeight)
		surface_set_target(surface4)
		draw_clear_alpha(c_black, 0)
		surface_reset_target()
	
		surface_copy_part(surface4,0,0,surface2,XX,YY,spriteWidth,spriteHeight)
	
		surface_set_target(surface3)
		gpu_set_blendmode(bm_subtract)
		draw_sprite_ext(sprite_index,image_index,xOffset-sprite_get_bbox_left(sprite_index),yOffset-sprite_get_bbox_top(sprite_index),image_xscale,image_yscale,image_angle,c_black,1)
		gpu_set_blendmode(bm_normal)
		surface_reset_target()
	
		var surfaceFinal = surface_create(surface_get_width(surface3),surface_get_height(surface3))
		surface_set_target(surfaceFinal)
		draw_clear_alpha(c_black, 0)
	
		draw_surface(surface4,0,0)
	
		gpu_set_blendmode(bm_subtract)
		draw_surface_ext(surface3,0,0,1,1,0,c_black,1)
		gpu_set_blendmode(bm_normal)
		surface_reset_target()
		
		buffer_get_surface(shadeBuffer, surfaceFinal, 0)
	}
	
	else if buffer_exists(shadeBuffer) {
		var surfaceFinal = surface_create(spriteWidth,spriteHeight)
		if !shadeStatic buffer_delete(shadeBuffer)
	}
	
	////	DEBUG
	if object_index == player {
		//if surface_exists(surface) draw_surface_ext(surface, XX + 64,YY, 1,1, 0, c_white, 1)
		//if surface_exists(surface2) draw_surface_ext(surface2, XX + 128 - abs(x),YY - y + abs(spriteHeight), 1,1, 0, c_white, 1)
		//if surface_exists(surface3) draw_surface_ext(surface3, XX + 192,YY, 1,1, 0, c_white, 1)
		//if surface_exists(surface4) draw_surface_ext(surface4, XX + 256,YY, 1,1, 0, c_white, 1)
	}
	
	if surface_exists(shadeSurface) {
		draw_surface_ext(shadeSurface,XX,YY,1,1,0,c_white, 0.5)		
	}
	else if !shadeStatic {
		draw_surface_ext(surfaceFinal,XX,YY,1,1,0,c_white,0.5)	
	}
	
	if surface_exists(surface) surface_free(surface)
	if surface_exists(surface2) surface_free(surface2)
	if surface_exists(surface3) surface_free(surface3)
	if surface_exists(surfaceFinal) surface_free(surfaceFinal)
	if surface_exists(surface4) surface_free(surface4)
	//if surface_exists(shadowSurface) surface_free(shadowSurface)
}
	
bubbleTimer = -1
bubbleTimerMax = irandom_range(120,180)
function bubbles(_sound) {
	if bubbleTimer > 0 bubbleTimer--
	else {
		
		bubbleTimer = irandom_range(120,180)
		
		var bubbleCount = irandom_range(3,6)
		
		for(var i=0;i<bubbleCount;i++) {
			
			var Size = random_range(0.3,0.8)
			
			var scatter = 12
			var scatterX = irandom_range(x - scatter, x + scatter)
			var scatterY = irandom_range(y-z - 32 - scatter, y-z - 32 + scatter)
			
			var Speed = irandom_range(1,2)
		
			var Bubble = createParticle(scatterX,scatterY,particles.bubble,irandom_range(30,60),Speed)
			Bubble.image_xscale = Size
			Bubble.image_yscale = Size
			
		}
		
		if _sound sound.playSoundEffect(choose(sound_bubbles_0, sound_bubbles_1, sound_bubbles_2))
		
	}
}	
	
////	Inventory
inventory = ds_list_create()

function create_item(item_index) {
	var Item = new _create_item(item_index)
	ds_list_add(inventory, Item)
}

function remove_item(item_list_index) {
	if item_list_index > -1 ds_list_delete(inventory, item_list_index)
	else debug.log("ERROR Trying to remove -1 item from inventory")
}

function item_check(item_index) {
	for(var i=0;i<ds_list_size(inventory);i++) {
		var Item = inventory[| i]
		if Item.index == item_index return i
	}
	return -1
}

function _create_item(item_index) constructor {
	index = item_index
}
	
	
	
