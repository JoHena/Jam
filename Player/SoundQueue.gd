extends Node
class_name SoundQueue

var SoundStreams = {}
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for sound_player in get_children():
		SoundStreams[sound_player.name] = sound_player

func playMusic(song_name):
	SoundStreams[song_name].play()

func playEffect(effect_name, min_pitch, max_pitch):
	SoundStreams[effect_name].pitch_scale = rng.randf_range(min_pitch, max_pitch)
	SoundStreams[effect_name].play()
