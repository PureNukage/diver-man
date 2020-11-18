////	Draw the responses
var responseCount = array_length(myDialogue[0])
draw_set_font(font_response)

var widthSpacer = 30
var heightSpacer = 40

//	Gather data about responses first
var width = 0
var height = 0
var xx = display_get_gui_width()/2
var yy = display_get_gui_height()/2
for(var i=0;i<responseCount;i++) {
	String = myDialogue[1, i]
	var Width = string_width(myDialogue[1, i]) + widthSpacer
	var Height = string_height(myDialogue[1, i]) + heightSpacer
	//	Gather the max width and height
	if Width > width {//and Height > height {
		width = Width
		height = Height
	}
	//	Is our mouse over this one?
	if point_in_rectangle(mouse_gui_x,mouse_gui_y, xx,yy, xx+width,yy+height) {
		if responseIndex != i responseIndex = i	
	}
	yy += height + 10
}

var xx = display_get_gui_width()/2 - width/2
var yy = display_get_gui_height()/2
for(var i=0;i<responseCount;i++) {
	draw_set_color(c_black)
	draw_rectangle(xx-2,yy-2, xx+width+2,yy+height+2, false)
	
	if responseIndex == i {
		draw_set_color(c_gray)
	}
	else {
		draw_set_color(c_dkgray)
	}
	draw_rectangle(xx,yy, xx+width,yy+height, false)
	
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(xx+width/2,yy+height/2,myDialogue[1, i])
	
	yy += height + 10
}