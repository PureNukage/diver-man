if live_call() return live_result

if shop {
	
	var Width = 340
	var Height = 256
	var X = 64
	var Y = 32
	
	draw_set_color(c_gray)
	draw_rectangle(X,Y, X+Width,Y+Height, false)
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_set_color(c_black)
	draw_text(X+Width/2, Y+32/2, "Shop")
	
	if input.keyInteract {
		shop = false
		app.zoom_level = 1
		player.muted = false
		dialogueIndex = 0
		inConversation = false
	}
	
	for(var i=0;i<ds_list_size(shopList);i++) {
		var space = 8
		var XX = X + 32
		var YY = Y + 64 + (i*(64+space))
		var WWidth = 128
		var HHeight = 64
		var border = 2
		var String = shopList[| i].text
		var Image = shopList[| i].image
		var Desc = shopList[| i].description
		var hover = false
		
		draw_set_color(c_black)
		draw_roundrect(XX-border,YY-border, XX+WWidth+border, YY+HHeight+border, false)
		if (input.keyboardOrController == 0 and point_in_rectangle(mouse_gui_x,mouse_gui_y, XX,YY,XX+WWidth,YY+HHeight))
		or (input.keyboardOrController == 1 and shopIndex == i) {
			draw_set_color(c_dkgray)
			hover = true
		}
		else {
			draw_set_color(c_gray)	
		}
		draw_roundrect(XX,YY, XX+WWidth, YY+HHeight, false)
		
		if hover {
			var imageX = XX + ((Width) - (WWidth))
			draw_sprite(Image,0, imageX-32,Y + 64)
			
			draw_set_color(c_black)
			draw_set_valign(fa_top)
			draw_text_ext(imageX,Y+132,Desc, string_height(Desc), 164)
		}
	
		draw_set_color(c_white)
		draw_set_valign(fa_middle)
		draw_text(XX+WWidth/2,YY+HHeight/2, String)
	}
	
}