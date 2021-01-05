mask_index = s_rock_medium_moss_collision

event_inherited()

damagedTimer = -1
smashed = false
image_speed = 0 
image_index = 0
depth = -(y - sprite_get_yoffset(sprite_index))
heightMap.depth = depth
heightMap.createSurface()