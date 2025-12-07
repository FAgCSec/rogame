# Checklist de Balance y Testing

## ⚖️ Balance de Juego

### Stats del Jugador
```gdscript
Valores Iniciales (en game_manager.gd):
- Vida: 100
- Velocidad: 200
- Daño base: 10
- Velocidad de ataque: 1 shot/segundo
- Rango de recolección: 50 unidades
```

**Preguntas para ajustar**:
- [ ] ¿El jugador muere muy rápido/lento?
- [ ] ¿La velocidad de movimiento se siente bien?
- [ ] ¿El ataque automático es efectivo?

### Enemigos

#### Enemigo Rápido (Fast)
```
- Vida: 20
- Velocidad: 120
- Daño: 8
- XP: 1
```
Propósito: Presión constante, fáciles de matar

#### Enemigo Normal
```
- Vida: 40
- Velocidad: 80
- Daño: 12
- XP: 2
```
Propósito: Balance, enemigo estándar

#### Enemigo Tanque (Tank)
```
- Vida: 80
- Velocidad: 50
- Daño: 15
- XP: 3
```
Propósito: Amenaza lenta pero peligrosa

**Ajustes a considerar**:
- [ ] ¿La proporción de spawn es correcta? (50% normal, 30% fast, 20% tank)
- [ ] ¿Los enemigos tanque son suficientemente amenazantes?
- [ ] ¿Los enemigos rápidos son molestos o balanceados?

### Sistema de XP y Niveles
```
- XP inicial para nivel 2: 10
- Multiplicador por nivel: 1.5x
- Ejemplo: Nv1→2: 10 XP, Nv2→3: 15 XP, Nv3→4: 22 XP
```

**Revisar**:
- [ ] ¿Se siente progresión constante?
- [ ] ¿Los niveles se ganan muy rápido/lento?
- [ ] ¿El jugador tiene tiempo de elegir upgrades?

### Upgrades
```
1. Vida Extra: +20 HP
2. Velocidad: +15% velocidad
3. Más Daño: +25% daño
4. Ataque Rápido: +20% vel. ataque
5. Imán XP: +30% rango recolección
6. Armadura: +5 armadura
```

**Validar**:
- [ ] ¿Todas las mejoras se sienten impactantes?
- [ ] ¿Hay una mejora claramente superior/inferior?
- [ ] ¿La armadura es efectiva contra enemigos fuertes?

### Dificultad Progresiva
```
- Spawn inicial: 1 enemigo cada 2 segundos
- Cada 30 segundos: +1 enemigo por spawn
- Cada 30 segundos: -10% tiempo entre spawns
```

**Probar**:
- [ ] ¿El juego se vuelve imposible muy rápido?
- [ ] ¿Hay un "pico" de dificultad natural?
- [ ] ¿Es divertido después de 5 minutos? ¿10 minutos?

---

## 🧪 Testing Funcional

### Movimiento
- [ ] WASD mueve al jugador correctamente
- [ ] Flechas del teclado también funcionan
- [ ] El jugador no se atraviesa por el mapa
- [ ] La animación de caminar funciona (si existe)
- [ ] El sprite voltea según la dirección

### Combate
- [ ] Los proyectiles se disparan automáticamente
- [ ] Los proyectiles apuntan al enemigo más cercano
- [ ] Los proyectiles dañan a los enemigos
- [ ] Los proyectiles desaparecen después de 2 segundos
- [ ] El WeaponPivot rota hacia los enemigos
- [ ] El daño aumenta con el upgrade "Más Daño"
- [ ] La velocidad de ataque aumenta con el upgrade

### Enemigos
- [ ] Los 3 tipos de enemigos aparecen
- [ ] Se mueven hacia el jugador
- [ ] Causan daño al jugador al contacto
- [ ] Mueren cuando su vida llega a 0
- [ ] Sueltan gemas de XP al morir
- [ ] La barra de vida se actualiza correctamente
- [ ] El feedback visual de daño funciona (parpadeo rojo)

### Sistema de XP
- [ ] Las gemas de XP aparecen al matar enemigos
- [ ] Las gemas se pueden recoger acercándose
- [ ] La barra de XP se llena correctamente
- [ ] Al llenar la barra, se sube de nivel
- [ ] El contador de XP se reinicia correctamente
- [ ] El XP requerido aumenta cada nivel

### Sistema de Niveles
- [ ] El juego se pausa al subir de nivel
- [ ] Aparece el menú de mejoras
- [ ] Se muestran 3 opciones aleatorias
- [ ] Al seleccionar una, se aplica el efecto
- [ ] El juego se reanuda después de elegir
- [ ] El nivel se muestra en el HUD

### Upgrades
Probar cada uno individualmente:
- [ ] **Vida Extra**: Aumenta la barra de vida máxima y cura al máximo
- [ ] **Velocidad**: El jugador se mueve notablemente más rápido
- [ ] **Más Daño**: Los enemigos mueren más rápido
- [ ] **Ataque Rápido**: Los proyectiles se disparan más seguido
- [ ] **Imán XP**: El rango de recolección aumenta visiblemente
- [ ] **Armadura**: El jugador recibe menos daño

### UI/UX
#### HUD
- [ ] La barra de vida se actualiza al recibir daño
- [ ] El contador de vida muestra valores correctos
- [ ] La barra de XP se llena progresivamente
- [ ] El temporizador cuenta correctamente (MM:SS)
- [ ] El contador de kills aumenta al matar enemigos
- [ ] El nivel se muestra correctamente

#### Menú Principal
- [ ] El botón "Iniciar Juego" carga el juego
- [ ] El botón "Salir" cierra el juego
- [ ] El título se muestra correctamente
- [ ] Los botones responden al hover
- [ ] Los botones tienen feedback visual al clicar

#### Menú de Pausa
- [ ] ESC pausa el juego
- [ ] El juego se detiene completamente (enemigos, timer)
- [ ] El botón "Reanudar" funciona
- [ ] El botón "Menú" vuelve al menú principal
- [ ] ESC de nuevo reanuda el juego

#### Game Over
- [ ] Aparece cuando la vida del jugador llega a 0
- [ ] Muestra el nivel alcanzado correctamente
- [ ] Muestra el tiempo sobrevivido correctamente
- [ ] Muestra los enemigos eliminados correctamente
- [ ] El botón "Reiniciar" reinicia el juego
- [ ] El botón "Menú" vuelve al menú principal
- [ ] El juego se pausa correctamente

#### Menú de Mejoras
- [ ] Aparece al subir de nivel
- [ ] Pausa el juego
- [ ] Muestra 3 mejoras diferentes
- [ ] Los nombres de las mejoras son correctos
- [ ] Las descripciones son claras
- [ ] Al hacer click se aplica la mejora
- [ ] El menú desaparece después de elegir
- [ ] El juego se reanuda automáticamente

### Audio
- [ ] La música de fondo suena en loop
- [ ] El volumen de la música es apropiado
- [ ] El sonido de disparo se reproduce
- [ ] El sonido de golpe a enemigo se reproduce
- [ ] El sonido de daño al jugador se reproduce
- [ ] El sonido de recoger XP se reproduce
- [ ] El sonido de subida de nivel se reproduce
- [ ] Los sonidos de UI se reproducen
- [ ] Ningún sonido es molesto o demasiado fuerte

### Spawning
- [ ] Los enemigos aparecen fuera de la pantalla
- [ ] La frecuencia de spawn aumenta con el tiempo
- [ ] La cantidad de enemigos por spawn aumenta
- [ ] Los enemigos no aparecen encima del jugador
- [ ] La distribución de tipos es correcta

### Performance
- [ ] El juego corre a 60 FPS consistentemente
- [ ] No hay lag con 50+ enemigos en pantalla
- [ ] No hay memory leaks (ejecutar por 10+ minutos)
- [ ] La carga de la escena es rápida
- [ ] No hay stuttering al spawnear enemigos

---

## 🎮 Playtesting

### Sesión de 5 Minutos
- [ ] El juego es intuitivo sin tutorial
- [ ] Los controles se sienten responsivos
- [ ] Hay momentos de tensión y alivio
- [ ] Se siente recompensante matar enemigos
- [ ] Las mejoras son emocionantes

### Sesión de 15 Minutos
- [ ] El juego no se vuelve monótono
- [ ] Hay variedad suficiente
- [ ] La dificultad escala apropiadamente
- [ ] Es posible sobrevivir con buen juego
- [ ] Hay estrategia en elegir mejoras

### Diferentes Estilos de Juego
- [ ] Enfoque en daño (glass cannon)
- [ ] Enfoque en defensa (tank)
- [ ] Enfoque en velocidad (kiting)
- [ ] Build balanceada

¿Todos son viables?

---

## 🐛 Bugs Comunes a Buscar

### Críticos (deben ser arreglados)
- [ ] El juego crashea
- [ ] El jugador se queda atascado
- [ ] Los enemigos dejan de spawnear
- [ ] El juego no se puede pausar
- [ ] El menú de mejoras no aparece
- [ ] No se puede volver al menú principal

### Mayores (afectan experiencia)
- [ ] Los proyectiles no dañan enemigos
- [ ] Las mejoras no se aplican
- [ ] El XP no se recolecta
- [ ] El game over no se activa
- [ ] La música no se reproduce

### Menores (pulido)
- [ ] Textos mal escritos
- [ ] Colores que no se distinguen
- [ ] Feedback visual ausente
- [ ] Sonidos no sincronizados
- [ ] UI desalineada

---

## 📊 Métricas Sugeridas

Para hacer data-driven balance:

```gdscript
# Agregar a game_manager.gd para tracking
var metrics = {
    "max_level_reached": 0,
    "total_damage_dealt": 0,
    "total_damage_taken": 0,
    "total_xp_earned": 0,
    "upgrades_taken": {},
    "enemies_killed_by_type": {
        "fast": 0,
        "normal": 0,
        "tank": 0
    }
}
```

Preguntas a responder:
- ¿Qué upgrade se elige más frecuentemente?
- ¿Qué tipo de enemigo es más peligroso?
- ¿Cuál es el tiempo promedio de supervivencia?
- ¿En qué nivel mueren más jugadores?

---

## ✅ Checklist Final Antes de Entregar

- [ ] Todos los sistemas funcionan sin errores
- [ ] El juego es divertido de jugar
- [ ] No hay bugs críticos
- [ ] Todos los miembros han contribuido (verificar git log)
- [ ] El README está completo
- [ ] Hay screenshots/video del juego
- [ ] El código está comentado donde es necesario
- [ ] Los assets tienen créditos si son de terceros
- [ ] El .gitignore está configurado correctamente
- [ ] El proyecto se puede clonar y ejecutar en otra máquina

---

**Recuerda**: Un juego balanceado es un juego divertido. ¡Juega tu propio juego muchas veces!
