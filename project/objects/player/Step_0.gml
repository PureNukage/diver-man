if !app.paused {
	//image_speed = 1
	if !muted {
		
		switch(state)
		{
			#region FREE STATE
				case state.free:
				
					//	Attacking
					if input.keyAttack and onGround {
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
					if input.keyRun and suitOn {
						if !running {
							running = true
						}
					}
					else if running {
						running = false	
					}
				
					//	I just jumped!
					if jumpHaltDuration > 0 {
						jumpHaltDuration--
					}
					else if jumpHaltDuration == 0 {
						jumpHaltDuration--	
					}
				
					//	Modifying max movespeed based on suit and sprinting
					if suitOn {
						if !running maxMovespeed = 2
						else maxMovespeed = 3
					}
					else maxMovespeed = 4
	
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
			
					if !suitOn sprite_index = s_kid_player

					//	I have movement input!
					if (hspd != 0 or vspd != 0) {
						moveDirection = point_direction(0,0,hspd,vspd)
						moveForce += 0.05
						moveForce = clamp(moveForce,0,maxMovespeed)
			
						//if moveForce == 2 moveForce = 0

						setForce(moveForce, moveDirection)
	
						if hspd != 0 image_xscale = sign(hspd) * xscale
			
						if jumpHaltDuration == -1 {
							image_speed = (moveForce/maxMovespeed)
							image_speed = clamp(image_speed,.2,1)
						}
	
						////	Footprints
						if onGround footprint()
						
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
	
	
					if !onGround and jumping > -1 {
						if input.keyJumping and jumping < 5 {
							setThrust(thrust + 0.5)	
						}
						jumping--
					}
					////	Jumping
					if input.keyJump and onGround {
						//var Thrust = clamp(5 * (moveForce/ maxMovespeed), min(3, maxMovespeed), 5)
						setThrust(3)
						image_speed = 1
						jumping = 10
					}

					if !onGround applyThrust()
				
					////	Determine sprite
					if onGround {
						//	Moving
						if (hspd != 0 or vspd != 0) {
							if suitOn {
								if jumpHaltDuration > 0 {
									sprite_index = s_diverman_jump
									if animation_end {
										jumpHaltDuration = -1	
									}
								} else {
									if running {
										sprite_index = s_diverman_sprint	
									}
									else
									if sprite_index != s_diverman_walk {
										sprite_index = s_diverman_walk
										//image_index = 0
									}
								}
							}
						}
						//	Not moving
						else {
							if suitOn {
								if moveForce == 0 and sprite_index != s_diverman_idle and jumpHaltDuration == -1 {
									sprite_index = s_diverman_idle
									//image_index = 0
								}	
							}
						}
					} 
					//	In the air
					else {
						if thrust > 0 {
							if suitOn {
								sprite_index = s_diverman_jump
								image_index = 0
							}
						}
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

		depth = -y

		if app.underwater bubbles(false)
	}
	else visible = false
}
else {
	image_speed = 0
}