function approach(a, b, amount) {
	if (a < b) {
		a += amount
		if (a > b)
		return b
	} else {
		a -= amount
		if (a < b)
		return b
	}
	return a 	
}

function wave(from, to, duration, offset) {
	var a4 = (to - from) * 0.5
	return from + a4 + sin((((current_time * 0.0001) + duration * offset) / duration) * (pi*2)) * a4	
}

function wrap(value, Min, Max) {
	var _val = value
	var _max = Min
	var _min = Max

	if(_val mod 1 == 0) {
		while(_val > _max || _val < _min) {
			if(_val > _max) {
				_val = _min + _val - _max - 1	
			} else if (_val < _min) {
				_val = _max + _val - _min + 1
			} else _val = _val 
		}
		return _val
	} else {
		var _old = value + 1
		while (_val != _old) {
			_old = _val
			if(_val<_min) {
				_val = _max - (_min - _val)	
			} else if (_val > _max) {
				_val = _min + (_val - _max)
			} else _val = _val
		}
		return _val
	}	
}
	
function draw_text_outlined(x, y, String, text_color, outline_color) {
	var xx = x;
	var yy = y;
	var s = String;
	var c1 = text_color;
	var c2 = outline_color;

	draw_set_color(c2);
	draw_text(xx+1, yy+1, s);
	draw_text(xx-1, yy+1, s);
	draw_text(xx+1, yy-1, s);
	draw_text(xx-1, yy-1, s);

	draw_set_color(c1);
	draw_text(xx, yy, s);
}
	
function draw_reset() {
	
	draw_set_color(c_black)
	draw_set_alpha(1)
	draw_set_font(-1)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
}
	
function createParticle(X, Y, Enum, Duration, Speed) {
	var Particle = instance_create_layer(X,Y,"Instances",particle)
	Particle.Speed = Speed
	Particle.duration = Duration
	Particle.durationMax = Particle.duration
	Particle.particles = Enum
	
	return Particle
}
	
function pathfind(mp_grid, Path, xStart, yStart, xGoal, yGoal, allowdiag) {
	
	if mp_grid_path(mp_grid, Path, xStart, yStart, xGoal, yGoal, allowdiag) {
		return true
	}
	
	else {
		debug.log("Can't pathfind to the desired goal")	
		return false
	}
	
}
	
function instance_place_highest(x, y, object) {
	var instance = noone;
	var list = ds_list_create();
	var num = instance_place_list(x, y, object, list, false);
	
	//	Conditions
	//	Sort maps into a list in descending z+height order
	//	Move down the list and collision check them
	
	for(var i = 0; i < num; i++){
	if (instance == noone || (list[| i].z+list[| i].height > instance.z+instance.height))
	    instance = list[| i];
	}
	
	//	Filter down to a map that we're actually colliding with
	//var Y = self.y
	//if ds_list_size(list) > 1 and list[| 1].z == instance.z {
	//	for(var i=0;i<num;i++) {
	//		if Y > (list[| i].bbox_bottom - list[| i].width) and list[| i].z == instance.z
	//		instance = list[| i]
	//	}
	//}
  
	ds_list_destroy(list);

	return instance;
}
	
function instance_place_count(x, y, object) {
	var list = ds_list_create()
	var count = instance_place_list(x,y,object,list,true)
	ds_list_destroy(list)
	return count
}
	
function maps_collision_count(x,y) {
	
	var list = ds_list_create()
	var count = instance_place_list(x,y, collisionMap, list, true)
	
	var collisionCount = 0
	for(var i=0;i<count;i++) {
		var Map = list[| i]
		if y > Map.bbox_bottom - Map.width {
			collisionCount++
		}
	}
	
	ds_list_destroy(list)
	
	return collisionCount
	
}
	
function draw_path_sprite(path, sprite, subimg) {
	///@func draw_path_sprite(path,sprite,subimg)
	///@desc Draws a path with a sprite (smoothly, not absolute)
	///@auth Lord von Adel
	///@arg path
	///@arg sprite
	///@arg index
	var _path = path;
	var _sprite = sprite;
	var _subimg = subimg;

	var sW = sprite_get_width(_sprite);
	var sH = sprite_get_height(_sprite);
	var _col = draw_get_color();
	draw_set_color(c_white);

	for (var i=0; i<path_get_length(_path)/sprite_get_height(_sprite); i++) {
		var x1, y1, x2, y2, x0, y0, dir, m;
	
		x1 = path_get_x(_path,i/(path_get_length(_path)/sprite_get_width(_sprite)));
		y1 = path_get_y(_path,i/(path_get_length(_path)/sprite_get_width(_sprite)));
		x2 = path_get_x(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
		y2 = path_get_y(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
	
		if(i > 0) {
			x0 = path_get_x(_path,(i-1)/(path_get_length(_path)/sprite_get_width(_sprite)));
			y0 = path_get_y(_path,(i-1)/(path_get_length(_path)/sprite_get_width(_sprite)));
		} else {
			x0 = path_get_x(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
			y0 = path_get_y(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
		}
	
		m = 1;
		if(i > path_get_length(_path)/sH - 1) { m = (path_get_length(_path)/sH) - floor(path_get_length(_path)/sH); }
	
		dir = point_direction(x0,y0,x1,y1);
		if(i == 0) { dir += 180; }
		draw_primitive_begin_texture(pr_trianglestrip,sprite_get_texture(_sprite,_subimg));
		draw_vertex_texture(x1+lengthdir_x(sW/2,dir+90),y1+lengthdir_y(sW/2,dir+90),0,0);
		draw_vertex_texture(x1+lengthdir_x(-sW/2,dir+90),y1+lengthdir_y(-sW/2,dir+90),1,0);
	
		dir = point_direction(x1,y1,x2,y2);
		draw_vertex_texture(x2+lengthdir_x(sW/2,dir+90),y2+lengthdir_y(sW/2,dir+90),0,m);
		draw_vertex_texture(x2+lengthdir_x(-sW/2,dir+90),y2+lengthdir_y(-sW/2,dir+90),1,m);
		draw_primitive_end();
	};

	draw_set_color(_col);	
}
	
function drawLineSprite(sprite, x1,y1, x2,y2, width, color, alpha) {
    var _pixel = sprite,
    _x1=x1+1,
    _y1=y1+1,
    _x2=x2+1,
    _y2=y2+1,
    _width=argument_count > 5 ? width : 1,
    _color=argument_count > 6 ? color : draw_get_color(),
    _alpha=argument_count > 7 ? alpha : draw_get_alpha(),
    _dir = point_direction(_x1, _y1, _x2, _y2),
    _len = point_distance(_x1, _y1, _x2, _y2);

    draw_sprite_ext(_pixel, 0, 
                _x1+lengthdir_x(_width/2,_dir+90), 
                _y1+lengthdir_y(_width/2,_dir+90), 
                _len, _width, _dir, _color, _alpha);
}
	
function load_dialogue() {
	
	var csv = "dialogue.csv"
	var key = npcKey
	
	var dialogue = load_csv(csv)
	
	myDialogue = [[]]
	
	var height = ds_grid_height(dialogue)
	
	var foundDialogue = false
	var DialogueIndex = 0
	for(var i=0;i<height;i++) {
		var Key = dialogue[# 0, i]
		var nextIndex = dialogue[# 1, i]
		var Dialogue = dialogue[# 2, i]
		var Sprite = dialogue[# 3, i]
		
		var SpriteIndex = asset_get_index(Sprite)
		
		if string_count(key,Key) > 0 {
			myDialogue[0, DialogueIndex] = nextIndex
			
			////	Error checking the variable dialogue (the variable is replaced in Textbox::Begin Step)
			if string_count("%",Dialogue) >= 2 {
				for(var a=0;a<string_length(Dialogue);a++) {
					//	A variable
					if string_char_at(Dialogue,a) == "%" {
						var endIndex = -1
						//	Find the other percentage
						for(var s=a;s<string_length(Dialogue);s++) {
							//	Found it
							if s != a and string_char_at(Dialogue,s) == "%" {
								endIndex = s
								s = 500
							}
						}
						if endIndex > -1 { 
							//	Found it, lets find our variable
							var substring = string_copy(Dialogue,a, endIndex+1-a)
							//var variableString = substring
							while string_count("%",substring) > 0 {
								substring = string_delete(substring,string_pos("%",substring),1)	
							}
						
							//	Substring only has variable now, separate into object and variable using the period
							var periodIndex = string_pos(".",substring)
							var Object = asset_get_index(string_copy(substring,0,periodIndex-1))
							var Variable = string_copy(substring,periodIndex+1,string_length(substring)+1-periodIndex)
						
							//	Check if object exists
							if instance_exists(Object) and variable_instance_exists(Object,Variable) {
								//	Replace the variable in the dialogue with a string of the actual variable
								//var newString = string(variable_instance_get(Object,Variable))
								//var variableIndex = string_pos(variableString,Dialogue)
								//Dialogue = string_replace(Dialogue,variableString,newString)
								//var Break = 0
							}
							else {
								debug.log("ERROR with dialogue. KEY: "+string(Key)+" at: "+string(a))	
							}
							
						}
					}
				}
			}
			
			myDialogue[1, DialogueIndex] = Dialogue
			
			if SpriteIndex > -1 {
				npcSprite = SpriteIndex	
				myDialogue[2, DialogueIndex] = SpriteIndex
			}
			else myDialogue[2, DialogueIndex] = s_brother_face
			
			foundDialogue = true
			DialogueIndex++
		}
	}
	if foundDialogue {
		dialogueIndex = 0	
	}
	else dialogueIndex = -1
	
	ds_grid_destroy(dialogue)
	
}
	
function condition_check_dialogue(ID) {
	var key = ID.npcKey
	var index = real(ID.dialogueIndex)
	
	////	Condition checking response dialogue
	if ID.object_index == response {
		var keepArray = []
		//	Loop through the responses dialogue
		for(var i=0;i<array_length(ID.myDialogue[1]);i++) {
			var keep = true
			switch(key) {
				case "respBrotherCoin":
					//	Find quest LWO
					var quest = questManager.find_quest(quests.spendFinalCoin)
					
					switch(i) {
						//	Decided to keep it
						case 0:
							if !quest.keptCoin keep = false
						break
						//	Played street craps and made some money!
						case 1:
							if !quest.gambled or (quest.profited or quest.lostItAll) keep = false	
						break
						//	Here's a sandwich
						case 2:
							if !quest.boughtSandwich or player.item_check(item.sandwich) == -1 keep = false
						break
						//	Listened to Sailor Pete
						case 3:
							if !quest.listenedToPete keep = false
						break
						//	...and I lost it all
						case 4:
							if !quest.lostItAll keep = false
						break
						//	Gambled and profited
						case 5:
							if !quest.profited keep = false
						break
						//	That's it
						case 6:
							if !quest._listenedToPete and !quest._boughtSandwich and !quest._gambled keep = false
						break
					}
				break
			}
			keepArray[i] = keep
		}
		//	Loop through again and make a new myDialogue with only what we're keeping
		var _myDialogue = [[]]
		var _dialogueIndex = 0
		for(var i=0;i<array_length(ID.myDialogue[1]);i++) {
			if keepArray[i] {
				//_myDialogue[_dialogueIndex, 0] = ID.myDialogue[i, 0]
				//_myDialogue[_dialogueIndex, 1] = ID.myDialogue[i, 1]
				//_myDialogue[_dialogueIndex, 2] = ID.myDialogue[i, 2]
				_myDialogue[0, _dialogueIndex] = ID.myDialogue[0, i]
				_myDialogue[1, _dialogueIndex] = ID.myDialogue[1, i]
				_myDialogue[2, _dialogueIndex] = ID.myDialogue[2, i]
				_dialogueIndex++
			}
		}
		ID.responses = _myDialogue
		ID.responseCount = array_length(responses[0])
	}
	////	Condition checking a textbox
	else {
	
		switch(key) {
			case "dicekid":
				switch(index) {
					//	Make sure the player has at least one coin
					case 1:
					case 5:
					case 9:
						//	Player does not have one coin
						if player.gold < 1 {
							ID.dialogueIndex = 13
							debug.log("Player does not have enough money to gamble")
						}
					break
				}
			break
			case "sailorPeteFinalCoin":
				switch(index) {
					case 3:
						//	Player does not have one coin
						if player.gold < 1 {
							ID.dialogueIndex = 17
							debug.log("Player does not have enough money to hear Petes tale")
						}
					break
				}
			break
			case "vendorFinalCoin":
				switch(index) {
					case 2:
						//	Player does not have one coin
						if player.gold < 1 {
							ID.dialogueIndex = 6
							debug.log("Player does not have enough money to buy a sandwich")
						}
					break
				}
			break
		}
	}
}
	
function condition_check_response(ID) {
	var key = ID.npcKey
	var oldIndex = ID.responseIndex
	
	//	Find this response in the myDialogue db
	var index = -1
	for(var i=0;i<array_length(ID.myDialogue[1]);i++) {
		var Text = ID.myDialogue[1, i]
		if Text == ID.responses[1, oldIndex] {
			index = i
			i = 500
		}
	}
	
	switch(key) {
		case "respBrotherCoin":
			//	Find quest LWO
			var quest = questManager.find_quest(quests.spendFinalCoin)
			switch(index) {
				//	Gambled
				case 1:
					quest._gambled = true
				break
				//	Sandwich
				case 2:
					quest._boughtSandwich = true
					player.remove_item(player.item_check(item.sandwich))
				break
				//	Pete
				case 3:
					quest._listenedToPete = true
				break
				//	That's it
				case 6:
					//	End this dialogue
					brotherFinalCoin.dialogueIndex = 11
					instance_destroy()
				break
			}
		break
	}
}
	
function draw_nine_tile(slice_index, width, height, xx, yy, _string) {
	//draw_set_font(font_dialogue)
	var pixels = 42
	var tilesWidth = ceil(width / pixels)
	var tilesHeight = ceil(height / pixels)
	var XX = xx
	var YY = yy
	//debug.log(string(tilesWidth))
	//debug.log(string(tilesHeight))
	for(var w=0;w<tilesWidth;w++) {
		for(var h=0;h<tilesHeight;h++) {
			//	Top left corner
			if w == 0 and h == 0 {
				draw_sprite_part(slice_index,0, 0,0,pixels,pixels, XX,YY)
			}
			//	Top piece
			else if w > 0 and w < tilesWidth-1 and h == 0 {
				draw_sprite_part(slice_index,0, pixels,0, pixels,pixels, XX,YY)
			}
			//	Top right corner
			else if w == tilesWidth-1 and h == 0 {
				draw_sprite_part(slice_index,0, pixels*2+2,0, pixels,pixels, XX,YY)	
			}
			//	Left side piece
			else if w == 0 and h > 0 and h < tilesHeight-1 {
				draw_sprite_part(slice_index,0, 0,pixels, pixels,pixels, XX,YY)	
			}
			//	Bottom left corner
			else if w == 0 and h == tilesHeight-1 {
				draw_sprite_part(slice_index,0, 0,pixels*2+2, pixels,pixels, XX,YY)		
			}
			//	Bottom piece
			else if w > 0 and w < tilesWidth-1 and h == tilesHeight-1 {
				draw_sprite_part(slice_index,0, pixels,pixels*2+2, pixels,pixels, XX,YY)		
			}
			//	Bottom right corner
			else if w == tilesWidth-1 and h == tilesHeight-1 {
				draw_sprite_part(slice_index,0, pixels*2+2,pixels*2+2, pixels,pixels, XX,YY)	
			}
			//	Right side piece
			else if w == tilesWidth-1 and h < tilesHeight-1 and h > 0 {
				draw_sprite_part(slice_index,0, pixels*2+2,pixels*1, pixels,pixels, XX,YY)		
			}
			//	Center tile
			else {
				draw_sprite_part(slice_index,0, pixels,pixels, pixels,pixels, XX,YY)		
			}
			YY += pixels
		}
		YY = yy
		XX += pixels
	}
	
	//draw_set_color(c_black)
	//draw_set_halign(fa_center)
	//draw_set_valign(fa_middle)
	//draw_text_ext(xx+(tilesWidth*pixels)/2, yy+(tilesHeight*pixels)/2, _string, string_height(_string), width)
}
	
function create_particle(Sprite_index, Particles, x, y) {
	var ID = instance_create_layer(x,y,"Instances",particle)
	ID.sprite_index = Sprite_index
	ID.particles = Particles
	ID.duration = 60
	return ID
}
	
function create_textbox(ID, _text) {
	var Textbox = instance_create_layer(0,0,"Instances",textbox)
	Textbox.ID = ID
	Textbox.text = _text
	
	//	Replace any variables with the string
	with Textbox {
		var Dialogue = text
		if string_count("%",Dialogue) >= 2 {
			for(var a=0;a<string_length(Dialogue);a++) {
				//	A variable
				if string_char_at(Dialogue,a) == "%" {
					var endIndex = -1
					//	Find the other percentage
					for(var s=a;s<string_length(Dialogue);s++) {
						//	Found it
						if s != a and string_char_at(Dialogue,s) == "%" {
							endIndex = s
							s = 500
						}
					}
					if endIndex > -1 { 
						//	Found it, lets find our variable
						var substring = string_copy(Dialogue,a, endIndex+1-a)
						var variableString = substring
						while string_count("%",substring) > 0 {
							substring = string_delete(substring,string_pos("%",substring),1)	
						}
						
						//	Substring only has variable now, separate into object and variable using the period
						var periodIndex = string_pos(".",substring)
						var Object = asset_get_index(string_copy(substring,0,periodIndex-1))
						var Variable = string_copy(substring,periodIndex+1,string_length(substring)+1-periodIndex)
						
						//	Check if object exists
						if instance_exists(Object) and variable_instance_exists(Object,Variable) {
							//	Replace the variable in the dialogue with a string of the actual variable
							var newString = string(variable_instance_get(Object,Variable))
							Dialogue = string_replace(Dialogue,variableString,newString)
							text = Dialogue
						}
						else {
							//debug.log("ERROR with dialogue. KEY: "+string(Key)+" at: "+string(a))	
						}
							
					}
				}
			}
		}	
	}
		
	//	Determine how many lines we have
	draw_set_font(font_dialogue)
	var widthSpacer = 20
	var heightSpacer = 40
	var width = 558
	var height = string_height_ext(_text,string_height(_text),width-(widthSpacer*2)) + heightSpacer*2
	var xx = display_get_gui_width()/2 - width/2
	var yy = display_get_gui_height() - height - heightSpacer
	
	var array = []
	var index = -1
	var wordIndex = 0
	//	Break string apart into individual words
	for(var i=0;i<string_length(_text);i++) {
		if (string_char_at(_text,i) == " " and i > 0 and i != index) or (i = string_length(_text)-1) {
			var Count = i-1-index
			if i = string_length(_text)-1 Count = i+1//-index
			var String = string_copy(_text,index+1,Count)
			
			//	Clean up any spaces in word
			while string_count(" ",String) > 0 {
				String = string_delete(String,string_pos(" ",String),1)
			}
			
			array[wordIndex] = String
			index = i
			wordIndex++
			
		}
	}
	//	Find each line break
	var usedWordIndex = 0
	var rowWords = 0
	var rows = []
	var row = 0
	while usedWordIndex < wordIndex {
		if rowWords == 0 {
			rows[row] = array[usedWordIndex]
			usedWordIndex++
			rowWords++
		}
		else {
			if string_width(rows[row] + " " + array[usedWordIndex]) < width {
				rows[row] += " " + array[usedWordIndex]
				usedWordIndex++
				rowWords++
			}
			else {
				row++
				rowWords = 0	
			}
		}
	}
	Textbox.rows = rows
	
}
	
function encode_gamedata(list_index) {
	var array = []
	for(var i=0;i<ds_list_size(list_index);i++) {
		array[i] = list_index[| i]	
	}
	var String = json_stringify(array)
	var list = ds_list_create()
	ds_list_add(list,String)
	var finalString = ds_list_write(list)
	ds_list_destroy(list)
	return finalString
}

function decode_gamedata(list_index, String) {
	var list = ds_list_create()
	ds_list_read(list, String)
	var finalString = list[| 0]
	ds_list_destroy(list)
	
	var array = json_parse(finalString)
	for(var i=0;i<array_length(array);i++) {
		list_index[| i] = array[i]
	}
}
	
function tile_info(_bottom, _top) constructor {
	bottom = _bottom
	top = _top
}