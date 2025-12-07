# Iconos de UI

## 🎨 Especificaciones

### Formato
- **PNG** con transparencia
- **32x32 px** (o 64x64 para mayor calidad)

### Estilo
- Simple y reconocible
- Alto contraste
- Consistente con el estilo del juego

## 🔰 Iconos Necesarios

Para el sistema de upgrades:

- [ ] `health.png` - Vida Extra
  - 💚 Corazón o cruz médica
  
- [ ] `speed.png` - Velocidad
  - 💨 Zapato con alas o líneas de velocidad
  
- [ ] `damage.png` - Más Daño
  - ⚔️ Espada o puño
  
- [ ] `attack_speed.png` - Ataque Rápido
  - ⚡ Rayo o flechas cruzadas
  
- [ ] `magnet.png` - Imán de XP
  - 🧲 Imán o diamante brillante
  
- [ ] `armor.png` - Armadura
  - 🛡️ Escudo

## 🔍 Recursos Recomendados

### Sitios de Iconos Gratis

1. **Game-icons.net** ⭐ PERFECTO para juegos
   - https://game-icons.net/
   - Miles de iconos SVG gratis
   - Puedes cambiar colores online
   - Descarga como PNG

2. **Flaticon**
   - https://www.flaticon.com/
   - Busca "game icons", "RPG icons"
   - Plan gratuito con atribución

3. **Kenney Game Icons**
   - https://kenney.nl/assets/game-icons
   - Pack completo de iconos para juegos

4. **OpenGameArt - Icons**
   - https://opengameart.org/art-search-advanced?keys=icons

5. **Itch.io - UI Packs**
   - https://itch.io/game-assets/free/tag-icons

## 🛠️ Crear Iconos Propios

### Herramientas Online
- **Canva** - Templates de iconos
- **Figma** - Diseño vectorial online
- **Pixlr** - Editor de imágenes web

### Herramientas Desktop
- **Inkscape** (gratis) - Vectorial
- **GIMP** (gratis) - Raster
- **Aseprite** - Para estilo pixel art

## 📥 Cómo Usar game-icons.net

1. Ve a https://game-icons.net/
2. Busca el icono (ej: "heart" para vida)
3. Click en el icono
4. Personaliza:
   - Background: Transparent
   - Foreground color: Blanco o color deseado
   - Size: 32 o 64
5. Download PNG
6. Guarda en esta carpeta

## 🎨 Sugerencias Específicas

### health.png
Buscar: "heart", "health", "medical"
- Icono: `glass-heart`, `health-normal`, `heart-plus`

### speed.png
Buscar: "speed", "fast", "running"
- Icono: `wing-cloak`, `fast-forward-button`, `sprint`

### damage.png
Buscar: "sword", "attack", "power"
- Icono: `broadsword`, `sword-clash`, `abstract-050`

### attack_speed.png
Buscar: "lightning", "bolt", "rapid"
- Icono: `lightning-bolt`, `lightning-frequency`, `fast-arrow`

### magnet.png
Buscar: "magnet", "attract", "gem"
- Icono: `magnet`, `minerals`, `star-sattelites`

### armor.png
Buscar: "shield", "armor", "defense"
- Icono: `shield`, `round-shield`, `chest-armor`

## 🛠️ Configuración en Godot

### En upgrade_button.tscn

Agregar un TextureRect para el icono:

```
Button (upgrade_button)
└── HBoxContainer
    ├── TextureRect (IconTexture)
    │   [Stretch Mode: Keep Aspect Centered]
    │   [Custom Minimum Size: 32x32]
    └── VBoxContainer
        ├── UpgradeName (Label)
        └── UpgradeDescription (Label)
```

### En el script

Modificar `upgrade_button.gd`:

```gdscript
@onready var icon_texture = $HBoxContainer/TextureRect

func setup_upgrade(upgrade: Dictionary):
    upgrade_data = upgrade
    upgrade_name.text = upgrade.name
    upgrade_description.text = upgrade.description
    
    # Cargar icono
    if upgrade.has("icon"):
        var icon = load(upgrade.icon)
        if icon:
            icon_texture.texture = icon
```

## 📐 Formato de Iconos

### Opción 1: Background Transparente
- Fondo completamente transparente
- Icono en blanco o color claro
- Se ve bien sobre fondos oscuros

### Opción 2: Con Background
- Círculo o cuadrado de fondo
- Icono encima
- Más fácil de ver pero menos flexible

**Recomendación**: Usa opción 1 y agrega background en Godot con StyleBox

## 🎯 Configurar Background en Godot

Para iconos con background circular:

```gdscript
# Agregar Panel detrás del icono
Panel (ColorRect o Panel)
└── TextureRect (icono)

# O usar StyleBoxFlat
# En Inspector del Panel/Button:
# Theme Overrides > Styles > Normal
# > New StyleBoxFlat
# > Border Radius: 50% para círculo
# > Background Color: tu color
```

## 💡 Tips

1. **Consistencia**: Todos los iconos deben tener el mismo estilo
2. **Contraste**: Deben ser visibles sobre el fondo de la UI
3. **Simplicidad**: Evita detalles excesivos en 32x32
4. **Testing**: Prueba cómo se ven en el juego real
5. **Backup**: Guarda versiones en SVG si es posible (escalable)

## 📝 Estructura de Archivos

```
icons/
├── health.png
├── speed.png
├── damage.png
├── attack_speed.png
├── magnet.png
├── armor.png
├── CREDITS.txt (si usas de terceros)
└── README.md (este archivo)
```

## 🎨 Paleta Sugerida

Para iconos con color:
- **health.png**: Rojo/Rosa (#FF4444)
- **speed.png**: Cyan/Azul claro (#44DDFF)
- **damage.png**: Naranja/Amarillo (#FFAA44)
- **attack_speed.png**: Amarillo brillante (#FFFF44)
- **magnet.png**: Verde brillante (#44FF44)
- **armor.png**: Gris/Plateado (#AAAAAA)

## 📝 Atribución

Si usas game-icons.net u otros, crea `CREDITS.txt`:

```
ICONOS DE UI

Todos los iconos provienen de:
- Fuente: game-icons.net
- Licencia: CC BY 3.0
- URL: https://game-icons.net/

Iconos específicos:
- health.png: "glass-heart" por Lorc
- speed.png: "sprint" por Lorc
- damage.png: "broadsword" por Lorc
- attack_speed.png: "lightning-bolt" por Delapouite
- magnet.png: "magnet" por Delapouite
- armor.png: "round-shield" por Lorc

Licencia completa: https://creativecommons.org/licenses/by/3.0/
```

## 🎯 Prioridad

1. **Alta**: Los 6 iconos de upgrades (críticos para UI funcional)
2. **Media**: Iconos adicionales para UI (settings, back, etc.)
3. **Baja**: Variaciones o versiones alternativas

## 🚀 Quick Start

**Método más rápido**:

1. Ve a https://game-icons.net/
2. Busca cada icono de la lista de sugerencias
3. Color: Blanco (#FFFFFF)
4. Background: Transparent
5. Size: 64
6. Download todos
7. Renombra según la lista
8. ¡Listo para usar!

---

**Tiempo estimado**: 15-20 minutos para descargar los 6 iconos básicos.
