# Assets de Fuentes

## 🔤 Especificaciones

### Formato
- **.ttf** (TrueType Font) - Recomendado
- **.otf** (OpenType Font) - También compatible

### Estilo
Elige fuentes que sean:
- **Legibles**: Fáciles de leer en tamaños pequeños
- **Temáticas**: Que coincidan con el estilo del juego
- **Versátiles**: Que funcionen para títulos y texto de cuerpo

## 📝 Fuentes Necesarias

### Opción 1: Una Fuente Única
- [ ] `game_font.ttf` - Fuente principal para todo el juego

### Opción 2: Dos Fuentes (Recomendado)
- [ ] `title_font.ttf` - Para títulos y encabezados (puede ser más decorativa)
- [ ] `body_font.ttf` - Para texto general y UI (debe ser muy legible)

## 🔍 Recursos Recomendados

### Sitios de Fuentes Gratis

1. **Google Fonts** ⭐ Mejor opción
   - https://fonts.google.com/
   - Todas las fuentes son gratuitas y open source
   - Fácil de descargar

2. **DaFont**
   - https://www.dafont.com/
   - Categoría "Videojuegos": https://www.dafont.com/videojuegos.d256
   - ⚠️ Verifica la licencia de cada fuente

3. **FontSquirrel**
   - https://www.fontsquirrel.com/
   - Todas comercialmente libres
   - Filtro "Free for commercial use"

4. **1001 Free Fonts**
   - https://www.1001freefonts.com/
   - Categoría "Game": https://www.1001freefonts.com/game-fonts.php

## 🎨 Sugerencias por Estilo de Juego

### Retro/Pixel Art
- **Press Start 2P** (Google Fonts) ⭐
- **Silkscreen** (Google Fonts)
- **VT323** (Google Fonts)
- **Pixelify Sans** (Google Fonts)

### Moderno/Clean
- **Roboto** (Google Fonts)
- **Orbitron** (Google Fonts) - Sci-fi
- **Exo 2** (Google Fonts)
- **Rajdhani** (Google Fonts)

### Acción/Épico
- **Bungee** (Google Fonts)
- **Bebas Neue** (Google Fonts)
- **Black Ops One** (Google Fonts)
- **Russo One** (Google Fonts)

### Fantasía/Medieval
- **MedievalSharp** (Google Fonts)
- **Cinzel** (Google Fonts)
- **Almendra** (Google Fonts)

## 📥 Cómo Descargar de Google Fonts

1. Ve a https://fonts.google.com/
2. Busca la fuente que te guste
3. Click en "Get font"
4. Click en "Download all"
5. Extrae el .zip
6. Copia el archivo `.ttf` a esta carpeta

## 🛠️ Configuración en Godot

### Método 1: Tema Global (Recomendado)

1. **Crear un Theme**:
   - En FileSystem, click derecho > New Resource
   - Busca "Theme" y créalo
   - Guárdalo como `res://assets/fonts/game_theme.tres`

2. **Agregar Fuente al Theme**:
   - Abre el theme
   - En Inspector, busca "Default Font"
   - Click > "New FontFile"
   - En el FontFile, busca "Font Data"
   - Load > Selecciona tu `.ttf`

3. **Aplicar Theme Globalmente**:
   - Project > Project Settings > GUI > Theme
   - Custom: cargar tu `game_theme.tres`

### Método 2: Por Control Individual

En cada Label/Button:
```gdscript
# En el Inspector del nodo
Theme Overrides > Fonts > Font
> New FontFile
> Font Data > Load > selecciona .ttf
```

### Método 3: Por Script

```gdscript
# Cargar fuente en código
var font = FontFile.new()
font.data = FileAccess.get_file_as_bytes("res://assets/fonts/game_font.ttf")

# Aplicar a un Label
$Label.add_theme_font_override("font", font)
$Label.add_theme_font_size_override("font_size", 24)
```

## 📐 Tamaños Recomendados

- **Título Principal**: 48-72 px
- **Subtítulos**: 32-48 px
- **Texto de UI**: 16-24 px
- **Texto de cuerpo**: 14-18 px
- **Texto pequeño**: 12-14 px

## 💡 Tips

1. **Menos es más**: No uses más de 2-3 fuentes diferentes
2. **Contraste**: Asegura que el texto sea legible sobre el fondo
3. **Tamaño**: Prueba en diferentes resoluciones
4. **Kerning**: Ajusta el espaciado si es necesario
5. **Outline**: Para mejor legibilidad, agrega un borde:
   ```
   Theme Overrides > Colors > Font Outline Color
   Theme Overrides > Constants > Outline Size: 2
   ```

## 🎨 Configuración de Outline en Godot

Para texto con borde (mejor legibilidad):

```gdscript
# En un Label
$Label.add_theme_color_override("font_outline_color", Color.BLACK)
$Label.add_theme_constant_override("outline_size", 2)
```

O en Theme:
- Label > Styles > Normal > agregar StyleBoxFlat
- Configurar border y shadow

## 📝 Atribución

Crea `FONT_CREDITS.txt`:
```
Fuente: Press Start 2P
Autor: CodeMan38
Fuente: Google Fonts
Licencia: SIL Open Font License
URL: https://fonts.google.com/specimen/Press+Start+2P
```

## 🎯 Prioridad

1. **Alta**: Una fuente principal funcional
2. **Media**: Fuente secundaria para variedad
3. **Baja**: Efectos especiales en fuentes

## ⚠️ Importante: Licencias

Siempre verifica:
- ✅ Libre para uso comercial (si aplica)
- ✅ Permite redistribución
- ✅ Requiere atribución o no

**Google Fonts** es la opción más segura - todas son libres y open source.

---

**Recomendación**: Para empezar rápido, usa **Press Start 2P** de Google Fonts. Es perfecta para juegos tipo arcade/roguelite.

## 🚀 Quick Start

1. Ve a: https://fonts.google.com/specimen/Press+Start+2P
2. Click "Get font" > "Download all"
3. Extrae y copia `PressStart2P-Regular.ttf` a esta carpeta
4. En Godot: Project > Project Settings > GUI > Theme
5. Crea un nuevo Theme y asigna la fuente
6. ¡Listo!
