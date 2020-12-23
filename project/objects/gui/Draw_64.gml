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
	
	//var XX = 6
	//var YY = 6
	//var Width = 200
	//var Height = 30
	
	//var healthWidth = (player.hp / player.hpMax) * Width
	
	//draw_set_color(c_black)
	//draw_roundrect(XX-2,YY-2,XX+Width+2,YY+Height+2,false)
	
	//draw_set_color(make_color_rgb(146,0,0))
	//draw_roundrect(XX,YY,XX+healthWidth,YY+Height,false)
	
	
	
	
	//var XX = 6
	//var YY = 6 + Height + 6
	
	//var staminaWidth = (player.stamina / player.staminaMax) * Width
	
	//draw_set_color(c_black)
	//draw_roundrect(XX-2,YY-2,XX+Width+2,YY+Height+2,false)
	
	//draw_set_color(make_color_rgb(60,114,59))
	//draw_roundrect(XX,YY,XX+staminaWidth,YY+Height,false)
	
	
	
	////	Gold
	if drawGold {
		var xx = 500
		var yy = 32
	
		draw_sprite(s_coins,0,xx,yy)
	
		var xx = 571
		var yy = 28
	
		draw_set_color(c_yellow)
		draw_set_font(font_coins)
		draw_set_halign(fa_left)
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
}