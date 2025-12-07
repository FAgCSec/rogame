# Arena Survival Roguelite

Un juego tipo Vampire Survivors desarrollado en Godot Engine como proyecto colaborativo.

> 📚 **NUEVO**: Para una navegación completa de toda la documentación, visita **[INDEX.md](INDEX.md)**

## 🎮 Descripción del Juego

Este es un juego de supervivencia en arena donde el jugador debe sobrevivir contra hordas masivas de enemigos. El personaje ataca automáticamente a los enemigos cercanos mientras el jugador se enfoca en el movimiento y la toma de decisiones estratégicas sobre las mejoras de habilidades.

## ✨ Características Implementadas

### Mecánicas Principales
- ✅ **Ataque Automático**: El personaje dispara automáticamente al enemigo más cercano
- ✅ **Movimiento Fluido**: Control WASD o flechas del teclado
- ✅ **Sistema de Supervivencia**: Aguanta el máximo tiempo posible contra hordas infinitas

### Sistema de Progresión
- ✅ **Sistema de Experiencia (XP)**: Gana XP eliminando enemigos
- ✅ **Subida de Nivel**: Cada nivel requiere más XP que el anterior
- ✅ **Menú de Evolución**: Elige entre 3 mejoras aleatorias al subir de nivel
- ✅ **6 Mejoras Diferentes**:
  - Vida Extra (+20 HP máximo)
  - Velocidad (+15% velocidad de movimiento)
  - Más Daño (+25% daño)
  - Ataque Rápido (+20% velocidad de ataque)
  - Imán de XP (+30% rango de recolección)
  - Armadura (+5 armadura)

### Enemigos (3 Tipos Distintos)
1. **Enemigo Rápido** (Rojo)
   - Velocidad alta, vida baja
   - 20 HP, 120 velocidad
   - Otorga 1 XP

2. **Enemigo Normal** (Azul)
   - Stats balanceadas
   - 40 HP, 80 velocidad
   - Otorga 2 XP

3. **Enemigo Tanque** (Verde)
   - Lento pero resistente
   - 80 HP, 50 velocidad
   - Otorga 3 XP

### Diseño de Nivel
- ✅ Mapa único con spawn infinito de enemigos
- ✅ Dificultad incremental (más enemigos con el tiempo)
- ✅ Sistema de spawn fuera de la pantalla

### Interfaz de Usuario (UI/UX)
- ✅ **HUD Completo**:
  - Barra de vida con contador
  - Barra de experiencia
  - Nivel actual
  - Temporizador de supervivencia
  - Contador de kills
- ✅ **Menú Principal**: Iniciar juego y salir
- ✅ **Menú de Pausa**: Reanudar o volver al menú (ESC)
- ✅ **Game Over**: Muestra estadísticas finales y opciones para reiniciar
- ✅ **Menú de Mejoras**: Selección de upgrades al subir de nivel

### Audio
- ✅ Sistema de audio implementado (BGM y SFX)
- ⚠️ Archivos de audio pendientes (se deben agregar en `assets/audio/`)

## 📁 Estructura del Proyecto

```
rogame/
├── project.godot              # Configuración principal de Godot
├── icon.svg                   # Icono del proyecto
├── scripts/
│   ├── game_manager.gd       # Singleton - Gestión global del juego
│   ├── player.gd             # Lógica del jugador
│   ├── projectile.gd         # Proyectiles de ataque
│   ├── enemy_base.gd         # Clase base de enemigos
│   ├── enemy_fast.gd         # Enemigo rápido
│   ├── enemy_normal.gd       # Enemigo normal
│   ├── enemy_tank.gd         # Enemigo tanque
│   ├── xp_gem.gd             # Gemas de experiencia
│   ├── game_world.gd         # Control del nivel y spawning
│   └── ui/
│       ├── hud.gd            # HUD del juego
│       ├── main_menu.gd      # Menú principal
│       ├── pause_menu.gd     # Menú de pausa
│       ├── game_over_menu.gd # Pantalla de game over
│       ├── upgrade_menu.gd   # Menú de mejoras
│       └── upgrade_button.gd # Botón de upgrade individual
├── scenes/
│   ├── game_world.tscn       # Escena principal del juego
│   ├── entities/
│   │   ├── player.tscn       # Escena del jugador
│   │   ├── projectile.tscn   # Escena del proyectil
│   │   ├── enemy_fast.tscn   # Escena enemigo rápido
│   │   ├── enemy_normal.tscn # Escena enemigo normal
│   │   ├── enemy_tank.tscn   # Escena enemigo tanque
│   │   └── xp_gem.tscn       # Escena gema XP
│   ├── menus/
│   │   └── main_menu.tscn    # Escena menú principal
│   └── ui/
│       ├── hud.tscn          # Escena HUD
│       ├── pause_menu.tscn   # Escena menú pausa
│       ├── game_over_menu.tscn # Escena game over
│       ├── upgrade_menu.tscn # Escena menú mejoras
│       └── upgrade_button.tscn # Escena botón upgrade
└── assets/
    ├── sprites/              # Sprites del juego
    ├── audio/
    │   ├── bgm/             # Música de fondo
    │   └── sfx/             # Efectos de sonido
    ├── fonts/               # Fuentes personalizadas
    └── icons/               # Iconos de UI
```

## 🚀 Cómo Ejecutar el Proyecto

1. **Instalar Godot Engine 4.3+**
   - Descarga desde: https://godotengine.org/

2. **Clonar el Repositorio**
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   cd rogame
   ```

3. **Abrir en Godot**
   - Abre Godot Engine
   - Click en "Importar"
   - Navega a la carpeta del proyecto
   - Selecciona `project.godot`

4. **Ejecutar el Juego**
   - Presiona F5 o click en el botón "Play"

## 🎯 Controles

- **WASD / Flechas**: Movimiento
- **ESC**: Pausa
- **Ataque**: Automático (no requiere input)
- **Selección de Mejoras**: Click del mouse

## 📋 Tareas Pendientes

Para completar el proyecto, cada miembro del equipo puede trabajar en:

### 1. Creación de Escenas en Godot (.tscn)
- [ ] Crear todas las escenas `.tscn` referenciadas en los scripts
- [ ] Configurar nodos y collision shapes
- [ ] Asignar scripts a las escenas

### 2. Assets Visuales
- [ ] Sprites para el jugador
- [ ] Sprites para los 3 tipos de enemigos
- [ ] Sprite para proyectiles
- [ ] Sprite para gemas de XP
- [ ] Iconos para las mejoras
- [ ] Background del nivel

### 3. Assets de Audio
- [ ] Música de fondo (BGM)
- [ ] Sonido de disparo
- [ ] Sonido de daño al jugador
- [ ] Sonido de muerte de enemigo
- [ ] Sonido de recolección de XP
- [ ] Sonido de subida de nivel
- [ ] Sonidos de UI (clicks, hover)

### 4. Fuentes Personalizadas
- [ ] Agregar fuente personalizada en `assets/fonts/`
- [ ] Aplicar a todos los textos de UI

### 5. Pulido y Balance
- [ ] Ajustar velocidades y stats de enemigos
- [ ] Balancear curva de dificultad
- [ ] Ajustar valores de XP
- [ ] Testear todas las mejoras

### 6. Features Adicionales (Opcional)
- [ ] Más tipos de armas/ataques
- [ ] Power-ups temporales
- [ ] Bosses cada cierto tiempo
- [ ] Múltiples mapas
- [ ] Sistema de logros

## 👥 Colaboración con Git

### Configuración Inicial
```bash
git init
git add .
git commit -m "Estructura inicial del proyecto"
git remote add origin [URL_DEL_REPOSITORIO]
git push -u origin main
```

### Flujo de Trabajo Recomendado
1. Crear una rama para cada feature:
   ```bash
   git checkout -b feature/nombre-feature
   ```

2. Hacer commits frecuentes:
   ```bash
   git add .
   git commit -m "Descripción clara del cambio"
   ```

3. Pushear cambios:
   ```bash
   git push origin feature/nombre-feature
   ```

4. Crear Pull Request en GitHub/GitLab para revisión

### División de Trabajo Sugerida
- **Miembro 1**: Sistema de jugador y ataque automático
- **Miembro 2**: Sistema de enemigos y spawning
- **Miembro 3**: Sistema de XP y progresión
- **Miembro 4**: UI/UX completa
- **Miembro 5**: Audio, assets visuales y pulido final

## 📝 Notas Importantes

- El proyecto usa **Godot 4.3+** (GDScript 2.0)
- Todas las escenas `.tscn` deben crearse en el editor de Godot
- Los scripts ya están completos y listos para usar
- El `GameManager` es un singleton (Autoload) que debe configurarse en Godot
- Se requiere configurar las capas de física en el proyecto

## 🔧 Configuración en Godot

### Autoload (Singleton)
1. Project > Project Settings > Autoload
2. Agregar `game_manager.gd` como "GameManager"

### Configuración de Input
Ya está configurado en `project.godot`:
- move_left, move_right, move_up, move_down
- pause (ESC)

### Capas de Física
Ya configuradas en `project.godot`:
1. Player
2. Enemy
3. Projectile
4. Pickup

## 📚 Recursos Útiles

- [Documentación de Godot](https://docs.godotengine.org/)
- [GDScript Básico](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
- [Tutoriales de Godot](https://docs.godotengine.org/en/stable/community/tutorials.html)

## 📄 Licencia

Proyecto académico - Electiva 6to Semestre ITP

---

**¡Buena suerte con el desarrollo! 🎮🚀**
