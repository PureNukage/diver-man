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
		
			jumpHalt = true
		}
		
		
		////	Footprints
		if object_index == player and app.underwater {
			var Footprint = createParticle(groundX+4,groundY-2,particles.footprint,180,0)
			Footprint.sprite_index = s_footprint
			Footprint.z = z
			
			var Footprint = createParticle(groundX-14,groundY-2,particles.footprint,180,0)
			Footprint.sprite_index = s_footprint
			Footprint.z = z
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
			var _groundY = groundY 
			if map > -1 _groundY += map.z
			groundY = _groundY - Map.z
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
					var list = ds_list_create()
					var count = instance_place_list(groundX, groundY + 1, collisionMap, list, true)
					var ID = instance_place(groundX, groundY + 1, collisionMap)
					//	We're colliding with more than one map, lets change to a map that isn't our previous map (find more conditions)
					if count > 1 and ID == oldMap {
						for(var a=0;a<count;a++) {
							var _id = list[| a]
							if _id != oldMap var ID = _id
						}
					}
					//	We've landed on a different map! exit loop
					if ID != oldMap and ID.z == z {
						changeMap(ID)
						ds_list_destroy(list)
						exit
					}
					//	We're above the map
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
					ds_list_destroy(list)
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
	
	repeat(4) {
		var pixelsX = 0
		var pixelsY = 0
		var sub = false
		
		var signX = sign(xx)
		var signY = sign(yy)
		
		//	Whole horizontal pixels
		if abs(xx) > 0 and abs(xx) >= 1 {
			pixelsX = floor(abs(xx))
			xx -= sign(xx) * floor(abs(xx))
		}
		//	Sub horizontal pixels
		else if abs(xx) > 0 and abs(xx) < 1 {
			pixelsX = abs(xx)
			xx = 0
			sub = true
		}
		//	Whole vertical pixels
		else if abs(yy) > 0  and abs(yy) >= 1 {
			pixelsY = floor(abs(yy))
			yy -= sign(yy) * floor(abs(yy))
		}
		//	Sub vertical pixels
		else if abs(yy) > 0 and abs(yy) < 1 {
			pixelsY = abs(yy)
			yy = 0
			sub = true
		}
		
		//	Movement code
		var loops = ceil(pixelsX + pixelsY)
		pixelsX *= signX
		pixelsY *= signY
		for(var i=0;i<loops;i++) {
			if !sub {
				var pX = sign(pixelsX)
				var pY = sign(pixelsY)
			}
			else {
				var pX = pixelsX
				var pY = pixelsY
			}
			//	Not colliding with collision
			if !detectCollision or !place_meeting(groundX + pX, groundY + pY, collision) {
				//	Not colliding with a collisionMap
				if !detectCollision or !place_meeting(groundX + pX, groundY + pY, collisionMap) {
					groundX += pX
					groundY += pY
					if !onGround y += pY
					if map > -1 {
						changeMap(-1)
					}
				}
				//	Colliding with a map
				else {
					var Map = instance_place_highest(groundX + pX, groundY + pY, collisionMap)
					//	We are higher than it or its our map
					if (z >= Map.z ) {
						groundX += pX
						groundY += pY
						if !onGround y += pY
						if (map == -1 or Map != map) {
							//	Check if we're actually on it
							if y > Map.bbox_bottom - Map.width and y-z < Map.bbox_top + Map.width and place_meeting(groundX, groundY, Map) and place_meeting(groundX, y, Map) {
								changeMap(Map)
							} else if map > -1 {
								//	If we're not colliding with current map anymore
								//if !place_meeting(groundX + pX, groundY + pY, map) and groundY > Map.bbox_top + Map.width + 16 {
								if !place_meeting(groundX, groundY, map) and groundY > Map.bbox_top + Map.width + 16 {
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
						if map != Map and map == -1 and groundY + pY <= Map.bbox_bottom - Map.width and collisionCount == 0 {
							groundX += pX
							groundY += pY
							if !onGround y += pY
						}
						else {
							//	Check if we're actually on it
							if map == Map and groundY <= (Map.bbox_top + Map.width + 16) {
								groundX += pX
								groundY += pY
								if !onGround y += pY
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
		
	}
	
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
	if image_xscale == -1 XX = floor(x) - xOffset + (sprite_get_width(sprite_index) - sprite_get_bbox_right(sprite_index))
	var YY = floor(y) - yOffset + sprite_get_bbox_top(sprite_index) - z
	var spriteWidth = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)
	var spriteHeight = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)
	
	var surfaceFinal = -1
	
	if !shadeStatic or !buffer_exists(shadeBuffer) {
		
		if !buffer_exists(shadeBuffer) {
			shadeBuffer = buffer_create(spriteWidth*spriteHeight*4, buffer_grow, 1)	
		}
	
		//	Create the shadow surface
		var bbox_width = floor(abs(bbox_right-bbox_left))
		var bbox_height = floor(abs(bbox_bottom-bbox_top))
		var surfaceShadow = surface_create(bbox_width, bbox_height)
		surface_copy_part(surfaceShadow,0,0,shadows.surface, floor(bbox_left),floor(bbox_top-z), bbox_width,bbox_height)

		//	Draw the shadow surface stretched 
		var ratioWidth = spriteWidth / bbox_width
		var ratioHeight = spriteHeight / bbox_height
		var Width = bbox_width * ratioWidth
		var Height = bbox_height * ratioHeight
		var surfaceShadowStretched = surface_create(Width, Height)
		surface_set_target(surfaceShadowStretched)
		draw_clear_alpha(c_black, 0)
	
		draw_surface_ext(surfaceShadow, 0,0, ratioWidth,ratioHeight, 0, c_white, 1)
	
		surface_reset_target()
		
		//	Create the player cutout
		var surfacePlayerCutout = surface_create(spriteWidth,spriteHeight)
		surface_set_target(surfacePlayerCutout)
		draw_clear_alpha(c_black, 0)
	
		draw_set_color(c_black)
		draw_set_alpha(1)
		draw_rectangle(0,0,spriteWidth,spriteHeight,false)
	
		gpu_set_blendmode(bm_subtract)
		var _xOffset = sprite_get_bbox_left(sprite_index)
		if image_xscale == -1 _xOffset = sprite_get_width(sprite_index) - sprite_get_bbox_right(sprite_index)
		draw_sprite_ext(sprite_index,image_index,xOffset-_xOffset,yOffset-sprite_get_bbox_top(sprite_index),image_xscale,image_yscale,image_angle,c_black,1)
		gpu_set_blendmode(bm_normal)
		surface_reset_target()
		
		//	Create the final shadow surface
		var surfaceFinal = surface_create(surface_get_width(surfacePlayerCutout),surface_get_height(surfacePlayerCutout))
		surface_set_target(surfaceFinal)
		draw_clear_alpha(c_black, 0)
	
		draw_surface(surfaceShadowStretched,0,0)
	
		gpu_set_blendmode(bm_subtract)
		draw_surface_ext(surfacePlayerCutout,0,0,1,1,0,c_black,1)
		gpu_set_blendmode(bm_normal)
		surface_reset_target()
		
		//	If we're a static shaded object, save this surface to a buffer
		if shadeStatic buffer_get_surface(shadeBuffer, surfaceFinal, 0)
	}
	
	else if buffer_exists(shadeBuffer) {
		var surfaceFinal = surface_create(spriteWidth,spriteHeight)
		if !shadeStatic buffer_delete(shadeBuffer)
	}
	
	////	DEBUG
	if object_index == player {
		if surface_exists(surfaceShadow) draw_surface_ext(surfaceShadow, XX,YY-64, 1,1, 0, c_white, 1)
		if surface_exists(surfaceShadowStretched) draw_surface_ext(surfaceShadowStretched, XX + 64,YY - 64, 1,1, 0, c_white, 1)
		if surface_exists(surfacePlayerCutout) draw_surface_ext(surfacePlayerCutout, XX + 96 + spriteWidth,YY-64, 1,1, 0, c_white, 1)
		if surface_exists(surfaceFinal) draw_surface_ext(surfaceFinal, XX + 96 + spriteWidth*2 + 16,YY-64, 1,1, 0, c_white, 1)
	}
	
	if surface_exists(shadeSurface) {
		draw_surface_ext(shadeSurface,XX,YY,1,1,0,c_white, 0.5)		
	}
	else if !shadeStatic {
		draw_surface_ext(surfaceFinal,XX,YY,1,1,0,c_white,0.5)	
	}
	
	if surface_exists(surfaceShadow) surface_free(surfaceShadow)
	if surface_exists(surfaceShadowStretched) surface_free(surfaceShadowStretched)
	if surface_exists(surfacePlayerCutout) surface_free(surfacePlayerCutout)
	if surface_exists(surfaceFinal) surface_free(surfaceFinal)
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
	

	
	
	
