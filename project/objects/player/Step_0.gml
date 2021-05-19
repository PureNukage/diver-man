if !muted {
		
	switch(state)
	{
		#region FREE STATE
			case state.free:
			
				//	Inventory
				if input.keyInventory {
					if inventoryOpen inventory_close()
					else inventory_open()
				}
				
				//	Attacking
				if input.keyAttack and onGround and hasWrench and suitOn and stamina >= 20 {
					useStamina(20, 10)
					if !attack sprite_index = s_diverman_attack
					else sprite_index = s_diverman_attack2
					attack = !attack
					image_index = 0
					image_speed = 1
					moveForce = 5
					state = state.attack
					bubbleTimer = -1
					sound.playSoundEffect(sound_whoosh)
					exit
				}
				
				//	Sprinting
				if input.keyRun and stamina >= 1 and onGround {
					if !running and !runningPress {
						running = true
						runningPress = true
					}
					var staminaAmount = 1
					if !suitOn staminaAmount = 0.5
					useStamina(staminaAmount, 5)
				}
				else {
					if !input.keyRun and runningPress runningPress = false
					if running {
						running = false
					}
				}
					
				//	Jump halt logic
				if jumpHalt {
					if sprite_index == s_diverman_jump {
						canMove = false	
						if animation_end {
							jumpHalt = false	
							canMove = true
						}
					} else {
						canMove = true
						jumpHalt = false
					}
				}
				
				//	Modifying max movespeed based on suit and sprinting
				if suitOn {
					if !running maxMovespeed = 2.25
					else maxMovespeed = 3.25
				}
				else {
					if !running maxMovespeed = 2.5
					else maxMovespeed = 3.5
				}
					
				visible = true
				
				//	Allow movement input if we're not in dialogue and I can move
				if !instance_exists(response) and canMove {
					hspd = (input.keyRight - input.keyLeft) + input.gamepadAxisLH
					vspd = (input.keyDown - input.keyUp) + input.gamepadAxisLV
				}
				else if !canMove {
					hspd = 0
					vspd = 0
				}
			
				//if !suitOn sprite_index = s_kid_player

				//	I have movement input!
				if (hspd != 0 or vspd != 0) {
					moveDirection = point_direction(0,0,hspd,vspd)
					//moveForce += 0.05
					moveForce += 0.1
					moveForce = clamp(moveForce,0,maxMovespeed)

					setForce(moveForce, moveDirection)
	
					if hspd != 0 image_xscale = sign(hspd) * xscale
			
					if !jumpHalt {
						image_speed = (moveForce/maxMovespeed)
						image_speed = clamp(image_speed,.2,1)
					}
	
					////	Footprints
					if onGround and app.underwater footprint()
						
				} 
				//	Not inputting 
				else {
					if moveForce > 0 {
						moveForce--
					}
					else {
						image_speed = 1
						moveForce = 0
					}
				}
	
				//	Hold jump to jump higher
				if !onGround and jumping > -1 {
					if input.keyJumping and jumping < 5 {
						setThrust(thrust + 0.5)	
					}
					jumping--
				}
				////	Jumping
				if input.keyJump and onGround and app.underwater and !jumpHalt and stamina >= 20 {
					useStamina(20, 30)
					setThrust(3)
					image_speed = 1
					jumping = 10
					sound.playSoundEffect(sound_jumpup_water)
				}

				if !onGround applyThrust()
				
				////	Determine sprite
				if onGround {
					//	Moving
					if (hspd != 0 or vspd != 0) {
						if suitOn {
							if jumpHalt {
								sprite_index = s_diverman_jump
							} else {
								if running {
									sprite_index = s_diverman_sprint	
								}
								else
								if sprite_index != s_diverman_walk {
									sprite_index = s_diverman_walk
								}
							}
						}
						//	Kid
						else {
							if running {
								sprite_index = s_kid_player_running
							}
							else {
								sprite_index = s_kid_player_walk
							}
						}
					}
					//	Not moving
					else {
						if suitOn {
							if moveForce == 0 and sprite_index != s_diverman_idle and !jumpHalt {
								sprite_index = s_diverman_idle
							}	
						}
						//	Kid
						else {
							sprite_index = s_kid_player
						}
					}
				} 
				//	In the air
				else {
					//	Going up
					if thrust > 0 {
						if suitOn {
							sprite_index = s_diverman_jump
							image_index = 0
						}
					}
					//	Going down
					else {
						if suitOn {
							if sprite_index != s_diverman_jump {
								sprite_index = s_diverman_jump
							}
							if image_index >= 2 {
								image_index = 2
							}
						}
					}
				}
				
			break	
		#endregion
			
		#region ATTACK STATE
			case state.attack:
				
				//	Momentum in direction of attack
				setForce(moveForce, moveDirection)
				if moveForce > 0 moveForce--
					
				//	Attack animation finished
				if animation_end {
					state = state.free	
				}
					
			break
		#endregion
	}

	applyMovement()

	if onGround {
		x = groundX
		y = groundY + z
	} else {
		x = groundX	
	}
	
	//	Recharge stamina
	if staminaRechargeCooldown > 0 staminaRechargeCooldown--
	else {
		var staminaRecharge = 0.5
		if !suitOn staminaRecharge = 0.75
		if moveForce == 0 staminaRecharge = 1
		if stamina < staminaMax {
			stamina += staminaRecharge
			stamina = clamp(stamina,0,staminaMax)
		}
	}

	if app.underwater bubbles(false)
}
else visible = false
