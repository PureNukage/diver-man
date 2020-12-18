if input.keyInteract {
	
	//	next index for ID
	var nextIndex = myDialogue[0, responseIndex]
	
	//	if nextIndex is negative
	if sign(real(nextIndex)) == -1 {
		ID.dialogueIndex = real(nextIndex) * -1
	}
	else {
	
		ID.dialogueIndex = nextIndex
	
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = ID
		Textbox.text = ID.myDialogue[1, ID.dialogueIndex]
	}
	
	instance_destroy()
	
}

if input.keyUp and responseCD == -1 {
	responseIndex--
	responseCD = 10
}
if input.keyDown and responseCD == -1 {
	responseIndex++
	responseCD = 10
}

if responseCD > -1 responseCD--

if responseIndex < 0 {
	responseIndex = array_length(myDialogue[1])-1	
}
else if responseIndex > array_length(myDialogue[1])-1 {
	responseIndex = 0	
}