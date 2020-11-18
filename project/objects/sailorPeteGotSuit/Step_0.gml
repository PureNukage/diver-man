event_inherited()

if stage == 0 {
	timer++
	if timer >= 90 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
		stage = 1
	}
}