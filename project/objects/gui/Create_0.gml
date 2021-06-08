interactable = false

drawHealth = false
drawStamina = false
drawOxygen = false

drawGold = false

inventoryIndex = 0
questIndex = 0

drawNewQuest = false
drawNewQuestTimer = -1
drawNewQuestStage = -1
function draw_new_quest_popup(quest) {
	
	var duration = 120
	if drawNewQuestTimer < duration {
		drawNewQuestTimer++	
	}
	else {
		drawNewQuestStage++
		drawNewQuestTimer = -1
		if drawNewQuestStage >= 2 {
			drawNewQuest = false
			drawNewQuestStage = -1
			exit
		}
	}
	
	draw_set_font(font_newquest)
	
	var text = questManager.questNames[quest.index]
	var spacer = 6
	var width = string_width(text) + spacer
	var height = string_height(text) + spacer
	var xx = display_get_gui_width()/2 - width/2
	var yy = 16
	
	switch(drawNewQuestStage) {
		//	Fading in
		case -1:
			draw_set_color(c_black)
			draw_set_alpha(0.5 * (drawNewQuestTimer/duration))
			draw_roundrect(xx-2,yy-2,xx+width+2,yy+height+2,false)
			
			draw_set_color(make_color_rgb(255,201,14))
			draw_set_alpha(1 * (drawNewQuestTimer/duration))
			draw_roundrect(xx,yy,xx+width,yy+height,false)
		break
		//	Pause
		case 0:
			draw_set_color(c_black)
			draw_set_alpha(0.5)
			draw_roundrect(xx-2,yy-2,xx+width+2,yy+height+2,false)
			
			draw_set_color(make_color_rgb(255,201,14))
			draw_set_alpha(1)
			draw_roundrect(xx,yy,xx+width,yy+height,false)
		break
		//	Fading out
		case 1:
			draw_set_color(c_black)
			draw_set_alpha(0.5 * (1-(drawNewQuestTimer/duration)))
			draw_roundrect(xx-2,yy-2,xx+width+2,yy+height+2,false)
			
			draw_set_color(make_color_rgb(255,201,14))
			draw_set_alpha(1 * (1-(drawNewQuestTimer/duration)))
			draw_roundrect(xx,yy,xx+width,yy+height,false)
		break
	}
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_outlined(xx+width/2,yy+height/2,text,c_white,c_black)
	
}
	
function toggle(true_or_false) {
	if true_or_false {
		drawHealth = true
		drawStamina = true
		drawGold = true
	}
	else {
		drawHealth = false
		drawStamina = false
		drawGold = false
	}
}