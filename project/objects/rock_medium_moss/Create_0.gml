mask_index = s_rock_medium_moss_collision

event_inherited()

damagedTimer = -1
smashed = false
image_speed = 0 
image_index = 0
instance_destroy(heightMap)
depth = -(y - sprite_get_yoffset(sprite_index))

//	Create non-passable collision
var offset = 16
var topY = y-(sprite_get_yoffset(sprite_index)*image_yscale) + offset
heightMap = instance_create_layer(bbox_left,topY,"Instances",collision)

var maskWidth = abs(bbox_right - bbox_left)
var maskHeight = abs(bbox_bottom - bbox_top)

var maskWidth = sprite_get_width(sprite_index) * image_xscale
var maskHeight = (sprite_get_height(sprite_index) * image_yscale) - offset

var collisionWidth = abs(heightMap.bbox_right - heightMap.bbox_left)
var collisionHeight = abs(heightMap.bbox_bottom - heightMap.bbox_top)

var newXScale = maskWidth / collisionWidth
var newYScale = maskHeight / collisionHeight

heightMap.image_xscale = newXScale
heightMap.image_yscale = newYScale