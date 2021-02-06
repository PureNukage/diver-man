//////	Interactable
//if interactable {
//	var xx = display_get_gui_width()/2
//	var yy = display_get_gui_height()/2
//	yy -= 100
	
//	draw_set_color(c_white)
//	draw_set_halign(fa_center)
//	draw_set_valign(fa_middle)
//	draw_text(xx,yy,"Press E to interact")
//}

////	Health and stamina bars
if instance_exists(player) {
	
	////	Health bar
	if drawHealth and app.roomTransitionTo == -1 { 
		var XX = 6
		var YY = 6
		//	Back
		draw_sprite_ext(s_bar_back,0,XX,YY,1,1,0,c_black,1)
		//	Front
		var spriteWidth = sprite_get_width(s_bar_front)
		var ratio = player.hp / player.hpMax
		var barWidth = spriteWidth * ratio
		draw_sprite_part_ext(s_bar_front,0,0,0,barWidth,sprite_get_height(s_bar_front),XX,YY,1,1,make_color_rgb(146,0,0),1)
		draw_sprite(s_logo_health,0,XX,YY)
	}
	
	////	Stamina bar
	if drawStamina and app.roomTransitionTo == -1 {
		var XX = 6
		var YY = 6 + sprite_get_height(s_bar_back) + 6
		//	Back
		draw_sprite_ext(s_bar_back,0,XX,YY,1,1,0,c_black,1)
		//	Front
		var spriteWidth = sprite_get_width(s_bar_front)
		var ratio = player.stamina / player.staminaMax
		var barWidth = spriteWidth * ratio
		draw_sprite_part_ext(s_bar_front,0,0,0,barWidth,sprite_get_height(s_bar_front),XX,YY,1,1,make_color_rgb(60,114,59),1)
		draw_sprite(s_logo_stamina,0,XX,YY)
	}
	
	////	o2 bar
	if drawOxygen and app.roomTransitionTo == -1 {
		var XX = 6
		var YY = 6 + (sprite_get_height(s_bar_back)*2) + 12
		//	Back
		draw_sprite_ext(s_bar_back,0,XX,YY,1,1,0,c_black,1)
		//	Front
		var spriteWidth = sprite_get_width(s_bar_front)
		var ratio = player.oxygen / player.oxygenMax
		var barWidth = spriteWidth * ratio
		draw_sprite_part_ext(s_bar_front,0,0,0,barWidth,sprite_get_height(s_bar_front),XX,YY,1,1,make_color_rgb(0,139,185),1)
		draw_sprite(s_logo_oxygen,0,XX,YY)
	}
	
	
	////	Gold
	if drawGold and app.roomTransitionTo == -1 {		
		var xx = 515
		var yy = 35
	
		draw_sprite(s_coins,0,xx,yy)
	
		var xx = 515
		var yy = 55
	
		draw_set_color(c_yellow)
		draw_set_font(font_coins)
		draw_set_halign(fa_center)
		draw_set_valign(fa_top)
		draw_text(xx,yy, string(player.gold))
	}
	
	draw_reset()
	
}
	
////	New Quest
if drawNewQuest {
	if questManager.questCount > 0 {
		var Quest = questManager.questList[| questManager.questCount-1]	
		draw_new_quest_popup(Quest)	
	}
	draw_reset()
}
	
////	Walk and Talk D ->
if instance_exists(walkAndTalk) or instance_exists(walkAndTalk2) {
	var draw = true
	if instance_exists(walkAndTalk) {
		if walkAndTalk.stage == 1 draw = false
		
		if walkAndTalk.dialogueIndex == 0 and instance_exists(textbox) {
			draw_sprite_ext(s_keyboard_e,0,display_get_gui_width()/2,80,2,2,0,c_white,1)	
		}
	} else if instance_exists(walkAndTalk2) {
		if walkAndTalk2.stage > 0 draw = false
	}
	var _x = display_get_gui_width()/2
	var _y = 110
	if !input.keyRight and draw {
		draw_sprite_ext(s_keyboard_d,0,_x,_y,2,2,0,c_white,1)
	}
}