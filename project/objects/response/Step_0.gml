if input.keyInteract {
	
	//	next index for ID
	var nextIndex = responses[0, responseIndex]
	
	//	if nextIndex is negative
	if sign(real(nextIndex)) < 1 {
		ID.dialogueIndex = real(nextIndex) * -1
		ID.inConversation = false
		ID.interactCD = 5
	}
	else {
	
		ID.dialogueIndex = nextIndex
		
		create_textbox(ID, ID.myDialogue[1, ID.dialogueIndex])
	}
	
	condition_check_response(id)
	
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
	responseIndex = array_length(responses[1])-1	
}
else if responseIndex > array_length(responses[1])-1 {
	responseIndex = 0	
}