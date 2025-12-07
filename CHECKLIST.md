# ✅ Checklist de Inicio Rápido

## 📋 Para TODOS los Miembros del Equipo

### Paso 1: Instalación (30 minutos)
- [ ] Descargar e instalar **Godot Engine 4.3 o superior**
  - Link: https://godotengine.org/download
  - Versión: Standard (NO .NET)
  
- [ ] Descargar e instalar **Git**
  - Link: https://git-scm.com/download/win
  - Verificar: Abrir PowerShell y ejecutar `git --version`

- [ ] Crear cuenta en **GitHub** o **GitLab** (si no tienes)
  - GitHub: https://github.com/signup
  - GitLab: https://gitlab.com/users/sign_up

### Paso 2: Configurar Git (10 minutos)
Abrir PowerShell y ejecutar:
```powershell
git config --global user.name "Tu Nombre"
git config --global user.email "tu.email@example.com"
git config --list
```

- [ ] Git configurado con tu nombre
- [ ] Git configurado con tu email
- [ ] Verificaste que funciona (`git --version`)

### Paso 3: Clonar el Proyecto (5 minutos)

**El líder del equipo** debe primero:
```powershell
cd "C:\Users\User hp\Documents\ITP\6TO SEMESTRE\Electiva\rogame"
git init
git add .
git commit -m "Estructura inicial del proyecto Arena Survival Roguelite"
git branch -M main
# Crear repo en GitHub/GitLab primero, luego:
git remote add origin https://github.com/USUARIO/REPO.git
git push -u origin main
```

**Los demás miembros**:
```powershell
cd C:\Users\TuUsuario\Documents
git clone https://github.com/USUARIO/REPO.git
cd REPO
```

- [ ] Repositorio clonado exitosamente
- [ ] Puedes ver todos los archivos

### Paso 4: Abrir en Godot (5 minutos)
1. Abrir Godot Engine
2. Click en "Importar"
3. Buscar carpeta del proyecto
4. Seleccionar `project.godot`
5. Click "Importar y Editar"

- [ ] El proyecto abre sin errores
- [ ] Puedes ver la estructura de carpetas

### Paso 5: Configurar Autoload ⚠️ CRÍTICO (2 minutos)
1. En Godot: **Project > Project Settings**
2. Tab: **Autoload**
3. Path: Click en 📁 y navega a `scripts/game_manager.gd`
4. Node Name: `GameManager`
5. Click **Add**
6. Click **Close**

- [ ] GameManager aparece en la lista de Autoload
- [ ] Enabled está marcado

### Paso 6: Verificar Configuración (2 minutos)
1. **Project > Project Settings > Input Map**
   - [ ] Existe: move_left, move_right, move_up, move_down
   - [ ] Existe: pause

2. **Project > Project Settings > Layer Names > 2D Physics**
   - [ ] Layer 1: Player
   - [ ] Layer 2: Enemy
   - [ ] Layer 3: Projectile
   - [ ] Layer 4: Pickup

### Paso 7: Leer Documentación (15 minutos)
- [ ] Leí `README.md` completo
- [ ] Leí `PROJECT_SUMMARY.md`
- [ ] Leí `QUICKSTART.md`
- [ ] Revisé `TODO.md` para ver tareas disponibles

---

## 👥 División de Trabajo Recomendada

### 🎮 Miembro 1: Sistema de Jugador y Combate
**Tiempo estimado**: 3-4 horas

- [ ] Crear `scenes/entities/player.tscn` (Ver QUICKSTART.md)
  - [ ] Agregar todos los nodos necesarios
  - [ ] Configurar CollisionShapes
  - [ ] Asignar script `player.gd`
  - [ ] Agregar a grupo "player"
  
- [ ] Crear `scenes/entities/projectile.tscn`
  - [ ] Sprite temporal (círculo amarillo)
  - [ ] CollisionShape2D
  - [ ] Configurar layers de física
  - [ ] Asignar script `projectile.gd`

- [ ] Buscar/crear sprites:
  - [ ] `assets/sprites/player.png` (64x64)
  - [ ] `assets/sprites/projectile.png` (16x16)

- [ ] Testear:
  - [ ] El jugador se mueve con WASD
  - [ ] Dispara automáticamente al enemigo más cercano
  - [ ] Los proyectiles vuelan en la dirección correcta

**Branch**: `feature/player-system`

---

### 👾 Miembro 2: Sistema de Enemigos
**Tiempo estimado**: 3-4 horas

- [ ] Crear `scenes/entities/enemy_normal.tscn` (Ver QUICKSTART.md)
  - [ ] Configurar todos los nodos
  - [ ] Asignar script `enemy_normal.gd`
  - [ ] Agregar a grupo "enemies"

- [ ] Duplicar y adaptar para:
  - [ ] `enemy_fast.tscn` (script: `enemy_fast.gd`)
  - [ ] `enemy_tank.tscn` (script: `enemy_tank.gd`)

- [ ] Crear `scenes/entities/xp_gem.tscn`
  - [ ] Sprite de gema (círculo verde)
  - [ ] Asignar script `xp_gem.gd`
  - [ ] Agregar a grupo "xp_gem"

- [ ] Buscar/crear sprites:
  - [ ] `assets/sprites/enemy_fast.png` (rojo, 32x32)
  - [ ] `assets/sprites/enemy_normal.png` (azul, 32x32)
  - [ ] `assets/sprites/enemy_tank.png` (verde, 48x48)
  - [ ] `assets/sprites/xp_gem.png` (16x16)

- [ ] Testear:
  - [ ] Los enemigos se mueven hacia el jugador
  - [ ] Mueren al recibir daño
  - [ ] Sueltan gemas de XP
  - [ ] Los 3 tipos tienen comportamiento diferente

**Branch**: `feature/enemy-system`

---

### 🗺️ Miembro 3: Nivel Principal y Spawning
**Tiempo estimado**: 3-4 horas

- [ ] Crear `scenes/game_world.tscn` (Ver QUICKSTART.md)
  - [ ] Agregar background (ColorRect grande)
  - [ ] Instanciar Player
  - [ ] Agregar Camera2D (sigue al jugador)
  - [ ] Agregar SpawnTimer
  - [ ] Asignar script `game_world.gd`

- [ ] En Inspector de GameWorld, asignar:
  - [ ] Enemy Fast Scene: `enemy_fast.tscn`
  - [ ] Enemy Normal Scene: `enemy_normal.tscn`
  - [ ] Enemy Tank Scene: `enemy_tank.tscn`

- [ ] Crear background:
  - [ ] Usar ColorRect con color oscuro, O
  - [ ] Buscar/crear `assets/sprites/background.png`

- [ ] Testear:
  - [ ] Los enemigos aparecen automáticamente
  - [ ] Aparecen fuera de la pantalla
  - [ ] La cantidad aumenta con el tiempo
  - [ ] El gameplay se siente balanceado

**Branch**: `feature/game-world`

---

### 🎨 Miembro 4: Interfaz de Usuario
**Tiempo estimado**: 4-5 horas

- [ ] Crear `scenes/menus/main_menu.tscn` (Ver QUICKSTART.md)
  - [ ] Layout con botones
  - [ ] Asignar script `main_menu.gd`

- [ ] Crear `scenes/ui/hud.tscn`
  - [ ] Barras de vida y XP
  - [ ] Labels para stats
  - [ ] Asignar script `hud.gd`

- [ ] Crear `scenes/ui/pause_menu.tscn`
  - [ ] Panel con botones
  - [ ] Asignar script `pause_menu.gd`

- [ ] Crear `scenes/ui/game_over_menu.tscn`
  - [ ] Stats y botones
  - [ ] Asignar script `game_over_menu.gd`

- [ ] Crear `scenes/ui/upgrade_menu.tscn`
  - [ ] Container para opciones
  - [ ] Asignar script `upgrade_menu.gd`

- [ ] Crear `scenes/ui/upgrade_button.tscn`
  - [ ] Layout para cada opción
  - [ ] Asignar script `upgrade_button.gd`

- [ ] Descargar fuente:
  - [ ] Buscar en Google Fonts (ej: Press Start 2P)
  - [ ] Guardar en `assets/fonts/`
  - [ ] Aplicar a toda la UI

- [ ] Descargar iconos (game-icons.net):
  - [ ] `assets/icons/health.png`
  - [ ] `assets/icons/speed.png`
  - [ ] `assets/icons/damage.png`
  - [ ] `assets/icons/attack_speed.png`
  - [ ] `assets/icons/magnet.png`
  - [ ] `assets/icons/armor.png`

- [ ] Testear:
  - [ ] El menú principal funciona
  - [ ] El HUD muestra stats correctamente
  - [ ] El menú de pausa aparece con ESC
  - [ ] Game over aparece al morir
  - [ ] Menú de mejoras aparece al subir de nivel

**Branch**: `feature/ui-system`

---

### 🎵 Miembro 5: Audio y Pulido Final
**Tiempo estimado**: 3-4 horas

- [ ] Buscar/crear música (BGM):
  - [ ] `assets/audio/bgm/gameplay_music.ogg`
  - [ ] Formato .ogg, loop perfecto
  - [ ] Fuentes: Incompetech, OpenGameArt

- [ ] Buscar/crear efectos (SFX):
  - [ ] `assets/audio/sfx/shoot.wav`
  - [ ] `assets/audio/sfx/enemy_hit.wav`
  - [ ] `assets/audio/sfx/player_hurt.wav`
  - [ ] `assets/audio/sfx/xp_pickup.wav`
  - [ ] `assets/audio/sfx/level_up.wav`
  - [ ] `assets/audio/sfx/button_click.wav`
  - [ ] Fuentes: Freesound.org, Zapsplat

- [ ] Integrar audio en escenas:
  - [ ] Agregar AudioStreamPlayer nodes
  - [ ] Configurar autoplay para BGM
  - [ ] Conectar SFX con eventos

- [ ] Testing completo:
  - [ ] Usar checklist en `TESTING.md`
  - [ ] Probar todos los sistemas
  - [ ] Encontrar y reportar bugs
  - [ ] Ajustar balance de juego

- [ ] Pulido:
  - [ ] Verificar que no hay errores en consola
  - [ ] Ajustar volúmenes de audio
  - [ ] Mejorar feedback visual
  - [ ] Optimizar performance

- [ ] Documentación final:
  - [ ] Actualizar README si es necesario
  - [ ] Crear `CREDITS.txt` para assets de terceros
  - [ ] Capturar screenshots del juego
  - [ ] (Opcional) Grabar video demo

**Branch**: `feature/audio-polish`

---

## 🔄 Workflow de Git para Cada Miembro

### Al Empezar tu Tarea
```powershell
# Asegurarte de tener lo último
git checkout main
git pull origin main

# Crear tu rama de trabajo
git checkout -b feature/tu-feature
```

### Durante el Trabajo
```powershell
# Ver qué has cambiado
git status

# Agregar cambios
git add .

# Hacer commit (frecuentemente!)
git commit -m "feat: descripción de tu cambio"

# Repetir cada vez que completes algo significativo
```

### Al Terminar
```powershell
# Subir tu rama
git push origin feature/tu-feature
```

Luego ve a GitHub/GitLab y crea un **Pull Request**

### Después de que tu PR sea Aprobado
```powershell
# Actualizar tu main local
git checkout main
git pull origin main

# Borrar tu rama local (ya está mergeada)
git branch -d feature/tu-feature

# Listo para siguiente tarea
git checkout -b feature/siguiente-tarea
```

---

## 🎯 Checklist de Hitos del Proyecto

### Hito 1: Setup Completo ✅
- [ ] Todos tienen Godot instalado
- [ ] Todos tienen Git configurado
- [ ] Repositorio creado y compartido
- [ ] Todos pueden abrir el proyecto
- [ ] GameManager configurado como Autoload

**Fecha límite sugerida**: Día 1

---

### Hito 2: Gameplay Básico Funcional
- [ ] Player se mueve y dispara
- [ ] Al menos 1 tipo de enemigo funciona
- [ ] Enemigos mueren y sueltan XP
- [ ] XP se puede recoger
- [ ] Sistema de niveles funciona
- [ ] Menú de mejoras aparece (aunque sea simple)

**Fecha límite sugerida**: Día 3-4

---

### Hito 3: Todos los Sistemas Integrados
- [ ] 3 tipos de enemigos funcionan
- [ ] Spawning automático funciona
- [ ] Todas las mejoras se pueden elegir y aplicar
- [ ] HUD muestra información correcta
- [ ] Menú principal, pausa y game over funcionan
- [ ] El jugador puede morir

**Fecha límite sugerida**: Día 5-6

---

### Hito 4: Assets y Audio Completo
- [ ] Todos los sprites están implementados
- [ ] Todos los iconos están implementados
- [ ] Fuente personalizada aplicada
- [ ] Música de fondo suena
- [ ] Todos los SFX funcionan
- [ ] El juego se ve y suena cohesivo

**Fecha límite sugerida**: Día 7-8

---

### Hito 5: Testing y Pulido
- [ ] No hay errores en la consola
- [ ] Todos los items del TESTING.md pasan
- [ ] El juego está balanceado y es divertido
- [ ] La dificultad escala apropiadamente
- [ ] No hay bugs críticos

**Fecha límite sugerida**: Día 9

---

### Hito 6: Entrega Final ✅
- [ ] README actualizado con screenshots
- [ ] CREDITS.txt creado (si usaste assets de terceros)
- [ ] Todos los miembros han hecho commits
- [ ] Video demo grabado (opcional pero recomendado)
- [ ] Proyecto exportado (ejecutable, opcional)
- [ ] Presentación preparada

**Fecha límite sugerida**: Día 10

---

## 📊 Indicadores de Progreso

Marca conforme avances:

```
CÓDIGO:              ████████████████████ 100% ✅
ESCENAS:             ░░░░░░░░░░░░░░░░░░░░   0% ⏳
ASSETS VISUALES:     ░░░░░░░░░░░░░░░░░░░░   0% ⏳
ASSETS AUDIO:        ░░░░░░░░░░░░░░░░░░░░   0% ⏳
UI:                  ░░░░░░░░░░░░░░░░░░░░   0% ⏳
TESTING:             ░░░░░░░░░░░░░░░░░░░░   0% ⏳
DOCUMENTACIÓN:       ████████████████████ 100% ✅

TOTAL:               ████████░░░░░░░░░░░░  40%
```

---

## 🆘 ¿Problemas?

### El proyecto no abre en Godot
1. Verifica que tienes Godot 4.3 o superior
2. Verifica que estás abriendo `project.godot`
3. Verifica que clonaste correctamente el repo

### Errores en la consola de Godot
1. Primero: configura GameManager como Autoload
2. Si hay errores de "cannot find node": las escenas .tscn aún no existen (normal)
3. Si hay errores de sintaxis en scripts: reporta en el equipo

### Git me da conflictos
1. Haz pull antes de push siempre
2. Si hay conflictos, lee `GIT_SETUP.md` sección de conflictos
3. Pide ayuda al equipo si no puedes resolver

### No sé por dónde empezar
1. Lee `QUICKSTART.md` de principio a fin
2. Empieza con la tarea más simple de tu rol
3. Usa formas de colores temporales antes de buscar sprites bonitos

---

## 💪 ¡Tú Puedes!

Este proyecto está **diseñado para el éxito**:
- ✅ Todo el código ya funciona
- ✅ Documentación paso a paso
- ✅ Tareas claramente definidas
- ✅ Recursos y guías incluidas

Solo necesitas:
1. **Seguir las instrucciones**
2. **Comunicarte con tu equipo**
3. **Hacer commits frecuentes**
4. **No tener miedo de preguntar**

---

**¡Éxito en el proyecto! 🎮🚀**

---

## 📞 Contacto y Comunicación

### Crear Grupo del Equipo
- [ ] WhatsApp / Discord / Slack
- [ ] Compartir usernames de GitHub
- [ ] Establecer horarios de reunión

### Primera Reunión (30-60 min)
**Agenda sugerida**:
1. Presentación de cada miembro
2. Revisión de la estructura del proyecto
3. Asignación de roles y tareas
4. Establecer deadlines
5. Configurar repositorio Git
6. Resolver dudas técnicas

### Reuniones de Seguimiento (15-30 min)
**Frecuencia**: Cada 2-3 días
**Agenda**:
1. Qué hice desde la última reunión
2. Qué voy a hacer ahora
3. ¿Tengo algún bloqueante?
4. Demo rápida (si aplica)

---

**Versión**: 1.0  
**Última actualización**: Diciembre 2025  
**Estado**: Listo para desarrollo

¡Manos a la obra! 🎯
