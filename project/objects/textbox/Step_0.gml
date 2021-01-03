if input.keyInteract and interactCD == -1 {
	
	if textIndex < string_length(text) {
		textIndex = string_length(text)	
	}
	else {
	
		if ID.dialogueIndex < array_length(ID.myDialogue[0]) {
			//	The next index is to respond
			if string_count("resp", ID.myDialogue[0, ID.dialogueIndex]) > 0 {
				var Response = instance_create_layer(0,0,"Instances",response)
				Response.ID = ID
				Response.npcKey = ID.myDialogue[0, ID.dialogueIndex]
				with Response {
					load_dialogue()
					condition_check_dialogue(id)	
				}
			}
			//	A string of dialogue
			else {
	
				//	Flip the conversation targets dialogueIndex
				ID.dialogueIndex = ID.myDialogue[0, ID.dialogueIndex]
			
				//	Condition check this dialogue
				condition_check_dialogue(ID)
	
				//	If index is positive, make the new textbox
				if sign(real(ID.dialogueIndex)) > 0 {
					//debug.log("POSITIVE")
					create_textbox(ID, ID.myDialogue[1, ID.dialogueIndex])
				}
				else {
					//debug.log("NEGATIVE")
					ID.dialogueIndex = real(ID.dialogueIndex) * -1
					ID.inConversation = false
					ID.interactCD = 5
				}
			}
		}
	
		instance_destroy()	
	}
}
	
if interactCD > -1 interactCD--

textIndex++

//	Dialogue sound effects
if textIndex < string_length(text) {	//	Only play if they're talking
	var Sprite = ID.myDialogue[2, ID.dialogueIndex]
	var Sound = -1
	switch(Sprite) {
		case s_brother_face:
			Sound = choose(Brother_1_1_7, Brother_2_1_7, Brother_3_1_7, Brother_4_1_7, Brother_5_1_7, Brother_6_1_7)
		break
		//	case s_sailorpete_face:
		
		//	break
	}
	//	Fire off a sound effect
	if string_char_at(text,textIndex) == " " or textIndex == string_length(text)-1 {
		soundEffect = Sound
		sound.playSoundEffect(soundEffect)
	
	//if soundEffect == -1 {
		//soundEffect = Sound
		//sound.playSoundEffect(soundEffect)
	}
	//	Check if audio is not playing, if not lets reset
	//else if !audio_is_playing(soundEffect) soundEffect = -1
}