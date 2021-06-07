if live_call() return live_result

////	Quest Journal
if instance_exists(player) and player.questJournalOpen {
	draw_set_color(c_gray)
	var X = 135
	var Y = 45
	var Width = 300
	var Height = 300
	draw_rectangle(X,Y,X+Width,Y+Height,false)
	
	draw_set_color(c_black)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(X+Width/2,Y+15,"Quests")
	
	//	Gather the width of the longest quest
	var nameWidth = 0
	var nameHeight = 0
	var border = 8
	for(var i=0;i<ds_list_size(questManager.questList);i++) {
		var Quest = questManager.questList[| i]
		var QuestName = questManager.questNames[Quest.index]
		nameWidth = string_width(QuestName) + border*2
		nameHeight = string_height(QuestName) + border*2
	}
	
	var XX = X + 20
	var YY = Y + 45
	var WWidth = 100
	var HHeight = 45
	for(var i=0;i<ds_list_size(questManager.questList);i++) {
		var Quest = questManager.questList[| i]
		var QuestName = questManager.questNames[Quest.index]
		
		draw_set_color(c_black)
		draw_roundrect(XX-2,YY-2,XX+nameWidth+2,YY+nameHeight+2,false)
		
		if point_in_rectangle(mouse_gui_x,mouse_gui_y,XX,YY,XX+nameWidth,YY+nameHeight) {
			draw_set_color(c_dkgray)
		}
		else {
			draw_set_color(c_ltgray)	
		}
		
		draw_roundrect(XX,YY,XX+nameWidth,YY+nameHeight,false)

		draw_set_color(c_black)		
		draw_text(XX+nameWidth/2,YY+nameHeight/2,QuestName)
	}
}

////	Inventory
if instance_exists(player) and player.inventoryOpen {
	draw_set_color(c_gray)
	var X = 16
	var Y = 120
	var Width = 280
	var Height = 200
	draw_rectangle(X,Y, X+Width, Y+Height, false)
	
	var heightSpacer = 64
	var XX = X + 10
	var YY = Y + heightSpacer
	var WWidth = 64
	var HHeight = 64
	var index = 0
	
	if input.keyboardOrController == 1 {
		if input.keyRightPress inventoryIndex++
		if input.keyLeftPress inventoryIndex--
		if input.keyUpPress inventoryIndex -= 4
		if input.keyDownPress inventoryIndex += 4
		inventoryIndex = clamp(inventoryIndex, 0, 7)
	}
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	for(var h=0;h<2;h++) {
		for(var w=0;w<4;w++) {
			
			var Item = ds_list_find_value(player.inventory, index)
			
			//	Mouseover
			draw_set_color(c_ltgray)
			if (input.keyboardOrController == 0 and point_in_rectangle(mouse_gui_x,mouse_gui_y, XX,YY,XX+WWidth,YY+HHeight))
			or (input.keyboardOrController == 1 and index == inventoryIndex) {
				draw_rectangle(XX,YY, XX+WWidth,YY+HHeight, false)
				
				if !is_undefined(Item) or Item > 0 {
					draw_set_color(c_black)
					draw_text(X+Width/2, Y+heightSpacer/2, Item.text)
				}
			}
			
			draw_set_color(c_black)
			draw_rectangle(XX,YY, XX+WWidth, YY+HHeight, true)
		
			if !is_undefined(Item) or Item > 0 {
				draw_sprite(Item.image,0,XX,YY)
			}
			
			index++
			XX += WWidth + 2
		}
		XX = X + 10
		YY += HHeight + 2
	}
}

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
			var Sprite = s_keyboard_e
			if input.keyboardOrController == 1 Sprite = s_controller_xbox_y
			draw_sprite_ext(Sprite,0,display_get_gui_width()/2,80,2,2,0,c_white,1)	
		}
	} else if instance_exists(walkAndTalk2) {
		if walkAndTalk2.stage > 0 draw = false
	}
	var _x = display_get_gui_width()/2
	var _y = 110
	if !(input.keyRight or input.gamepadAxisLH >= 0.5) and draw {
		var Sprite = s_keyboard_d
		if input.keyboardOrController == 1 Sprite = s_joystick_left_right
		draw_sprite_ext(Sprite,0,_x,_y,2,2,0,c_white,1)
	}
}