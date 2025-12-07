# Assets de Sprites

## 📐 Especificaciones

### Resolución Recomendada
- **Jugador**: 64x64 px
- **Enemigos**: 32x32 px (Tank: 48x48 px)
- **Proyectiles**: 16x16 px
- **Gemas XP**: 16x16 px
- **Iconos UI**: 32x32 px

### Estilo
- Pixel art o low-poly
- Paleta de colores consistente
- Fondo transparente (PNG)

## 🎨 Sprites Necesarios

### Personajes
- [ ] `player.png` - Sprite del jugador (64x64)
- [ ] `player_weapon.png` - Sprite del arma (opcional, 16x16)

### Enemigos
- [ ] `enemy_fast.png` - Enemigo rápido (32x32, tono rojo)
- [ ] `enemy_normal.png` - Enemigo normal (32x32, tono azul)
- [ ] `enemy_tank.png` - Enemigo tanque (48x48, tono verde)

### Proyectiles y Efectos
- [ ] `projectile.png` - Proyectil básico (16x16)
- [ ] `xp_gem.png` - Gema de experiencia (16x16, brillante)

### Background
- [ ] `background.png` o tileset para el mapa
- [ ] `tile_floor.png` - Si usas tilemap (opcional)

## 🔍 Recursos Recomendados

### Sitios de Assets Gratis
1. **Kenney.nl** - Excelentes assets 2D gratis
   - https://kenney.nl/assets?q=2d
   
2. **OpenGameArt.org** - Comunidad de assets libres
   - https://opengameart.org/
   
3. **itch.io** - Muchos packs gratis y de pago
   - https://itch.io/game-assets/free/tag-2d

4. **Craftpix.net** - Assets gratis y premium
   - https://craftpix.net/freebies/

### Herramientas para Crear Sprites
- **Aseprite** - Editor pixel art profesional (de pago, ~$20)
- **Piskel** - Editor pixel art web gratis
- **GIMP** - Editor de imágenes gratis
- **Krita** - Software de arte digital gratis
- **Paint.NET** - Editor simple para Windows

### Paletas de Colores
- **Lospec Palette List**: https://lospec.com/palette-list
- Paletas recomendadas:
  - DawnBringer's 16
  - Sweetie 16
  - PICO-8

## 💡 Tips

1. **Mantén consistencia**: Todos los sprites deben tener el mismo estilo
2. **Usa guías**: Sigue las dimensiones recomendadas
3. **Transparencia**: Siempre usa PNG con fondo transparente
4. **Nombres claros**: Nombra los archivos descriptivamente
5. **Versiona**: Si creas múltiples versiones, usa `_v1`, `_v2`, etc.

## 📝 Atribución

Si usas assets de terceros, crea un archivo `CREDITS.txt` en esta carpeta con:
```
Nombre del Asset: [nombre]
Autor: [autor]
Licencia: [tipo de licencia]
Fuente: [URL]
```

## 🎯 Prioridad

1. **Alta**: player, enemigos, proyectil, gema XP (permiten probar el juego)
2. **Media**: background, efectos visuales
3. **Baja**: animaciones, sprites alternativos

---

**Nota**: Para pruebas iniciales, puedes usar formas geométricas de colores en Godot. Los sprites pueden agregarse después.
