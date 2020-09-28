if duration > 0 duration--
else instance_destroy()

switch(particles) 
{
	case particles.bubble:
	
		sprite_index = s_bubble

		image_alpha = duration / durationMax

		y -= Speed
	
	break
	case particles.footprint:
	
		sprite_index = s_footprint
		
		image_alpha = duration / durationMax
		
		if place_meeting(x,y,collisionMap) {
			visible = false	
		}
		
	break
}