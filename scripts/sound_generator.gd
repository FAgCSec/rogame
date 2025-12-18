extends Node

# Generador de sonidos sintéticos 8-bit para el juego

# Crea un tono sintético
func create_tone(frequency: float, duration: float, sample_rate: int = 22050) -> AudioStreamWAV:
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	for i in range(frames):
		var t = float(i) / sample_rate
		var sample = sin(2.0 * PI * frequency * t)
		
		# Aplicar envelope para evitar clicks
		var envelope = 1.0
		if i < sample_rate * 0.01:  # Attack
			envelope = float(i) / (sample_rate * 0.01)
		elif i > frames - sample_rate * 0.05:  # Release
			envelope = float(frames - i) / (sample_rate * 0.05)
		
		sample *= envelope
		
		# Convertir a 16-bit
		var value = int(clamp(sample * 32767, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	
	return stream

# Sonido de disparo: pew pew
func create_shoot_sound() -> AudioStreamWAV:
	var sample_rate = 22050
	var duration = 0.1
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	for i in range(frames):
		var t = float(i) / sample_rate
		# Frecuencia descendente de 800Hz a 200Hz
		var freq = 800 - (600 * t / duration)
		var sample = sin(2.0 * PI * freq * t)
		
		# Envelope rápido
		var envelope = 1.0 - (t / duration)
		sample *= envelope
		
		var value = int(clamp(sample * 32767 * 0.3, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	
	return stream

# Sonido de daño: hit corto
func create_hurt_sound() -> AudioStreamWAV:
	var sample_rate = 22050
	var duration = 0.15
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	for i in range(frames):
		var t = float(i) / sample_rate
		# Frecuencia baja descendente
		var freq = 300 - (250 * t / duration)
		var sample = sin(2.0 * PI * freq * t)
		
		# Agregar ruido
		sample += randf_range(-0.3, 0.3)
		
		# Envelope
		var envelope = 1.0 - (t / duration)
		sample *= envelope
		
		var value = int(clamp(sample * 32767 * 0.4, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	
	return stream

# Sonido de muerte de enemigo: explosión
func create_enemy_death_sound() -> AudioStreamWAV:
	var sample_rate = 22050
	var duration = 0.25
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	for i in range(frames):
		var t = float(i) / sample_rate
		# Ruido blanco con filtro de frecuencia baja
		var sample = randf_range(-1.0, 1.0)
		
		# Agregar tono bajo
		sample += sin(2.0 * PI * 120 * t) * 0.5
		
		# Envelope
		var envelope = 1.0 - (t / duration)
		sample *= envelope
		
		var value = int(clamp(sample * 32767 * 0.5, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	
	return stream

# Sonido de subida de nivel: arpeggio ascendente
func create_level_up_sound() -> AudioStreamWAV:
	var sample_rate = 22050
	var duration = 0.6
	var frames = int(sample_rate * duration)
	var data = PackedByteArray()
	
	# Notas del arpeggio: C5, E5, G5, C6 (523, 659, 784, 1047 Hz)
	var notes = [523.0, 659.0, 784.0, 1047.0]
	var note_duration = duration / notes.size()
	
	for i in range(frames):
		var t = float(i) / sample_rate
		var note_index = int(t / note_duration)
		if note_index >= notes.size():
			note_index = notes.size() - 1
		
		var freq = notes[note_index]
		var sample = sin(2.0 * PI * freq * t)
		
		# Añadir armónico para más brillo
		sample += sin(2.0 * PI * freq * 2 * t) * 0.3
		
		# Envelope suave
		var envelope = 1.0
		if i < sample_rate * 0.01:  # Attack
			envelope = float(i) / (sample_rate * 0.01)
		elif i > frames - sample_rate * 0.1:  # Release
			envelope = float(frames - i) / (sample_rate * 0.1)
		
		sample *= envelope * 0.4
		
		var value = int(clamp(sample * 32767, -32768, 32767))
		data.append(value & 0xFF)
		data.append((value >> 8) & 0xFF)
	
	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	
	return stream
