extends AudioStreamPlayer

const menu_music = preload("res://Music/GhostMenu2.wav")

func _play_music(music: AudioStream):
	if stream == music:
		return
		
	stream = music
	play()
		
		
func play_music_menu():
	_play_music(menu_music)
