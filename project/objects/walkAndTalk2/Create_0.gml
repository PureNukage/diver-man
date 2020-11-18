Direction = right
stage = 0

destroy = false

createdBackground = false

//	Generate background layer image
if !createdBackground {
	var surface = surface_create(720,768)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
			
	draw_tilemap(layer_tilemap_get_id(layer_get_id("Tiles_1")), 0,0)
			
	surface_reset_target()
			
	var sprite = sprite_create_from_surface(surface,0,0,720,768,false,true,0,0)
			
	layer_background_sprite(layer_background_get_id(layer_get_id("Background")), sprite)
			
	surface_free(surface)
			
	createdBackground = true
}

if instance_exists(player) player.muted = true

gapMax = 96
gap = 0

inConversation = false
timer = 0
npcKey = "musicMorning1"
dialogueIndex = -1

load_dialogue()