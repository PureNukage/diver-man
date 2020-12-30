event_inherited()
drawShadow = false

height = (bbox_bottom - bbox_top)

//	Create collision the same size as our mask
var topY = y-sprite_get_yoffset(sprite_index)
heightMap = instance_create_layer(bbox_left,topY,"Instances",collisionMap)

var maskWidth = abs(bbox_right - bbox_left)
var maskHeight = abs(bbox_bottom - bbox_top)

var maskWidth = sprite_get_width(sprite_index)
var maskHeight = sprite_get_height(sprite_index)

var collisionWidth = abs(heightMap.bbox_right - heightMap.bbox_left)
var collisionHeight = abs(heightMap.bbox_bottom - heightMap.bbox_top)

var newXScale = maskWidth / collisionWidth
var newYScale = maskHeight / collisionHeight

heightMap.image_xscale = newXScale
heightMap.image_yscale = newYScale
heightMap.z = height
heightMap.width = abs((topY) - bbox_top)
heightMap.rock = id
heightMap.createSurface()

depth = player.depth - 1
heightMap.depth = player.depth - 1