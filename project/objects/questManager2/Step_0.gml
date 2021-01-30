////	Crab watch battle
//	Wait for player to get close enough to the watch
if instance_exists(player) {
	if stage == 0 {
		if player.x > 1983 and player.y < 1376
		and player.x < 2272 and player.groundY > 1055 {
			Layer = layer_create(-2000)
			Sequence = layer_sequence_create(Layer,1967,1056,Sequence8)
			player.canMove = false
			instance_destroy(watch)
			app.cameraFocus(2159,1183,"~",true)
			stage = 1
		}
	}
	//	Wait for crab sequence to finish then spawn in the real crab
	else if stage == 1 {
		player.canMove = false
		if layer_sequence_is_finished(Sequence) {
			stage = 2
			layer_sequence_destroy(Sequence)
			instance_create_layer(1967+271,1056+144,"Instances",crab)
			app.cameraFocus(player.x,player.y,1,true)
			player.canMove = true
		}
	}
	//	wait for player to pickup the watch after winning the crab battle
	else if stage == 2 {
		if instance_exists(watch) and watch.pickedUp {
			stage = 3
			instance_destroy(watch)
			player.create_item(item.watch)
		}
	}
	//	player just can leave now
	else if stage == 3 {
		
	}
}