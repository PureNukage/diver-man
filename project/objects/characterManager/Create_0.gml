characterList = ds_list_create()

function add_character(character_index) {
	var Character = new _create_character(character_index)
	ds_list_add(characterList, Character)
}

function _create_character(character_index) constructor {
	switch(character_index) {
		#region Brother
			case characters.brother:
				gotSandwich = false
				givenNothing = false
			break	
		#endregion
	}
}