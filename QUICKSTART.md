# Guía Rápida de Inicio - Arena Survival Roguelite

## 🎯 Primeros Pasos (15 minutos)

### 1. Configurar el Singleton (GameManager)
Esto es CRÍTICO y debe hacerse primero:

1. Abre Godot Engine
2. Importa el proyecto (selecciona `project.godot`)
3. Ve a: **Project > Project Settings > Autoload**
4. Click en el ícono de carpeta junto a "Path"
5. Navega a `scripts/game_manager.gd` y selecciónalo
6. En "Node Name" escribe: `GameManager`
7. Click en "Add"
8. Cierra Project Settings

✅ **Verificación**: Deberías ver "GameManager" en la lista de Autoload

---

## 🎮 Crear Tu Primera Escena de Prueba (30 minutos)

### Opción A: Escena de Prueba Simple

Crea `test_scene.tscn` para probar rápidamente:

1. **Scene > New Scene**
2. Selecciona "2D Scene" (Node2D)
3. Guárdala como `scenes/test_scene.tscn`

4. **Agregar Jugador Temporal**:
   - Click derecho en la raíz > Add Child Node
   - Busca `CharacterBody2D`, agrégalo
   - Renómbralo a "Player"
   - Agrégale hijos:
     - `Sprite2D` (click en Texture > New ImageTexture > crea un cuadrado de 64x64)
     - `CollisionShape2D` (Inspector > Shape > New RectangleShape2D)
   - En Inspector del Player, busca "Groups" y agrégalo al grupo "player"
   - Asigna el script: en Inspector > Script > Load > `scripts/player.gd`

5. **Configurar Sprite2D**:
   - Selecciona el Sprite2D
   - En Inspector > Texture > Click > "New ImageTexture"
   - O más fácil: Click en "Texture" > "Edit" > Canvas > Draw > dibuja un cuadrado
   - Color: cualquiera (ej: azul para el jugador)

6. **Configurar CollisionShape2D**:
   - Selecciona el CollisionShape2D
   - En Inspector > Shape > Click > "New RectangleShape2D"
   - Ajusta el tamaño en la vista 2D arrastrando los bordes

7. **Guardar y Probar**:
   - Ctrl+S para guardar
   - F5 para ejecutar
   - Deberías poder mover el jugador con WASD

---

## 📦 Estructura Mínima para Empezar a Testear

### Crear en este orden:

#### 1. Player Scene (`scenes/entities/player.tscn`)
```
Player (CharacterBody2D) [script: player.gd, grupo: "player"]
├── Sprite2D (color azul, 64x64)
├── CollisionShape2D (RectangleShape2D)
├── WeaponPivot (Node2D) - posición: (32, 0)
│   └── Sprite2D (pequeño, color gris, representando arma)
├── AttackTimer (Timer) [Wait Time: 1.0, Autostart: true]
├── AnimationPlayer
├── Hurtbox (Area2D)
│   └── CollisionShape2D (CircleShape2D, radio: 30)
└── PickupArea (Area2D)
    └── CollisionShape2D (CircleShape2D, radio: 100)
```

**Configuración importante**:
- Hurtbox: En Inspector > Collision > Layer: desmarcar todo, Mask: marcar layer 2 (Enemy)
- PickupArea: Layer: desmarcar todo, Mask: marcar layer 4 (Pickup)

#### 2. Projectile Scene (`scenes/entities/projectile.tscn`)
```
Projectile (Area2D) [script: projectile.gd]
├── Sprite2D (círculo amarillo, 16x16)
└── CollisionShape2D (CircleShape2D, radio: 8)
```

**Configuración**:
- Layer: 3 (Projectile)
- Mask: 2 (Enemy)

#### 3. Enemy Scene (`scenes/entities/enemy_normal.tscn`)
```
EnemyNormal (CharacterBody2D) [script: enemy_normal.gd, grupo: "enemies"]
├── Sprite2D (cuadrado azul, 32x32)
├── CollisionShape2D (RectangleShape2D)
├── Hitbox (Area2D)
│   └── CollisionShape2D (RectangleShape2D)
└── HealthBar (ProgressBar)
```

**Configuración**:
- CharacterBody2D: Layer: 2 (Enemy)
- Hitbox: Layer: 2, Mask: 3 (para detectar proyectiles)
- HealthBar: Anchors: Center Top, posición Y: -40

#### 4. XP Gem Scene (`scenes/entities/xp_gem.tscn`)
```
XPGem (Area2D) [script: xp_gem.gd, grupo: "xp_gem"]
├── Sprite2D (círculo verde brillante, 16x16)
└── CollisionShape2D (CircleShape2D, radio: 8)
```

**Configuración**:
- Layer: 4 (Pickup)
- Mask: 1 (Player)

---

## 🌍 Scene Principal del Juego

#### Game World (`scenes/game_world.tscn`)
```
GameWorld (Node2D) [script: game_world.gd]
├── ColorRect (fondo, tamaño: 5000x5000, centro en 0,0, color oscuro)
├── Player (instancia de player.tscn)
├── Camera2D (hijo de Player o hermano que lo siga)
│   [Enabled: true, Position Smoothing: true]
├── SpawnTimer (Timer) [Wait Time: 2.0, Autostart: true]
├── UI (CanvasLayer)
│   ├── HUD (instancia de hud.tscn)
│   ├── PauseMenu (instancia de pause_menu.tscn)
│   ├── GameOverMenu (instancia de game_over_menu.tscn)
│   └── UpgradeMenu (instancia de upgrade_menu.tscn)
```

**En el Inspector de GameWorld**:
- Enemy Fast Scene: cargar `enemy_fast.tscn`
- Enemy Normal Scene: cargar `enemy_normal.tscn`
- Enemy Tank Scene: cargar `enemy_tank.tscn`

---

## 🎨 UI Básica

### HUD (`scenes/ui/hud.tscn`)
```
HUD (CanvasLayer) [script: hud.gd]
└── MarginContainer [Margins: 10 en todos lados]
    └── VBoxContainer
        ├── TopStats (HBoxContainer)
        │   ├── LevelLabel (Label) [Text: "Nivel: 1"]
        │   ├── Spacer (Control, Size Flags: Expand)
        │   ├── TimeLabel (Label) [Text: "Tiempo: 00:00"]
        │   ├── Spacer (Control)
        │   └── KillsLabel (Label) [Text: "Kills: 0"]
        ├── HealthBar (ProgressBar) [Max Value: 100, Value: 100]
        │   └── Label [Text: "100 / 100", Anchors: Center]
        └── XPBar (ProgressBar) [Max Value: 10, Value: 0]
```

### Main Menu (`scenes/menus/main_menu.tscn`)
```
MainMenu (Control) [script: main_menu.gd, Anchors: Full Rect]
└── VBoxContainer [Alignment: Center, Anchors: Center]
    ├── TitleLabel (Label) [Text: "ARENA SURVIVAL", Font Size: 48]
    ├── Spacer (Control, Custom Minimum Size Y: 50)
    ├── StartButton (Button) [Text: "Iniciar Juego"]
    └── QuitButton (Button) [Text: "Salir"]
```

---

## ✅ Checklist de Configuración Inicial

- [ ] GameManager configurado como Autoload
- [ ] Input Map verificado (WASD, ESC)
- [ ] Layers de física configuradas
- [ ] Player.tscn creado y funcional
- [ ] Projectile.tscn creado
- [ ] Al menos 1 tipo de enemigo creado
- [ ] XP Gem creado
- [ ] Game World creado con spawning
- [ ] HUD básico creado
- [ ] Main Menu creado

---

## 🐛 Solución de Problemas Comunes

### El jugador no se mueve
- ✓ Verifica que el script esté asignado
- ✓ Verifica que GameManager esté en Autoload
- ✓ Verifica Input Map en Project Settings

### Los proyectiles no se disparan
- ✓ Verifica que `projectile.tscn` esté en `res://scenes/entities/projectile.tscn`
- ✓ Verifica que AttackTimer tenga Autostart = true
- ✓ Verifica que haya enemigos en la escena

### Los enemigos no aparecen
- ✓ Verifica que las escenas de enemigos estén asignadas en GameWorld Inspector
- ✓ Verifica que SpawnTimer tenga Autostart = true
- ✓ Verifica que el script game_world.gd esté asignado

### Colisiones no funcionan
- ✓ Verifica las capas de física (Layer y Mask)
- ✓ Asegúrate de que los CollisionShape2D tengan una forma asignada

### Script no se asigna / errores
- ✓ Asegúrate de que GameManager esté configurado como Autoload PRIMERO
- ✓ Reinicia Godot después de configurar Autoload
- ✓ Verifica que no haya errores de sintaxis en los scripts

---

## 🚀 Siguiente Nivel

Una vez que tengas lo básico funcionando:
1. Copia `enemy_normal.tscn` para crear `enemy_fast.tscn` y `enemy_tank.tscn`
2. Cambia los scripts y ajusta los sprites/colores
3. Crea las escenas de UI restantes (pause, game over, upgrade menu)
4. Agrega sprites reales en lugar de formas de colores
5. Agrega audio
6. ¡Balancea y pule!

---

## 💡 Consejos Pro

- **Usa Ctrl+D** para duplicar nodos rápidamente
- **Usa Ctrl+Shift+S** para "Save As" al crear variantes de escenas
- **F6** para ejecutar la escena actual (sin cambiar la escena principal)
- **F5** para ejecutar el proyecto completo
- **Ctrl+Z** es tu amigo
- Guarda frecuentemente (Ctrl+S)

---

¿Listo para empezar? ¡Abre Godot y comienza con el paso 1! 🎮
