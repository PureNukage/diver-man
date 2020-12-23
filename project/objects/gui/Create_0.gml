interactable = false

drawGold = false

drawNewQuest = false
drawNewQuestTimer = -1
function draw_new_quest_popup(quest) {
	
	var duration = 360
	if drawNewQuestTimer < duration {
		drawNewQuestTimer++	
	}
	else {
		drawNewQuest = false
		drawNewQuestTimer = -1
	}
	////	First frame of new quest
	//if drawNewQuestTimer == -1 {
	//	drawNewQuestTimer = duration
	//}
	////	Drawing
	//else if drawNewQuestTimer > 0 {
	//	drawNewQuestTimer--
	//}
	////  Done drawing
	//else if drawNewQuestTimer == 0 {
	//	drawNewQuest = false
	//	drawNewQuestTimer = -1
	//}
	
	draw_set_font(font_newquest)
	
	var fade_in = true
	if drawNewQuestTimer > duration/2 fade_in = false
	
	var text = questManager.questNames[quest.index]
	
	var spacer = 6
	var width = string_width(text) + spacer
	var height = string_height(text) + spacer
	var xx = display_get_gui_width()/2 - width/2
	var yy = 16
	
	draw_set_color(c_black)
	if fade_in draw_set_alpha(0.5 * (drawNewQuestTimer/duration/2))
	else draw_set_alpha(0.5 * (1-(drawNewQuestTimer/duration)))
	draw_roundrect(xx-2,yy-2,xx+width+2,yy+height+2,false)
	
	if fade_in draw_set_alpha(1 * (drawNewQuestTimer/duration/2))
	else draw_set_alpha(1 * (1-(drawNewQuestTimer/duration)))
	draw_set_color(make_color_rgb(255,201,14))
	draw_roundrect(xx,yy,xx+width,yy+height,false)
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(xx+width/2,yy+height/2,text)
	
}