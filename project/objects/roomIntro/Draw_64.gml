draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(font_intro)
var xx = display_get_gui_width()/2
var yy = display_get_gui_height()/2 - 100

//	Draw black box
draw_set_color(c_black)
draw_set_alpha(backgroundFadeOut/100)
draw_rectangle(-100,0,display_get_width(),display_get_height(),false)

draw_set_color(c_white)
//	Text fading in
if timer < 600 {
	if timer > 180 {
		if text1FadeIn < 100 text1FadeIn++
		draw_set_alpha(text1FadeIn/100)
		draw_text(xx,yy,text1)
	}

	if timer > 360 {
		if text2FadeIn < 100 text2FadeIn++
		draw_set_alpha(text2FadeIn/100)
		draw_text(xx,yy + 90, text2)
	}
}
//	Text fading out
else {
	
	//	Fade out text1 first
	if text1FadeIn > 0 text1FadeIn--	
	draw_set_alpha(text1FadeIn/100)
	draw_text(xx,yy,text1)
	
	//	Fade out text2 once text1 is done
	if text1FadeIn <= 0 {
		if text2FadeIn > 0 text2FadeIn--
	}
	draw_set_alpha(text2FadeIn/100)
	draw_text(xx,yy + 90, text2)
	
	//	If all text is gone
	if text2FadeIn <= 0 {
		
		//	Generate background layer image
		if !createdBackground {
			var surface = surface_create(720,768)
			surface_set_target(surface)
			draw_clear_alpha(c_black, 0)
			
			//draw_tilemap(layer_tilemap_get_id(layer_get_id("Tiles_1")), 0,0)
			//draw_tilemap(layer_tilemap_get_id(layer_get_id("Tiles_2")), 0,0)
			draw_tilemap(layer_tilemap_get_id(layer_get_id("Tiles_3")), 0,0)
			
			surface_reset_target()
			
			var sprite = sprite_create_from_surface(surface,0,0,720,768,false,true,0,0)
			
			layer_background_sprite(layer_background_get_id(layer_get_id("Background")), sprite)
			
			var Object = instance_create_layer(0,0,"Instances",roomIntroSurface)
			Object.surfaceBuffer = buffer_create(720*768*4,buffer_grow,1)
			buffer_get_surface(Object.surfaceBuffer,surface,0)
			surface_free(surface)
			
			createdBackground = true
		}
		
		//	City background
		if brotherFadeIn >= 100 {
			if backgroundFadeOut > 0 backgroundFadeOut--
			
			if backgroundFadeOut <= 0 {
				if file_exists("save.ini") {
					file_delete("save.ini")	
				}
				room_goto(RoomCity)
				app.cameraRefresh = true
				app.canvasX = layer_get_x("Background")
				destroy = true
			}
		}
		
		var adjustY = 132
		
		//	Start fading in the city scene
		if playerFadeIn < 100 playerFadeIn++
		draw_sprite_ext(s_kid_player_walk,playerShadow.image_index, xx,yy+adjustY, 1,1,0, image_blend,playerFadeIn/100)
		
		if playerFadeIn >= 100 {
			if brotherFadeIn < 100 brotherFadeIn++
			draw_sprite_ext(s_brother_walk,playerShadow.image_index, xx+96,yy+adjustY, 1,1,0, image_blend,brotherFadeIn/100)

		}
		
	}
}

draw_reset()