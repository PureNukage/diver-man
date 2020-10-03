event_inherited()

staminaMax = 100
stamina = staminaMax
gold = 0

suitOn = app.suitOn

muted = false

mask_index = s_diverman_collision

function draw_shade() {
	var bbox_width = abs(bbox_right-bbox_left)
	var bbox_height = abs(bbox_bottom-bbox_top)
	var surface = surface_create(bbox_width, bbox_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	surface_reset_target()
	
	surface_copy_part(surface,0,0,shadows.surface, bbox_left+z,bbox_top, bbox_width,bbox_height)

	//	Draw the surface stretched on top of the sprite_index
	var surface2 = surface_create(room_width,room_height)
	surface_set_target(surface2)
	draw_clear_alpha(c_black, 0)
	
	var xOffset = sprite_get_xoffset(sprite_index)
	var yOffset = sprite_get_yoffset(sprite_index)
	var spriteWidth = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)
	var spriteHeight = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)
	var ratioWidth = spriteWidth / bbox_width
	var ratioHeight = spriteHeight / bbox_height
	var XX = x - xOffset + sprite_get_bbox_left(sprite_index)
	var YY = y - yOffset + sprite_get_bbox_top(sprite_index) - z
	draw_surface_ext(surface, XX,YY, ratioWidth,ratioHeight, 0, c_white, 1)
	
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
	draw_sprite_ext(sprite_index,image_index,xOffset-sprite_get_bbox_left(sprite_index),yOffset-sprite_get_bbox_top(sprite_index),image_xscale,image_yscale,image_angle,c_white,1)
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
	
	//draw_surface_ext(surface, XX + 64,YY, 1,1, 0, c_white, 1)
	//draw_surface_ext(surface2, XX + 128 - abs(x),YY - y + abs(spriteHeight), 1,1, 0, c_white, 1)
	//draw_surface_ext(surface3, XX + 192,YY, 1,1, 0, c_white, 1)
	//draw_surface_ext(surfaceFinal, XX + 256,YY, 1,1, 0, c_white, 1)
	
	draw_surface_ext(surfaceFinal,XX,YY,1,1,0,c_white, 0.5)
	
	surface_free(surface)
	surface_free(surface2)
	surface_free(surface3)
	surface_free(surfaceFinal)
	surface_free(surface4)
}