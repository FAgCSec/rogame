extends Node

# Generador de música ambiente procedural

var music_player: AudioStreamPlayer

func _ready():
	# Crear reproductor de música
	music_player = AudioStreamPlayer.new()
	music_player.volume_db = -8.0
	music_player.bus = "Master"
	add_child(music_player)

func play_ambient_music():
	var stream = create_ambient_music()
	music_player.stream = stream
	music_player.play()

func stop_music():
	music_player.stop()

func set_volume(db: float):
	music_player.volume_db = db

# Crea una música ambiente relajante de 30 segundos en loop
func create_ambient_music() -> AudioStreamWAV:
	var sample_rate = 22050
	var duration = 30.0  # 30 segundos
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	# Progresión de acordes (frecuencias base)
	var chord_progression = [
		[261.63, 329.63, 392.00],  # C Mayor (C, E, G)
		[293.66, 369.99, 440.00],  # D menor (D, F, A)
		[246.94, 329.63, 392.00],  # Am (A, C, E) - ajustado
		[293.66, 349.23, 440.00],  # G Mayor (G, B, D) - ajustado
	]
	
	# Melodía suave (notas individuales)
	var melody_notes = [523.25, 587.33, 659.25, 587.33, 523.25, 493.88, 440.00, 493.88]
	
	var chord_duration = duration / chord_progression.size()
	var note_duration = chord_duration / melody_notes.size()
	
	for i in range(frames):
		var t = float(i) / sample_rate
		var sample = 0.0
		
		# Determinar el acorde actual
		var chord_index = int(t / chord_duration) % chord_progression.size()
		var chord = chord_progression[chord_index]
		
		# Agregar acordes de fondo (suave)
		for freq in chord:
			sample += sin(2.0 * PI * freq * t) * 0.08
		
		# Agregar melodía
		var note_index = int((t - chord_index * chord_duration) / note_duration) % melody_notes.size()
		var melody_freq = melody_notes[note_index]
		
		# Envelope para las notas (ataque y decay suaves)
		var note_time = fmod(t, note_duration)
		var note_envelope = 1.0
		if note_time < 0.05:  # Attack
			note_envelope = note_time / 0.05
		elif note_time > note_duration - 0.1:  # Release
			note_envelope = (note_duration - note_time) / 0.1
		
		sample += sin(2.0 * PI * melody_freq * t) * 0.12 * note_envelope
		
		# Agregar pad ambiente (muy suave)
		sample += sin(2.0 * PI * 110.0 * t) * 0.03  # A bajo
		sample += sin(2.0 * PI * 220.0 * t) * 0.02  # A octava
		
		# Limitar y convertir a 16-bit
		var value = int(clamp(sample * 32767 * 0.6, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	stream.loop_begin = 0
	stream.loop_end = frames
	
	return stream

# Música más dinámica para momentos de acción
func create_action_music() -> AudioStreamWAV:
	var sample_rate = 22050
	var duration = 20.0
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	var bass_notes = [110.00, 123.47, 98.00, 130.81]  # A, B, G, C
	var beat_duration = duration / (bass_notes.size() * 4)
	
	for i in range(frames):
		var t = float(i) / sample_rate
		var sample = 0.0
		
		# Bass line
		var bass_index = int(t / (duration / bass_notes.size())) % bass_notes.size()
		var bass_freq = bass_notes[bass_index]
		sample += sin(2.0 * PI * bass_freq * t) * 0.15
		
		# Arpeggio rápido
		var arp_freq = bass_freq * pow(2.0, int(t / beat_duration) % 4)
		sample += sin(2.0 * PI * arp_freq * t) * 0.08
		
		# Ritmo con square wave
		if fmod(t, beat_duration) < beat_duration * 0.3:
			sample += 0.05 if sin(2.0 * PI * 440.0 * t) > 0 else -0.05
		
		var value = int(clamp(sample * 32767 * 0.7, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	stream.loop_begin = 0
	stream.loop_end = frames
	
	return stream
