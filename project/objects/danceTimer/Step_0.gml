if stage == 0 {
	if timer < 200 {
		timer++	
	}
	else {
		app.cameraFocus(0,230,"~",false)
		
		if audio_is_playing(sound_electroswing) audio_stop_sound(sound_electroswing)
		sound.playSoundEffect(sound_recordscratch)
		
		stage = 1
		create_textbox(id, myDialogue[1, dialogueIndex])
		
		//	Clear the crowd
		if !ds_list_empty(dancingCrowdManager.list) {
			for(var i=0;i<ds_list_size(dancingCrowdManager.list);i++) {
				instance_destroy(dancingCrowdManager.list[| i])
			}
			ds_list_clear(dancingCrowdManager.list)
		}
		playerDancing.on = false
	}
}
//	Wait for dialogue to finish
else if stage == 1 {
	if !instance_exists(textbox) and dialogueIndex == 1 {
		Layer = layer_create(-1)
	    Sequence = layer_sequence_create(Layer,0,0,Sequence4)
		stage = 2	
		player.muted = true
		brotherMusic.visible = false
	}
}
//	Wait for Sequence to finish
else if stage == 2 {
	app.cameraFocusX += 5
	if layer_sequence_is_finished(Sequence) {
		layer_sequence_destroy(Sequence)
		stage = 3
		create_textbox(id, myDialogue[1, dialogueIndex])
	}	
}
//	Wait for dialogue to finish
else if stage == 3 {
	brotherMusic.visible = true
	brotherMusic.image_xscale = -1
	if !instance_exists(textbox) and dialogueIndex == 8 {
		layer_sequence_destroy(Sequence)
		Sequence = layer_sequence_create(Layer,0,0,Sequence5)
		stage = 4
		instance_destroy(brotherMusic)
	}
}
//	Wait for sequence 5 to finish
else if stage == 4 {
	if layer_sequence_is_finished(Sequence) {
		//app.cameraFocusOnPlayer = true
		app.cameraFocus(player.x,player.y,1,true)
		player.muted = false
		app.zoom_level = 1
		instance_destroy()
	}
}

depth = player.depth