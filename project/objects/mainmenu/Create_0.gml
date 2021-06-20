menuIndex = 0
surface = -1
menu = menu.main

if room == RoomMainMenu {
	ini_open("save.ini")
	sound.volumeSound = ini_read_real("SETTINGS","sound",0.5)
	sound.volumeMusic = ini_read_real("SETTINGS","music",0.5)
	ini_close()
	if audio_is_playing(sound_underwater) audio_sound_gain(sound_underwater,sound.volumeSound,0)
}