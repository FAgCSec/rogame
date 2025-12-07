# Assets de Audio

## 🎵 Especificaciones Técnicas

### Formato
- **BGM**: .ogg (mejor para loops en Godot)
- **SFX**: .wav (baja latencia) o .ogg

### Calidad
- **Sample Rate**: 44100 Hz
- **Bit Depth**: 16-bit
- **Canales**: Stereo para BGM, Mono para SFX

### Duración
- **BGM**: 1-3 minutos (debe hacer loop perfecto)
- **SFX**: 0.1-1 segundo

## 🎼 Audio Necesario

### Música de Fondo (BGM)
- [ ] `bgm_gameplay.ogg` - Música principal del juego
  - Estilo: Energética, rápida, épica
  - Debe hacer loop perfecto
  - Volumen moderado (-6 a -12 dB)

- [ ] `bgm_menu.ogg` - Música del menú (opcional)
  - Estilo: Más calmada que gameplay
  - Loop perfecto

### Efectos de Sonido (SFX)

#### Combate
- [ ] `shoot.wav` - Sonido de disparo del jugador
  - Corto, limpio, no molesto (se repetirá mucho)
  
- [ ] `enemy_hit.wav` - Enemigo recibe daño
  - Impacto satisfactorio
  
- [ ] `enemy_death.wav` - Enemigo muere
  - Más dramático que hit

#### Jugador
- [ ] `player_hurt.wav` - Jugador recibe daño
  - Claro y audible sobre la música
  
- [ ] `player_death.wav` - Jugador muere (opcional)
  - Dramático, señal clara de game over

#### Progresión
- [ ] `xp_pickup.wav` - Recoger XP
  - Breve, satisfactorio (pitch puede variar)
  
- [ ] `level_up.wav` - Subida de nivel
  - Celebratorio, distintivo

#### UI
- [ ] `button_click.wav` - Click en botón
  - Corto, claro
  
- [ ] `button_hover.wav` - Hover sobre botón (opcional)
  - Muy sutil

## 🔍 Recursos Recomendados

### Sitios de Audio Gratis

1. **Freesound.org** ⭐ Mejor para SFX
   - https://freesound.org/
   - Requiere cuenta gratuita
   - Licencias Creative Commons

2. **OpenGameArt.org** - Audio para juegos
   - https://opengameart.org/art-search-advanced?keys=&field_art_type_tid%5B%5D=13

3. **Incompetech.com** ⭐ Mejor para BGM
   - https://incompetech.com/music/
   - Música de Kevin MacLeod
   - Gratis con atribución

4. **Zapsplat.com** - SFX variados
   - https://www.zapsplat.com/
   - Cuenta gratuita

5. **Pixabay Audio** - Música y efectos
   - https://pixabay.com/music/

6. **BBC Sound Effects** - Biblioteca profesional
   - https://sound-effects.bbcrewind.co.uk/

### Términos de Búsqueda

Para **BGM**:
- "retro game music"
- "8-bit action"
- "chiptune intense"
- "synthwave game"
- "electronic battle"

Para **SFX**:
- Disparo: "laser shoot", "gun shot", "pew"
- Daño: "hit impact", "punch"
- Muerte: "explosion small", "death"
- XP: "coin pickup", "gem collect", "ding"
- Level up: "power up", "success fanfare"
- UI: "button click", "menu select"

## 🛠️ Herramientas

### Editores de Audio
- **Audacity** (gratis) - Edición básica
- **Ocenaudio** (gratis) - Más moderno que Audacity
- **LMMS** (gratis) - Crear música propia

### Generadores de SFX
- **ChipTone** - Generador de SFX retro (web)
  - https://sfbgames.itch.io/chiptone
  
- **Bfxr** - Generador de efectos 8-bit (web)
  - https://www.bfxr.net/

- **SFXR** - Generador clásico (descargable)

### Convertir Audio
Si necesitas convertir formatos:
```bash
# Instalar FFmpeg
# Luego:
ffmpeg -i input.mp3 -acodec libvorbis output.ogg
ffmpeg -i input.mp3 output.wav
```

O usar herramientas web como:
- https://cloudconvert.com/
- https://online-audio-converter.com/

## 📊 Configuración en Godot

### Para BGM (Music)
```gdscript
# En la escena, agregar AudioStreamPlayer
var music_player = AudioStreamPlayer.new()
music_player.stream = load("res://assets/audio/bgm/bgm_gameplay.ogg")
music_player.autoplay = true
music_player.bus = "Music"  # Crear bus en Audio settings
```

### Para SFX
```gdscript
# En cada escena que necesite SFX
var shoot_sound = AudioStreamPlayer.new()
shoot_sound.stream = load("res://assets/audio/sfx/shoot.wav")
shoot_sound.bus = "SFX"

# Reproducir
shoot_sound.play()
```

### Audio Buses
Configurar en Project > Audio:
1. Master
   - Music (volumen -3 dB)
   - SFX (volumen 0 dB)

## 💡 Tips

1. **Volumen**: La música debe estar más baja que los efectos importantes
2. **Loops**: Usa herramientas como Audacity para hacer loops perfectos
3. **Variación**: Para SFX repetitivos (shoot), considera pitch aleatorio:
   ```gdscript
   shoot_sound.pitch_scale = randf_range(0.9, 1.1)
   ```
4. **Compresión**: Usa .ogg para BGM (menor tamaño), .wav para SFX críticos
5. **Testing**: Juega con audio durante 10+ minutos para verificar que no sea molesto

## 📝 Atribución

Crea `AUDIO_CREDITS.txt` en esta carpeta:
```
=== MÚSICA ===
bgm_gameplay.ogg
Título: [nombre]
Autor: [compositor]
Fuente: [URL]
Licencia: [tipo]

=== SFX ===
shoot.wav
Autor: [creador]
Fuente: [URL]
Licencia: [tipo]
```

## 🎯 Prioridad

1. **Alta**: bgm_gameplay, shoot, xp_pickup, level_up
2. **Media**: enemy_hit, player_hurt, button_click
3. **Baja**: todos los demás

---

**Nota**: Para desarrollo inicial, puedes usar placeholders o incluso sin audio. El audio puede agregarse en las etapas finales del proyecto.
