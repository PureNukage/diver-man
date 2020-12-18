////	Draw the responses
var responseCount = array_length(myDialogue[1])
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
	
	var slice_index = s_parchment_dark_9slice
	if responseIndex == i slice_index = s_parchment_9slice
	draw_nine_tile(slice_index, width, height, xx,yy, myDialogue[1, i])
	
	yy += height + 10
}