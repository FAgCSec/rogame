# Arena Survival Roguelite

Un juego tipo Vampire Survivors desarrollado en Godot Engine 4.x como proyecto educativo.

## DESCRIPCION DEL JUEGO

Arena Survival es un juego de supervivencia en arena donde el jugador debe sobrevivir contra hordas infinitas de enemigos. El personaje ataca automáticamente a los enemigos cercanos mientras el jugador controla el movimiento y elige mejoras estrategicas.

## CARACTERISTICAS PRINCIPALES

### Mecanicas de Juego
- Ataque automatico: El personaje dispara al enemigo mas cercano continuamente
- Movimiento fluido con WASD o flechas del teclado
- Supervivencia indefinida contra oleadas de enemigos
- Sistema de pausa con ESC

### Sistema de Progresion
- Sistema de experiencia (XP) ganando por eliminar enemigos
- Subida de nivel con requisitos progresivos
- Menu de evolucion con 3 mejoras aleatorias por nivel
- 6 tipos de mejoras disponibles:
  * Vida Extra (+20 HP maximo)
  * Velocidad (+15% velocidad de movimiento)
  * Mas Daño (+25% daño de ataque)
  * Ataque Rapido (+20% velocidad de ataque)
  * Iman de XP (+30% rango de recoleccion)
  * Armadura (+5 armadura)

### Enemigos (3 Tipos Distintos)

1. Enemigo Rapido (Color Rojo)
   - Velocidad: 120
   - Vida: 20 HP
   - Daño: 10 HP por contacto
   - XP: 1 punto
   
2. Enemigo Normal (Color Azul)
   - Velocidad: 80
   - Vida: 40 HP
   - Daño: 10 HP por contacto
   - XP: 2 puntos
   
3. Enemigo Tanque (Color Verde)
   - Velocidad: 50
   - Vida: 80 HP
   - Daño: 10 HP por contacto
   - XP: 3 puntos

### Interfaz y Menus
- Menu principal con boton de inicio y salida
- HUD con informacion de vida, XP y nivel
- Menu de pausa (ESC)
- Pantalla de game over al perder toda la vida
- Menu de mejoras con visualizacion clara de opciones

### Dificultad Progresiva
- Primeras 5 mejoras: Solo enemigos rapidos
- Mejoras 6-10: Enemigos rapidos y normales
- Mejoras 11+: Todos los tipos de enemigos
- Incremento automatico de cantidad de enemigos cada 30 segundos

## CONTENIDO DEL PROYECTO

### Scripts (15 archivos)
- player.gd: Control del jugador y ataque
- game_manager.gd: Gestion de estado del juego
- game_world.gd: Spawn de enemigos y logica del mundo
- enemy_base.gd: Clase base para enemigos
- enemy_normal.gd, enemy_fast.gd, enemy_tank.gd: Tipos especificos
- projectile.gd: Sistema de proyectiles
- xp_gem.gd: Sistema de recoleccion de XP
- UI scripts: hud.gd, pause_menu.gd, game_over_menu.gd, etc.

### Escenas (13 archivos .tscn)
- game_world.tscn: Escena principal del juego
- player.tscn: Personaje del jugador
- enemigos: enemy_normal.tscn, enemy_fast.tscn, enemy_tank.tscn
- xp_gem.tscn: Orbe de experiencia
- projectile.tscn: Proyectil del jugador
- Menus: main_menu.tscn, pause_menu.tscn, game_over_menu.tscn, upgrade_menu.tscn
- UI: hud.tscn, upgrade_button.tscn

### Assets
- Sprites SVG: Player, 3 enemigos, proyectil, orbe de XP
- Estructura lista para agregar sonidos y musica

### Configuracion
- project.godot: Configuracion completa con inputs personalizados
- GameManager.gd como autoload global

## COMO JUGAR

1. Abre Godot Engine 4.x
2. Importa el archivo project.godot
3. Abre scenes/game_world.tscn
4. Presiona F5 para ejecutar
5. Usa WASD para moverte
6. El ataque es automatico
7. Elige mejoras al subir de nivel
8. Sobrevive el mayor tiempo posible

## CONTROLES

- W/Flecha Arriba: Mover hacia arriba
- A/Flecha Izquierda: Mover hacia izquierda
- S/Flecha Abajo: Mover hacia abajo
- D/Flecha Derecha: Mover hacia derecha
- ESC: Pausar juego
- Click en mejora: Seleccionar mejora

## MECANICAS ESPECIALES

### Sistema de Daño
- Enemigos causan daño al tocar al jugador
- Daño limitado a 1 ataque por segundo por enemigo
- Armadura reduce el daño recibido

### Recoleccion de XP
- Los orbes se atraen visualmente hacia el jugador
- Rango de recoleccion expandible con mejoras
- Animacion de desvanecimiento al recoger

### Proyectiles
- Disparan hacia el enemigo mas cercano
- Daño escalable con mejora de Mas Daño
- Velocidad consistente de 400 pixeles por segundo

## DETALLES TECNICOS

- Motor: Godot Engine 4.x
- Lenguaje: GDScript
- Resolucion: 1280 x 720 (ajustable)
- Tipo de camara: Camara seguida al jugador
- Colisiones: Configuradas por capas

## NOTAS IMPORTANTES

- El juego no tiene limite de tiempo, es una supervivencia infinita
- Los enemigos spawnen continuamente fuera de la pantalla
- La dificultad aumenta automaticamente con el tiempo y con las mejoras
- El juego pausa completamente mientras se selecciona una mejora
- Las estadisticas del jugador persisten durante toda la partida

## INFORMACION ADICIONAL

Proyecto desarrollado como trabajo educativo.
Version: 1.0
Ultima actualizacion: Diciembre 2025
