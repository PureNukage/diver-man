if duration > 0 duration--
else if temporary instance_destroy()

switch(particles) 
{
	case particles.bubble:
	
		sprite_index = s_bubble

		image_alpha = duration / durationMax

		y -= Speed
		
		depth = -y
	
	break
	case particles.footprint:
	
		sprite_index = s_footprint
		
		image_alpha = duration / durationMax
		
		if place_meeting(x,y,collisionMap) {
			visible = false	
		}
		
	break
	case particles.jellyfish:
		
		sprite_index = s_jellyfish
		
		if burstTimer == -1 burst()
		else burstTimer--

		image_angle = moveDirection

		depth = -20000
		
	break
}