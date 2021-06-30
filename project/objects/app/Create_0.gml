creator = ""
version = ""

mode = mode_PRODUCTION

math_set_epsilon(0.000000001)

canvasX = 0

paused = false
suitOn = false
gold = 1

newRoom = false
roomPrevious = -1

collisionMaps = 0
collisionMapsBuffers = ds_list_create()
collisionMapsMetadata = ds_list_create()

var Layer = "Instances"
instance_create_layer(0,0,Layer,input)
instance_create_layer(0,0,Layer,debug)
instance_create_layer(0,0,Layer,time)
instance_create_layer(0,0,Layer,sound)
instance_create_layer(0,0,Layer,water)
instance_create_layer(0,0,Layer,lighting)
instance_create_layer(0,0,Layer,shadows)
instance_create_layer(0,0,Layer,grid)
instance_create_layer(0,0,Layer,gui)
instance_create_layer(0,0,Layer,questManager)
instance_create_layer(0,0,Layer,characterManager)
instance_create_layer(0,0,Layer,cutsceneManager)
instance_create_layer(0,0,Layer,game)

function save_game(quick) {
	if quick debug.log("QUICK SAVING GAME")
	else debug.log("LONG SAVING GAME")
	ini_open("save.ini")
	
	////	Save settings
	var section = "SETTINGS"
	
	ini_write_real(section,"sound",sound.volumeSound)
	ini_write_real(section,"music",sound.volumeMusic)
	
	////	This is a full save!
	if !quick {
		ini_write_real(section,"saved",1)
	}
	
	////	Save databases
	if !quick {
		var section = "GAMEDATA"
		
		var questListString = encode_gamedata(questManager.questList)
		var finishedQuestListString = encode_gamedata(questManager.finishedQuestList)
		var characterList = encode_gamedata(characterManager.characterList)
		var cutsceneList = encode_gamedata(cutsceneManager.cutsceneList)
		var questInfoString = ds_grid_write(questManager.questInformation)
		
		ini_write_string(section,"questListString",questListString)
		ini_write_string(section,"finishedQuestListString",finishedQuestListString)
		ini_write_string(section,"characterList",characterList)
		ini_write_string(section,"cutsceneList",cutsceneList)
		ini_write_string(section,"questInfoString",questInfoString)
	
		ini_write_real(section,"cutsceneManager",cutsceneManager.cutscene)
		
		////	Room
		if room != RoomMainMenu {
			debug.log("Saving room: "+string_upper(string(room_get_name(room))))
			ini_write_string(section,"room",room_get_name(room))
		}
		
	}
	
	////	Save player stuff
	if instance_exists(player) {
		var section = "PLAYER"
	
		ini_write_real(section,"suitOn",player.suitOn)
		ini_write_real(section,"gold",player.gold)
	
		var inventoryString = encode_gamedata(player.inventory)
		ini_write_string(section,"inventoryString",inventoryString)
	}
	else {
		var section = "PLAYER"
		
		ini_write_real(section,"suitOn",false)
		ini_write_real(section,"gold",app.gold)
		
		var List = ds_list_create()
		var inventoryString = encode_gamedata(List)
		ini_write_string(section,"inventoryString",inventoryString)
		ds_list_destroy(List)
	}
	
	ini_close()
}

function load_game(quick) {
	if quick debug.log("QUICK LOADING GAME")
	else debug.log("LONG LOADING GAME")
	ini_open("save.ini")
	
	////	Load settings
	var section = "SETTINGS"
	
	sound.volumeSound = ini_read_real(section,"sound",0.5)
	sound.volumeMusic = ini_read_real(section,"music",0.5)
	
	////	Load databases
	if !quick {
		var section = "GAMEDATA"
	
		var questListString = ini_read_string(section,"questListString",0)
		var finishedQuestListString = ini_read_string(section,"finishedQuestListString",0)
		var characterListString = ini_read_string(section,"characterList",0)
		var cutsceneListString = ini_read_string(section,"cutsceneList",0)
		var questInfoString = ini_read_string(section,"questInfoString",0)
		
		if is_string(questListString) {
			decode_gamedata(questManager.questList, questListString)
			questManager.questCount = ds_list_size(questManager.questList)
		}
		else debug.log("ERROR LOADING Can't read questManager.questList string")
		
		if is_string(finishedQuestListString) {
			decode_gamedata(questManager.finishedQuestList, finishedQuestListString)
		} else debug.log("ERROR LOADING Can't read questManager.finishedQuestList string")
		
		if is_string(characterListString) {
			decode_gamedata(characterManager.characterList, characterListString)
		} else debug.log("ERROR LOADING Can't read characterManager.characterList string")
		
		if is_string(cutsceneListString) {
			decode_gamedata(cutsceneManager.cutsceneList, cutsceneListString)	
		} else debug.log("ERROR LOADING Can't read cutsceneManager.cutsceneList string")
		
		if is_string(questInfoString) {
			ds_grid_read(questManager.questInformation, questInfoString)
		} else debug.log("ERROR LOADING Can't read questManager.questInformation string")
		
		cutsceneManager.cutscene = ini_read_real(section,"cutsceneManager",-1)
		
		gui.toggle(true)
		
	}
	
	////	Load player stuff
	if instance_exists(player) {
		var section = "PLAYER"
	
		player.suitOn = ini_read_real(section,"suitOn",0)
		app.suitOn = player.suitOn
		player.gold = ini_read_real(section,"gold",0)
	
		var inventoryString = ini_read_string(section,"inventoryString",0)
	
		if is_string(inventoryString) {
			decode_gamedata(player.inventory, inventoryString)
		} else debug.log("ERROR LOADING Can't read player.inventory string")
	}	
	
	////	Main Menu Room Transition
	if !quick and room == RoomMainMenu {
		var Room = ini_read_string("GAMEDATA","room","RoomIntro")
		debug.log("Loading room: "+string_upper(string(Room)))
		ini_close()
		var RoomIndex = asset_get_index(Room)
		if RoomIndex == -1 RoomIndex = 0
		app.roomTransition(RoomIndex, 10)
		exit
	}
	
	ini_close()
}

function scale_canvas(new_width, new_height) {
	window_set_size(new_width, new_height)
	
	//if center {
	//	centerWindow = true
	//}
	
	//surface_resize(application_surface,new_width,new_height)
}
	
function cameraSetup() {

		width = 640
		height = 360
		zoom_level = 1
		
		var fullscreen = false
		//var windowWidth = window_get_width()
		var windowHeight = window_get_height()
		//var displayWidth = display_get_width()
		var displayHeight = display_get_height()
		if window_get_width() == display_get_width() and (abs(windowHeight - displayHeight) < 100) {
			fullscreen = true
		}

		#region Views

			view_enabled = true
			view_visible[0] = true

			view_set_visible(0,true)

			view_set_wport(0,width)
			view_set_hport(0,height)

		#endregion
		#region Resize and Center Game Window

			if !fullscreen window_set_rectangle((display_get_width()-view_wport[0])*0.5,(display_get_height()-view_hport[0])*0.5,view_wport[0],view_hport[0])
			
			if !fullscreen window_center()
	
			surface_resize(application_surface,view_wport[0],view_hport[0])
	
			display_set_gui_size(width,height)


		#endregion
		#region Camera Create

			camera = camera_create()

			var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
			var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

			camera_set_view_mat(camera,viewmat)
			camera_set_proj_mat(camera,projmat)
	
			camera_set_view_pos(camera,x,y)
			camera_set_view_size(camera,width,height)
	
			camera_set_view_speed(camera,200,200)
			camera_set_view_border(camera,width,height)
	
			camera_set_view_target(camera,id)

			view_camera[0] = camera

		#endregion
	
		//if !fullscreen scale_canvas(1920,1080)

		default_zoom_width = camera_get_view_width(camera)
		default_zoom_height = camera_get_view_height(camera)

}
	
function cameraFix() {
	#region Views

		view_enabled = true
		view_visible[0] = true

		view_set_visible(0,true)

		view_set_wport(0,width)
		view_set_hport(0,height)

	#endregion
	#region Camera Create

		camera = camera_create()

		var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
		var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

		camera_set_view_mat(camera,viewmat)
		camera_set_proj_mat(camera,projmat)
	
		camera_set_view_pos(camera,x,y)
		camera_set_view_size(camera,width,height)
	
		camera_set_view_speed(camera,200,200)
		camera_set_view_border(camera,width,height)
	
		camera_set_view_target(camera,id)

		view_camera[0] = camera

	#endregion
}

cameraFocusOnPlayer = true
cameraFocusX = x
cameraFocusY = y
cameraFocusDuration = -1
cameraLerp = true
function cameraFocus(_x, _y, _duration, _lerp){
	
	cameraFocusX = _x
	cameraFocusY = _y
	cameraFocusDuration = _duration
	cameraLerp = _lerp
	cameraFocusOnPlayer = false
	
}
	
cameraSetup()

underwater = false
function underwaterChange(on) {
	if on {
		underwater = true
		water.on = true
		lighting.on = true
		if !audio_is_playing(sound_underwater) {
			audio_play_sound(sound_underwater,0,true)
			audio_sound_gain(sound_underwater,sound.volumeSound,0)	
		}
	}
	else {
		underwater = false
		water.on = false
		lighting.on = false
		if audio_is_playing(sound_underwater) {
			audio_stop_sound(sound_underwater)
		}
	}
}
	
pauseSurface = -1
pauseSurfaceBuffer = -1
function pause() {
	paused = !paused
	//	Paused
	if paused {
		if pauseSurfaceBuffer > -1 and buffer_exists(pauseSurfaceBuffer) buffer_delete(pauseSurfaceBuffer)
		if surface_exists(pauseSurface) surface_free(pauseSurface)
		pauseSurfaceBuffer = buffer_create(display_get_gui_width()*display_get_gui_height()*4,buffer_grow,1)
		pauseSurface = surface_create(display_get_gui_width(), display_get_gui_height())
		surface_set_target(pauseSurface)
		draw_clear_alpha(c_black, 0)
		
		draw_surface(application_surface,0,0)
		
		surface_reset_target()
		buffer_get_surface(pauseSurfaceBuffer,pauseSurface,0)
		instance_deactivate_object(class_unit)
		instance_deactivate_object(rope)
		instance_deactivate_object(particle)
		
		if !instance_exists(mainmenu) instance_create_layer(0,0,"Instances",mainmenu)
	}
	//	Unpaused
	else {
		instance_activate_object(class_unit)
		instance_activate_object(rope)
		instance_activate_object(particle)
		
		if instance_exists(mainmenu) instance_destroy(mainmenu)
	}
}

roomTransitionTimer = -1
roomTransitionTo = -1
roomTransitionFrom = -1
roomTransitionLerp = -1
roomTransitionLerpStart = -1
roomTransitionSpeed = -1
roomTransitionStage = -1
roomTransitionBuffer = -1
function roomTransition(Room, Speed) {
	roomTransitionTo = Room
	roomTransitionSpeed = Speed
	
	roomTransitionFrom = room
	
	roomTransitionLerp = display_get_gui_width()
	roomTransitionLerpStart = roomTransitionLerp
	
	roomTransitionStage = 0
	
	depth = -2000
	
	collisionMaps = 0
	
}

function roomTransitioning() {
	var Width = display_get_gui_width()
	var Height = display_get_gui_height()
	var surface = surface_create(Width,Height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	switch(roomTransitionStage)
	{
		//	Old room
		case 0:
			draw_set_color(c_black)
			draw_set_alpha(1)
			draw_rectangle(0,0,Width,Height,false)
	
			gpu_set_blendmode(bm_subtract)
	
			var coorX, coorY
			//if instance_exists(player) {
			//	coorX = player.x
			//	coorY = player.y-player.z
			//}
			//else {
				coorX = camera_get_view_x(app.camera) + (camera_get_view_width(app.camera)/2)	
				coorY = camera_get_view_y(app.camera) + (camera_get_view_height(app.camera)/2)	
				coorX = (camera_get_view_width(app.camera)/2)	
				coorY = (camera_get_view_height(app.camera)/2)	
			//}
			draw_circle(coorX,coorY,roomTransitionLerp,false)
	
			gpu_set_blendmode(bm_normal)
	
			surface_reset_target()
			
			roomTransitionLerp = approach(roomTransitionLerp, 0, roomTransitionSpeed)
			
			//	Transition over, lets go to the next room
			if roomTransitionLerp == 0 {
				
				buffer_loader(roomTransitionTo)
				
				if room != RoomMainMenu app.save_game(false)
				room_goto(roomTransitionTo)
				app.cameraRefresh = true
				roomTransitionStage = 1
				if roomTransitionTo == RoomDocks_Underwater app.underwaterChange(true)
				else app.underwaterChange(false)
				roomTransitionTimer = 5
				
				//	Kill music
				if sound.musicIndex > -1 {
					audio_stop_sound(sound.musicIndex)
					sound.musicIndex = -1
				}
			}
		break
		//	Pause on new room
		case 1:
			draw_set_color(c_black)
			draw_set_alpha(1)
			draw_rectangle(0,0,Width,Height,false)
			
			surface_reset_target()
			
			if surface_exists(shadows.surface) surface_free(shadows.surface)
		
			if roomTransitionTimer > -1 roomTransitionTimer--
			else {
				roomTransitionStage = 2
				app.load_game(true)
				scene_loader()
				if roomTransitionFrom != RoomMainMenu app.save_game(false)
			}
		break
		//	New room
		case 2:
			draw_set_color(c_black)
			draw_set_alpha(1)
			draw_rectangle(0,0,Width,Height,false)
			
			gpu_set_blendmode(bm_subtract)
	
			var coorX, coorY
			//if instance_exists(player) {
			//	coorX = player.x
			//	coorY = player.y-player.z
			//}
			//else {
				coorX = camera_get_view_x(app.camera) + (camera_get_view_width(app.camera)/2)	
				coorY = camera_get_view_y(app.camera) + (camera_get_view_height(app.camera)/2)	
				coorX = (camera_get_view_width(app.camera)/2)	
				coorY = (camera_get_view_height(app.camera)/2)	
			//}
			draw_circle(coorX,coorY,roomTransitionLerp,false)
	
			gpu_set_blendmode(bm_normal)
	
			surface_reset_target()
			
			roomTransitionLerp = approach(roomTransitionLerp, Width, roomTransitionSpeed)
			
			//	Transition over, lets go to the next room
			if roomTransitionLerp == Width {
				roomTransitionTo = -1
				roomTransitionLerp = -1
				roomTransitionLerpStart = -1
				roomTransitionSpeed = -1
				roomTransitionStage = -1
				roomTransitionFrom = -1
				depth = 1
			}
		break	
	}
	
	draw_surface(surface,camera_get_view_x(app.camera),camera_get_view_y(app.camera))
	
	{
		if buffer_exists(roomTransitionBuffer) buffer_delete(roomTransitionBuffer)
		roomTransitionBuffer = buffer_create(Width*Height*4, buffer_grow, 1)
		buffer_get_surface(roomTransitionBuffer,surface, 0)
	}
	
	surface_free(surface)
	
	//debug.log("roomTransitionLerp: "+string(roomTransitionLerp))
}
	
if room == RoomAppStart {
	room_goto(RoomMainMenu)
	underwaterChange(true)
	cameraRefresh = true
}

function scene_loader() {
	//	room
	//	main quest
	//	side quests
	//	character data
	
	var Quest = questManager.current_quest()
	var Layer = "Instances"
	
	if Quest == -1 debug.log("SCENELOADER - NO ACTIVE QUEST")
	
	switch(room) {
		
		#region City
			case RoomCityHub:
				if Quest > -1 {
					switch(Quest.index) {
						#region	Final Coin quest
						case quests.spendFinalCoin:
						
							if !instance_exists(brotherIntro) {
								var Brother = instance_create_layer(976,224,Layer,brotherIntro)
								Brother.image_xscale = -1
							}
							
							sound.playMusic(music_surface, true)
						
							var Vendor = instance_create_layer(1232,512,Layer,vendor)
							Vendor.image_xscale = -1
							var vendorCart = instance_create_layer(1328,544,Layer,cart)
							
							var Girl = instance_create_layer(1440,496,Layer,girl)
						
							var Pete = instance_create_layer(1408,848,Layer,sailorPeteSitting)
							
							var _mafia0 = instance_create_layer(1104,240,Layer,mafia0)
							var _mafia1 = instance_create_layer(1296,240,Layer,mafia1)
							_mafia1.image_xscale = -1
							var mafiaDoors = instance_create_layer(1184,256,Layer,mafiaDoor)
						
							var bully1 = instance_create_layer(432,736,Layer,bully2Dice)
							var bully2 = instance_create_layer(304,736,Layer,bully1Stand)
							bully2.image_xscale = -1
							var diceKid = instance_create_layer(368,752,Layer,dicekid1)
							diceKid.image_xscale = -1
							
							var bobRoss = instance_create_layer(992,672,"Instances",bobross)
						
							//	destroy the dock room change
							if instance_exists(collisionRoomChange) with collisionRoomChange replace_with_collision()
						
							var Collision = instance_create_layer(1600,208,Layer,collision)
							Collision.image_yscale = 8.75
						
						break
						#endregion
						
						#region	Street dance / chasing after brother
						case quests.streetDance:
							var Vendor = instance_create_layer(1232,512,Layer,vendorPlayerChase)
							Vendor.image_xscale = -1
							var vendorCart = instance_create_layer(1328,544,Layer,cart)
							
							//sound.playMusic(music_surface, true)
						
							//var Adult = instance_create_layer(576,608,Layer,adultHub)
							//var Adult = instance_create_layer(320,512,Layer,adultHub)
							//var Car = instance_create_layer(384,608,Layer,car)
						
							//var Adult = instance_create_layer(951,840,Layer,adultHub)
						
							//var Adult = instance_create_layer(1440,238,Layer,adultHub)
							//Adult.image_xscale = -1
						
							//var Adult = instance_create_layer(1440,822,Layer,adultHub)
							//Adult.image_xscale = -1
						
						break
						#endregion
						
						#region Necklace
						case quests.necklace:
						
							var Vendor = instance_create_layer(1248,512,Layer,vendorShop)
							Vendor.image_xscale = -1
							
							var Nadya = instance_create_layer(1398,752,Layer,nadya)
							Nadya.npcKey = "nadyaNecklace"
							with Nadya load_dialogue()
							
							if cutsceneManager.find_cutscene(cutscene.mafiaVendorShake) == -1 {
								cutsceneManager.cutscene = cutscene.mafiaVendorShake
								var _mafia0 = instance_create_layer(1184,512,Layer,mafia0)
								instance_create_layer(0,0,Layer,mafiaVendorShakedown)
								_mafia0.interactibility = false
							}
							else {
								var _mafia0 = instance_create_layer(1104,240,Layer,mafia0)
								_mafia0.interactibility = false
							}
						
							sound.playMusic(music_surface, true)
							
							if roomPrevious == RoomAlleyHub or roomPrevious == RoomMainMenu or roomPrevious == -1 {
								player.groundX = 912
								player.groundY = 80
								app.x = player.groundX
								app.y = player.groundY
							}
							else if roomPrevious == RoomDocks {
								player.groundX = 1552
								player.groundY = 512
								app.x = player.groundX
								app.y = player.groundY
							}
							
						break
						#endregion
					}
					debug.log("SCENELOADER - Loading for Quest: "+string_upper(questManager.questNames[Quest.index]))
				}
			break
		#endregion
		
		#region Docks
			case RoomDocks:
			
				if roomPrevious == RoomDocks_Underwater {
					//	Use the cage
					cage.y += 360
					cage.lowered = true
					cage.inUse = true
					cage.liftDirection = up
					cage.filled = true	
				}
			
				if Quest > -1 {
					switch(Quest.index) {
						
						#region	Bullies are throwing watch off the dock
						case quests.streetDance:
						
							suitPile.interactibility = false // deact suit
							cage.interactibility = false	 // deact cage
							
							instance_create_layer(0,0,Layer,bullysTossWatch)
						
							var Brother = instance_create_layer(1232,352,Layer,brotherWatchToss)
							
							var bully2 = instance_create_layer(1328,352,Layer,bully2Watch)
							bully2.image_xscale = -1
							var bully1 = instance_create_layer(1376,352,Layer,bully1Watch)
							bully1.image_xscale = -1
							
							//	Replace room change with collision
							collisionRoomChange.replace_with_collision()
							
						break
						#endregion
						
						#region Retrieving the watch from underwater
						case quests.watch:
							if roomPrevious == RoomDocks_Underwater {
								
								////	Use the cage
								//cage.y += 360
								//cage.lowered = true
								//cage.inUse = true
								//cage.liftDirection = up
								//cage.filled = true
								
								//	We left the underwater without finding the watch
								if player.item_check(item.watch) == -1 {
									var Pete = instance_create_layer(480,400,Layer,sailorPeteGotSuit)
									Pete.stage = 1
									Pete.dialogueIndex++
									
									var Brother = instance_create_layer(754,360,Layer,brotherGotSuit)
									Brother.image_xscale = -1
								}
								//	We have the watch!
								else {
									var Brother = instance_create_layer(768,352,Layer,brotherGivingWatch)
									Brother.interactable = true
								}
								
								//	Replace room change with collision
								collisionRoomChange.replace_with_collision()
							}
							else if roomPrevious == RoomCityHub {
									
							}
							
						break
						#endregion
						
						#region Retrieving the necklace from underwater
							case quests.necklace:
								
								var Brother = instance_create_layer(816,304,Layer,brother)
								Brother.npcKey = "brotherNecklace"
								with Brother load_dialogue()
								
								var Husband = instance_create_layer(1072,304,Layer,husband)
								Husband.image_xscale = -1
								Husband.npcKey = "husbandAndWifePre"
								with Husband load_dialogue()
								
								var Wife = instance_create_layer(1120,320,Layer,wife)
								Wife.image_xscale = -1
								Wife.interactibility = false
								
							break
						#endregion
					}
				}	
			break	
		#endregion
		
		#region Docks - Underwater 
			case RoomDocks_Underwater:
				
				if roomPrevious == RoomDocks {
					//	Use the cage
					cage.z = 360
					cage.lowered = false
					cage.inUse = true
					cage.liftDirection = down
					cage.filled = true
				}
				else {
					cage.lowered = true
					cage.liftDirection = up
				}
				
				if !debug.rebuilding sound.playMusic(music_underwater, true)
			
				if Quest > -1 {
					switch(Quest.index) {
						
						#region Retrieving the watch
						case quests.watch:
							var Watch = instance_create_layer(2156,1213,Layer,watch)
							var QM2 = instance_create_layer(0,0,Layer,questManager2)
							var Light = instance_create_layer(2160,1216,Layer,class_light)
							Light.image_xscale = 1.468
							Light.image_yscale = 1.375
							surface_free(lighting.surface)
							
							var LostCrab = instance_create_layer(1440,2064,Layer,mudcrab_lost)
						break
						#endregion
						
						#region Retrieving the necklace
							case quests.necklace:
							
								if instance_exists(player) and player.item_check(item.necklace) == -1 {
									var Jelly = instance_create_layer(1043,2298,Layer,jellyfish)
									if cutsceneManager.find_cutscene(cutscene.jellyGivingNecklace) > -1 {
										Jelly.dialogueIndex = 13
									}
								}
								
								var Crab = instance_create_layer(1296,2128,Layer,crab)
								Crab.holdingItem = chainlink
								Crab.sprite_index = s_crab_chainlink
								Crab.nodes[0,0] = 1296
								Crab.nodes[1,0] = 2128
								
								Crab.nodes[0,1] = 1904
								Crab.nodes[1,1] = 1568
								
								Crab.nodes[0,2] = 768
								Crab.nodes[1,2] = 688
								
								Crab.nodes[0,3] = 624
								Crab.nodes[1,3] = 1616
								
								Crab.fleeX = 1873
								Crab.fleeY = 1883
								
							break
						#endregion
					}
				}
				else {
						
				}
			break
		#endregion
		
		#region Alleyway
			case RoomAlleyHub:
				//	After the final coin
				if (Quest > -1 and Quest.index == quests.spendFinalCoin) or (Quest == -1 and questManager.find_finished_quest(quests.spendFinalCoin) > -1) {
					var Watch = instance_create_layer(292,168,"Instances",watch)
					var Brother = instance_create_layer(384,336,"Instances",brotherFinalCoin)
					Brother.image_xscale = -1
					lighting.darkness = 0.2
					lighting.on = true
					surface_free(lighting.surface)
					playerbed.interactibility = true
					playerbed.interactable = true
					sound.playMusic(music_brothers, true)
				}
				//	The night after getting the watch
				else if (Quest > -1 and Quest.index == quests.watch) {
					lighting.darkness = 0.2
					lighting.on = true
					surface_free(lighting.surface)
					brothersbox.filled = true
					playerbed.filled = true
					player.muted = true
					instance_create_layer(0,0,"Instances",roomAlleyAfterWatch)
				}
				//	The morning of the necklace
				else if (Quest > -1 and Quest.index == quests.necklace) {
					player.groundX = playerbed.x
					player.groundY = playerbed.y + 32
					playerbed.interactability = false
					playerbed.interactable = false
					
					app.cameraFocus(player.x,player.y,1,true)
					
					var Col = instance_position(339,399,collision)
					var ColRoomChange = instance_create_layer(Col.x,Col.y,"Instances",collisionRoomChange)
					ColRoomChange.image_xscale = Col.image_xscale
					ColRoomChange.image_yscale = Col.image_yscale
					ColRoomChange.Room = RoomCityHub
					instance_destroy(Col)
				}
			break
		#endregion
	}
	
	scene_loaded = true
	
	debug.log(string_upper(room_get_name(room)))
}
	
function buffer_loader(roomIndex) {
	//	Prep collisionMap buffers and metadata
	var filename = room_get_name(roomIndex)+"buffers.bin"
	if file_exists(filename) {
		var carton = carton_load(filename, true)
		if collisionMapsBuffers > -1 ds_list_destroy(collisionMapsBuffers)
		if collisionMapsMetadata > -1 ds_list_destroy(collisionMapsMetadata)
		collisionMapsBuffers = carton_unpack(carton, false)
		collisionMapsMetadata = carton_unpack(carton, true)
		carton_destroy(carton)
		return true
	}
	else {
		return false	
	}
}