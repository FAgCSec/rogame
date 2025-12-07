# 🎬 Guía Visual de Creación de Escenas

## 📝 Convenciones de Nombres

- **Escenas**: `snake_case.tscn` (ej: `player.tscn`)
- **Scripts**: `snake_case.gd` (ej: `player.gd`)
- **Nodos en escena**: `PascalCase` (ej: `PlayerSprite`, `AttackTimer`)
- **Variables en código**: `snake_case` (ej: `max_health`, `move_speed`)

---

## 🎮 Escena 1: Player (PRIORIDAD MÁXIMA)

### Estructura de Nodos
```
Player (CharacterBody2D) ← Raíz
├── Sprite2D
├── CollisionShape2D
├── WeaponPivot (Node2D)
│   └── WeaponSprite (Sprite2D)
├── AttackTimer (Timer)
├── AnimationPlayer
├── Hurtbox (Area2D)
│   └── CollisionShape2D
└── PickupArea (Area2D)
    └── CollisionShape2D
```

### Paso a Paso Detallado

#### 1. Crear la Escena
```
Scene > New Scene > 2D Scene
Click derecho en Node2D > Change Type > CharacterBody2D
Rename a "Player"
Ctrl+S > Guardar como: res://scenes/entities/player.tscn
```

#### 2. Agregar Sprite2D
```
Click derecho en Player > Add Child Node > Buscar "Sprite2D"
Seleccionar Sprite2D en el árbol de nodos
```

**Opción A - Sprite Temporal (Para empezar rápido)**:
```
En Inspector > Texture > Click dropdown
> New ImageTexture
> Create
> Width: 64, Height: 64
> Usar herramienta de dibujo para pintar un cuadrado azul
```

**Opción B - Sprite Real**:
```
En Inspector > Texture > Load
Navegar a assets/sprites/player.png
```

#### 3. Agregar CollisionShape2D
```
Click derecho en Player > Add Child Node > "CollisionShape2D"
En Inspector > Shape > New RectangleShape2D (o CircleShape2D)
Ajustar tamaño en la vista 2D (arrastrando los puntos naranjas)
```

💡 **Tip**: La forma debe cubrir el sprite sin sobresalir mucho

#### 4. Agregar WeaponPivot
```
Click derecho en Player > Add Child Node > "Node2D"
Rename a "WeaponPivot"
En Inspector > Transform > Position: X = 32, Y = 0
(Para que esté al lado del jugador)
```

##### 4.1 Agregar arma visual (opcional)
```
Click derecho en WeaponPivot > Add Child Node > "Sprite2D"
Rename a "WeaponSprite"
Crear sprite temporal pequeño (16x16, color gris)
O usar un punto para visualizar la dirección
```

#### 5. Agregar AttackTimer
```
Click derecho en Player > Add Child Node > "Timer"
Rename a "AttackTimer"
En Inspector:
  Wait Time: 1.0
  One Shot: false (desmarcar)
  Autostart: true (marcar) ← IMPORTANTE
```

#### 6. Agregar AnimationPlayer
```
Click derecho en Player > Add Child Node > "AnimationPlayer"
(Opcional para ahora, se puede configurar después)
```

#### 7. Agregar Hurtbox (Detecta daño al jugador)
```
Click derecho en Player > Add Child Node > "Area2D"
Rename a "Hurtbox"

Click derecho en Hurtbox > Add Child Node > "CollisionShape2D"
En Inspector > Shape > New CircleShape2D
Radius: 30 (ajustar según sprite)

Seleccionar Hurtbox en el árbol
En Inspector > Collision:
  Layer: DESMARCAR Layer 1 (desactivar todo)
  Mask: MARCAR solo Layer 2 (Enemy)
```

#### 8. Agregar PickupArea (Recoge XP)
```
Click derecho en Player > Add Child Node > "Area2D"
Rename a "PickupArea"

Click derecho en PickupArea > Add Child Node > "CollisionShape2D"
En Inspector > Shape > New CircleShape2D
Radius: 100 (grande para recoger XP)

Seleccionar PickupArea
En Inspector > Collision:
  Layer: DESMARCAR Layer 1 (desactivar todo)
  Mask: MARCAR solo Layer 4 (Pickup)
  
En Inspector > Monitoring: true
En Inspector > Monitorable: false
```

#### 9. Configurar Physics del Player
```
Seleccionar el nodo raíz "Player"
En Inspector > Collision:
  Layer: MARCAR solo Layer 1 (Player)
  Mask: MARCAR Layer 2 (Enemy) - para no atravesar enemigos
```

#### 10. Asignar Script
```
Seleccionar el nodo raíz "Player"
En Inspector > Script > Load
Buscar: scripts/player.gd
Abrir
```

#### 11. Agregar a Grupo
```
Seleccionar el nodo raíz "Player"
En el panel derecho > Tab "Node" (junto a Inspector)
Groups > Escribir: "player"
Click "Add"
```

#### 12. Guardar
```
Ctrl+S o File > Save Scene
```

### ✅ Verificación

Tu escena debería verse así en el árbol:
```
[CharacterBody2D] Player  ← Script asignado, grupo "player"
├── [Sprite2D] Sprite2D  ← Texture asignado (azul)
├── [CollisionShape2D] CollisionShape2D  ← Shape asignado
├── [Node2D] WeaponPivot  ← Posición offset
│   └── [Sprite2D] WeaponSprite (opcional)
├── [Timer] AttackTimer  ← Autostart: ON, Wait: 1.0
├── [AnimationPlayer] AnimationPlayer
├── [Area2D] Hurtbox  ← Mask: Layer 2
│   └── [CollisionShape2D] CollisionShape2D  ← Circle
└── [Area2D] PickupArea  ← Mask: Layer 4
    └── [CollisionShape2D] CollisionShape2D  ← Circle grande
```

---

## 💥 Escena 2: Projectile

### Estructura
```
Projectile (Area2D)
├── Sprite2D
└── CollisionShape2D
```

### Paso a Paso

#### 1. Crear Escena
```
Scene > New Scene > 2D Scene
Change Type > Area2D
Rename a "Projectile"
Save: res://scenes/entities/projectile.tscn
```

#### 2. Sprite2D
```
Add Child Node > Sprite2D
Crear ImageTexture 16x16, color amarillo/naranja
(O un círculo pequeño)
```

#### 3. CollisionShape2D
```
Add Child Node > CollisionShape2D
Shape > New CircleShape2D
Radius: 8
```

#### 4. Configurar Collision
```
Seleccionar Projectile (raíz)
Inspector > Collision:
  Layer: MARCAR Layer 3 (Projectile)
  Mask: MARCAR Layer 2 (Enemy)
```

#### 5. Script
```
Script > Load > projectile.gd
```

#### 6. Guardar
```
Ctrl+S
```

---

## 👾 Escena 3: Enemy Normal

### Estructura
```
EnemyNormal (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D
├── Hitbox (Area2D)
│   └── CollisionShape2D
└── HealthBar (ProgressBar)
```

### Paso a Paso

#### 1. Crear
```
Scene > New Scene > 2D Scene
Change Type > CharacterBody2D
Rename a "EnemyNormal"
Save: res://scenes/entities/enemy_normal.tscn
```

#### 2. Sprite2D
```
Add Child > Sprite2D
ImageTexture 32x32, color azul/cyan
```

#### 3. CollisionShape2D
```
Add Child > CollisionShape2D
Shape > RectangleShape2D
Ajustar al sprite
```

#### 4. Hitbox
```
Add Child > Area2D
Rename: "Hitbox"

Add Child (de Hitbox) > CollisionShape2D
Shape > RectangleShape2D (igual que el otro)

Seleccionar Hitbox:
Inspector > Collision:
  Layer: MARCAR Layer 2 (Enemy)
  Mask: MARCAR Layer 3 (Projectile)
```

#### 5. HealthBar
```
Add Child > ProgressBar
Rename: "HealthBar"

Inspector:
  Min Value: 0
  Max Value: 40 (vida del enemigo)
  Value: 40
  Show Percentage: false
  
Transform > Position: Y = -40 (arriba del enemigo)
Transform > Size: X = 32, Y = 4

Control > Layout > Top Center
```

#### 6. Configurar EnemyNormal
```
Seleccionar EnemyNormal (raíz):
Collision:
  Layer: MARCAR Layer 2 (Enemy)
  Mask: MARCAR Layer 1 (Player)

Node tab > Groups > "enemies" > Add

Script > Load > enemy_normal.gd
```

#### 7. Guardar

---

## 💎 Escena 4: XP Gem

### Estructura
```
XPGem (Area2D)
├── Sprite2D
└── CollisionShape2D
```

### Paso a Paso

```
New Scene > 2D Scene
Change Type > Area2D > "XPGem"
Save: res://scenes/entities/xp_gem.tscn

Add Child > Sprite2D
  ImageTexture 16x16, color verde brillante (#00FF00)

Add Child > CollisionShape2D
  Shape > CircleShape2D, Radius: 8

XPGem (raíz):
  Collision:
    Layer: MARCAR Layer 4 (Pickup)
    Mask: MARCAR Layer 1 (Player)
  
  Groups: "xp_gem"
  Script: xp_gem.gd

Guardar
```

---

## 🌍 Escena 5: Game World (Nivel Principal)

### Estructura
```
GameWorld (Node2D)
├── Background (ColorRect o Sprite2D)
├── Player (Instancia)
├── Camera2D
├── SpawnTimer (Timer)
└── UI (CanvasLayer)
    ├── HUD (Instancia - cuando la crees)
    ├── PauseMenu (Instancia - cuando la crees)
    ├── GameOverMenu (Instancia - cuando la crees)
    └── UpgradeMenu (Instancia - cuando la crees)
```

### Paso a Paso

#### 1. Crear
```
New Scene > 2D Scene
Keep "Node2D"
Rename: "GameWorld"
Save: res://scenes/game_world.tscn
```

#### 2. Background
```
Add Child > ColorRect
Rename: "Background"

Inspector:
  Color: #1a1a2e (azul oscuro) o el que prefieras
  
Layout > Full Rect (expandir a toda la pantalla)
O manualmente:
  Position: -2500, -2500
  Size: 5000, 5000
  (Para que el mapa sea grande)
  
Mover "Background" al tope del árbol (arrastrarlo arriba)
para que esté detrás de todo
```

#### 3. Instanciar Player
```
En el FileSystem, buscar: scenes/entities/player.tscn
Arrastrar al árbol de nodos (sobre GameWorld)

Se creará un nodo "Player" con ícono de cadena (instancia)

Posicionarlo en el centro: Position (0, 0)
```

#### 4. Camera2D
```
Opción A - Como hijo del Player (recomendado):
  Click derecho en Player (en game_world) > Add Child Node > Camera2D
  
Opción B - Como hermano del Player:
  Add Child (de GameWorld) > Camera2D
  Agregar script simple para seguir al jugador

Configurar Camera:
  Inspector > Enabled: true (marcar)
  Position Smoothing > Enabled: true
  Position Smoothing > Speed: 5.0
```

#### 5. SpawnTimer
```
Add Child (de GameWorld) > Timer
Rename: "SpawnTimer"

Inspector:
  Wait Time: 2.0
  One Shot: false (desmarcar)
  Autostart: true (marcar)
```

#### 6. UI Container
```
Add Child > CanvasLayer
Rename: "UI"

(Los menús se instanciarán aquí después)
```

#### 7. Asignar Script y Referencias
```
Seleccionar GameWorld (raíz)
Script > Load > game_world.gd

Inspector > Script Variables (aparecerán las @export):
  Enemy Fast Scene: Click 📁 > scenes/entities/enemy_fast.tscn
  Enemy Normal Scene: Click 📁 > scenes/entities/enemy_normal.tscn
  Enemy Tank Scene: Click 📁 > scenes/entities/enemy_tank.tscn
  
(Estas escenas las crearás después, por ahora déjalas vacías)
```

#### 8. Configurar como Escena Principal (Opcional para testing)
```
Project > Project Settings > Application > Run
Main Scene: res://scenes/game_world.tscn
```

---

## 🎨 Escena 6: Main Menu

### Estructura
```
MainMenu (Control)
└── VBoxContainer
    ├── TitleLabel (Label)
    ├── Spacer (Control)
    ├── StartButton (Button)
    └── QuitButton (Button)
```

### Paso a Paso

#### 1. Crear
```
New Scene > User Interface
Ya viene con Control de raíz
Rename: "MainMenu"
Save: res://scenes/menus/main_menu.tscn
```

#### 2. Configurar MainMenu
```
Seleccionar MainMenu (raíz)
Inspector > Layout > Full Rect (para llenar pantalla)
```

#### 3. VBoxContainer
```
Add Child > VBoxContainer

Inspector > Layout > Center (para centrar en pantalla)
Transform > Size: 400 x 300 (aprox)

Theme Overrides > Constants > Separation: 20
```

#### 4. TitleLabel
```
Add Child (de VBoxContainer) > Label
Rename: "TitleLabel"

Inspector:
  Text: "ARENA SURVIVAL"
  Horizontal Alignment: Center
  
Theme Overrides > Font Sizes > Font Size: 48

(Si ya tienes fuente personalizada):
  Theme Overrides > Fonts > Font > Load tu .ttf
```

#### 5. Spacer
```
Add Child > Control
Rename: "Spacer"

Inspector:
  Custom Minimum Size > Y: 50
  Size Flags > Vertical: Expand
```

#### 6. StartButton
```
Add Child > Button
Rename: "StartButton"

Inspector:
  Text: "Iniciar Juego"
  Custom Minimum Size > Y: 60
```

#### 7. QuitButton
```
Add Child > Button
Rename: "QuitButton"

Inspector:
  Text: "Salir"
  Custom Minimum Size > Y: 60
```

#### 8. Script
```
Seleccionar MainMenu (raíz)
Script > Load > main_menu.gd
```

#### 9. Configurar como Escena Principal
```
Project > Project Settings > Application > Run
Main Scene: res://scenes/menus/main_menu.tscn
```

---

## 📊 Escena 7: HUD (Básico)

### Estructura Simplificada
```
HUD (CanvasLayer)
└── MarginContainer
    └── VBoxContainer
        ├── TopStats (HBoxContainer)
        │   ├── LevelLabel
        │   ├── TimeLabel
        │   └── KillsLabel
        ├── HealthBar (ProgressBar)
        │   └── Label
        └── XPBar (ProgressBar)
```

### Paso a Paso Rápido

```
New Scene > User Interface > Change Type > CanvasLayer
Rename: "HUD"
Save: res://scenes/ui/hud.tscn

Add Child > MarginContainer
  Theme Overrides > Constants > All margins: 10

Add Child (de Margin) > VBoxContainer
  Separation: 5

Add Child (de VBox) > HBoxContainer
Rename: "TopStats"
  Add 3 Labels: LevelLabel, TimeLabel, KillsLabel
  Text: "Nivel: 1", "Tiempo: 00:00", "Kills: 0"

Add Child (de VBox) > ProgressBar
Rename: "HealthBar"
  Max Value: 100, Value: 100
  Show Percentage: false
  Add Child > Label (centrado)
    Text: "100 / 100"
    Layout: Center

Add Child (de VBox) > ProgressBar
Rename: "XPBar"
  Max Value: 10, Value: 0
  Show Percentage: false

Script > Load > hud.gd
Guardar
```

---

## ✅ Testing Rápido

### Probar Player Solo
```
1. Abrir player.tscn
2. F6 (Run Current Scene)
3. Debería moverse con WASD
   (Aunque no haya enemigos aún)
```

### Probar Game World
```
1. Abrir game_world.tscn
2. F6 (Run Current Scene)
3. El jugador debería aparecer y moverse
4. La cámara lo debería seguir
5. (Los enemigos no aparecerán hasta que crees sus escenas)
```

### Probar Main Menu
```
1. Abrir main_menu.tscn
2. F6
3. Debería verse el menú
4. Los botones aún no funcionan (esperan que game_world exista)
```

---

## 💡 Tips Importantes

### Layers de Física - MEMORIZA ESTO
```
Layer 1 = Player      (Jugador)
Layer 2 = Enemy       (Enemigos)
Layer 3 = Projectile  (Proyectiles)
Layer 4 = Pickup      (Items recolectables)

LAYER = "Yo soy de este tipo"
MASK = "Puedo chocar/detectar estos tipos"
```

### Ejemplo Práctico
```
Projectile:
  Layer: 3 (soy un proyectil)
  Mask: 2 (detecto enemigos)
  
Enemy:
  Layer: 2 (soy un enemigo)
  Mask: 1 y 3 (detecto jugador y proyectiles)
```

### Instanciar Escenas
```
Para usar una escena dentro de otra:
1. Arrastra el .tscn del FileSystem al árbol de nodos
   O
2. Click derecho > Instance Child Scene

El nodo tendrá un ícono de cadena (link) indicando que es una instancia
```

### Guardar Frecuentemente
```
Ctrl+S después de cada cambio importante
Godot puede crashear (raramente)
```

### Ver Colisiones
```
En el editor 2D, arriba:
  Debug > Visible Collision Shapes
  
Esto muestra las áreas de colisión en azul/rojo
```

---

## 🎯 Orden Recomendado de Creación

1. ✅ **Player.tscn** - PRIMERO, para poder moverte
2. ✅ **Projectile.tscn** - Para testear ataque
3. ✅ **Enemy_normal.tscn** - Un enemigo básico
4. ✅ **XP_gem.tscn** - Para recoger XP
5. ✅ **Game_world.tscn** - Juntar todo
6. 📋 **Enemy_fast/tank.tscn** - Duplicar normal y ajustar
7. 🎨 **Main_menu.tscn** - Punto de entrada
8. 📊 **HUD.tscn** - Interfaz de juego
9. ⏸️ **Pause/GameOver/Upgrade menus** - Últimos

---

## 🚀 Atajos de Teclado Útiles

```
Ctrl+S         Guardar escena
Ctrl+D         Duplicar nodo
Ctrl+Shift+D   Duplicar nodo con hijos
F5             Ejecutar proyecto
F6             Ejecutar escena actual
F8             Pausar ejecución (debugging)
Ctrl+Z         Deshacer
Ctrl+Shift+Z   Rehacer
Ctrl+A         Seleccionar todos (nodos/código)
```

---

**¡Ya estás listo para crear tus primeras escenas! 🎬✨**

Recuerda: Empieza simple (formas de colores), haz que funcione, luego mejora los gráficos.
