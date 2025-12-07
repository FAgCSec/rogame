# Lista de Tareas del Proyecto

## ✅ Completado

### Estructura y Código
- [x] Configuración del proyecto Godot
- [x] Sistema de GameManager (singleton)
- [x] Script del jugador con ataque automático
- [x] Scripts de 3 tipos de enemigos (Fast, Normal, Tank)
- [x] Sistema de proyectiles
- [x] Sistema de XP y gemas
- [x] Sistema de progresión y niveles
- [x] Menú de mejoras (6 upgrades diferentes)
- [x] Scripts de UI completos (HUD, Menús, Game Over)
- [x] Sistema de spawning de enemigos
- [x] Sistema de pausa
- [x] Documentación del proyecto

## 🔨 Por Hacer - ESCENAS (.tscn)

Todas las escenas deben crearse en Godot Editor. Los scripts ya están listos.

### Prioridad Alta
- [ ] `scenes/game_world.tscn` - Escena principal del juego
  - Agregar nodo `Node2D` como raíz
  - Agregar `TileMap` o `Sprite2D` para el fondo
  - Instanciar Player
  - Agregar Timer para spawning (`SpawnTimer`)
  - Agregar Camera2D que siga al jugador
  - Agregar UI (HUD, PauseMenu, GameOverMenu, UpgradeMenu)
  - Script: `game_world.gd`

- [ ] `scenes/entities/player.tscn` - Jugador
  - Raíz: `CharacterBody2D`
  - Nodos hijos:
    - `Sprite2D` (temporal: cuadrado de color)
    - `CollisionShape2D` (forma circular o rectangular)
    - `Node2D` llamado "WeaponPivot" para rotar el arma
    - `Timer` llamado "AttackTimer" (wait_time = 1.0)
    - `Area2D` llamado "Hurtbox" con CollisionShape2D
    - `Area2D` llamado "PickupArea" con CollisionShape2D (radio grande)
    - `AnimationPlayer` (opcional)
  - Agregar a grupo: "player"
  - Script: `player.gd`

- [ ] `scenes/entities/projectile.tscn` - Proyectil
  - Raíz: `Area2D`
  - Nodos hijos:
    - `Sprite2D` (sprite pequeño, ej: círculo amarillo)
    - `CollisionShape2D` (pequeño)
  - Script: `projectile.gd`

### Prioridad Media - Enemigos
- [ ] `scenes/entities/enemy_fast.tscn`
  - Raíz: `CharacterBody2D`
  - Hijos:
    - `Sprite2D` (temporal: cuadrado rojo)
    - `CollisionShape2D`
    - `Area2D` llamado "Hitbox" con CollisionShape2D
    - `ProgressBar` llamado "HealthBar" (arriba del enemigo)
  - Agregar a grupo: "enemies"
  - Script: `enemy_fast.gd`

- [ ] `scenes/entities/enemy_normal.tscn`
  - Similar a enemy_fast, pero sprite azul
  - Script: `enemy_normal.gd`

- [ ] `scenes/entities/enemy_tank.tscn`
  - Similar a enemy_fast, pero sprite verde y más grande
  - Script: `enemy_tank.gd`

- [ ] `scenes/entities/xp_gem.tscn`
  - Raíz: `Area2D`
  - Hijos:
    - `Sprite2D` (gema brillante, o círculo verde)
    - `CollisionShape2D`
  - Agregar a grupo: "xp_gem"
  - Script: `xp_gem.gd`

### Prioridad Media - UI
- [ ] `scenes/menus/main_menu.tscn`
  - Raíz: `Control`
  - Layout:
    - `VBoxContainer`
      - `Label` para título "Arena Survival"
      - `Button` llamado "StartButton" (texto: "Iniciar Juego")
      - `Button` llamado "QuitButton" (texto: "Salir")
  - Script: `main_menu.gd`

- [ ] `scenes/ui/hud.tscn`
  - Raíz: `CanvasLayer`
  - Layout:
    - `MarginContainer`
      - `VBoxContainer`
        - `HBoxContainer` llamado "TopStats"
          - `Label` llamado "LevelLabel"
          - `Label` llamado "TimeLabel"
          - `Label` llamado "KillsLabel"
        - `ProgressBar` llamado "HealthBar" con Label hijo
        - `ProgressBar` llamado "XPBar"
  - Script: `hud.gd`

- [ ] `scenes/ui/pause_menu.tscn`
  - Raíz: `CanvasLayer`
  - Hijos:
    - `Panel` (centro de pantalla)
      - `VBoxContainer`
        - `Label` (texto: "PAUSA")
        - `Button` llamado "ResumeButton"
        - `Button` llamado "MenuButton"
  - Script: `pause_menu.gd`

- [ ] `scenes/ui/game_over_menu.tscn`
  - Similar a pause_menu
  - Botones: RestartButton, MenuButton
  - Label para stats
  - Script: `game_over_menu.gd`

- [ ] `scenes/ui/upgrade_menu.tscn`
  - Raíz: `CanvasLayer`
  - Hijos:
    - `Panel`
      - `VBoxContainer`
        - `Label` llamado "TitleLabel" (texto: "¡Subiste de Nivel!")
        - `HBoxContainer` llamado "UpgradeContainer"
  - Script: `upgrade_menu.gd`

- [ ] `scenes/ui/upgrade_button.tscn`
  - Raíz: `Button`
  - Hijos:
    - `VBoxContainer`
      - `Label` llamado "UpgradeName"
      - `Label` llamado "UpgradeDescription"
  - Script: `upgrade_button.gd`

## 📦 Tareas de Assets

### Sprites Necesarios
- [ ] Jugador (32x32 o 64x64 px)
- [ ] Enemigo rápido (sprite base 32x32)
- [ ] Enemigo normal (sprite base 32x32)
- [ ] Enemigo tanque (sprite base 48x48)
- [ ] Proyectil (16x16 px)
- [ ] Gema de XP (16x16 px)
- [ ] Background/tileset para el mapa
- [ ] Iconos para upgrades (32x32 cada uno):
  - health.png
  - speed.png
  - damage.png
  - attack_speed.png
  - magnet.png
  - armor.png

### Audio Necesario
- [ ] BGM (música de fondo en loop)
- [ ] SFX:
  - shoot.wav (disparo)
  - hit.wav (golpe a enemigo)
  - player_hurt.wav (jugador recibe daño)
  - level_up.wav (subida de nivel)
  - pickup_xp.wav (recoger XP)
  - button_click.wav (click en UI)

### Fuentes
- [ ] Agregar fuente personalizada (.ttf o .otf)
- [ ] Aplicar en Theme de proyecto o en cada Label

## ⚙️ Configuración de Godot

### Autoload (Singleton)
1. Abrir: Project > Project Settings > Autoload
2. Click en icono de carpeta
3. Seleccionar `scripts/game_manager.gd`
4. Node Name: "GameManager"
5. Click "Add"

### Verificar Input Map
- Project > Project Settings > Input Map
- Debería estar configurado automáticamente desde project.godot
- Verificar: move_left, move_right, move_up, move_down, pause

### Verificar Layers
- Project > Project Settings > Layer Names > 2D Physics
- Layer 1: Player
- Layer 2: Enemy
- Layer 3: Projectile
- Layer 4: Pickup

## 🎯 Plan de Trabajo por Miembro

### Miembro 1: Jugador y Combate
1. Crear `player.tscn` con todos sus nodos
2. Crear `projectile.tscn`
3. Buscar/crear sprites temporales
4. Testear movimiento y disparo
5. Ajustar velocidades y rangos

### Miembro 2: Enemigos
1. Crear las 3 escenas de enemigos
2. Crear `xp_gem.tscn`
3. Buscar/crear sprites para enemigos
4. Testear spawn y comportamiento
5. Ajustar balance (vida, velocidad, daño)

### Miembro 3: Nivel y Sistema de Juego
1. Crear `game_world.tscn`
2. Configurar spawning de enemigos
3. Agregar background/tilemap
4. Configurar camera
5. Testear progresión de dificultad

### Miembro 4: Interfaz de Usuario
1. Crear todas las escenas de UI
2. Aplicar fuente personalizada
3. Diseñar layout de menús
4. Testear flujo completo de UI
5. Agregar iconos de upgrades

### Miembro 5: Audio y Pulido
1. Buscar/crear archivos de audio
2. Integrar audio en escenas apropiadas
3. Agregar AudioStreamPlayer nodes donde sea necesario
4. Testing completo del juego
5. Corrección de bugs y balance final

## 📝 Checklist de Testing

Antes de considerar el proyecto completo:
- [ ] El juego inicia desde el menú principal
- [ ] El jugador se mueve correctamente
- [ ] Los proyectiles se disparan automáticamente
- [ ] Los 3 tipos de enemigos aparecen y atacan
- [ ] El jugador puede morir (game over funciona)
- [ ] El XP se recolecta correctamente
- [ ] El sistema de niveles funciona
- [ ] El menú de mejoras aparece al subir de nivel
- [ ] Las 6 mejoras funcionan correctamente
- [ ] El menú de pausa funciona (ESC)
- [ ] La música y SFX suenan correctamente
- [ ] Las fuentes personalizadas se muestran
- [ ] No hay errores en la consola de Godot
- [ ] La dificultad aumenta con el tiempo
- [ ] El game over muestra estadísticas correctas

## 🚀 Entregable Final

Asegúrense de incluir:
1. Repositorio Git con historial de commits de todos los miembros
2. README.md completo y actualizado
3. Juego completamente funcional
4. Todos los assets necesarios
5. Documentación de cómo ejecutar el proyecto
6. (Opcional) Video demo del gameplay

## 💡 Recursos Recomendados

### Assets Gratis
- OpenGameArt.org
- itch.io (Free Assets)
- Kenney.nl (assets 2D gratis)

### Audio
- Freesound.org
- Incompetech.com (música)
- Zapsplat.com

### Fuentes
- Google Fonts
- Dafont.com
- FontSquirrel.com

### Tutoriales
- Documentación oficial de Godot
- YouTube: GDQuest, Brackeys (Godot)
- Reddit: r/godot
