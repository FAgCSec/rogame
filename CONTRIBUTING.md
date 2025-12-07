# Guía de Contribución

## Flujo de Trabajo

1. **Antes de empezar a trabajar**:
   ```bash
   git pull origin main
   git checkout -b feature/tu-feature
   ```

2. **Durante el desarrollo**:
   - Haz commits frecuentes con mensajes descriptivos
   - Prueba tus cambios antes de hacer commit
   - No commites archivos temporales o de importación de Godot

3. **Al terminar tu feature**:
   ```bash
   git add .
   git commit -m "Descripción clara del cambio"
   git push origin feature/tu-feature
   ```

4. **Pull Request**:
   - Crea un PR en GitHub/GitLab
   - Describe los cambios realizados
   - Espera revisión de al menos 1 compañero

## Convenciones de Código

### GDScript
- Usa `snake_case` para nombres de variables y funciones
- Usa `PascalCase` para nombres de clases
- Indentación: 1 tab (o 4 espacios)
- Siempre documenta funciones complejas

### Commits
- Formato: `tipo: descripción`
- Tipos:
  - `feat`: Nueva funcionalidad
  - `fix`: Corrección de bug
  - `docs`: Cambios en documentación
  - `style`: Cambios de formato
  - `refactor`: Refactorización de código
  - `test`: Agregar o modificar tests
  - `asset`: Agregar o modificar assets

Ejemplos:
```
feat: implementar sistema de power-ups
fix: corregir spawn de enemigos en borde del mapa
docs: actualizar README con instrucciones de instalación
asset: agregar sprites para enemigos
```

## División de Tareas

### Sistema de Jugador (Miembro 1)
- Crear escena `player.tscn`
- Agregar sprites y animaciones
- Testear movimiento y ataque automático
- Implementar feedback visual de daño

### Sistema de Enemigos (Miembro 2)
- Crear escenas de los 3 tipos de enemigos
- Agregar sprites diferenciados por color
- Implementar sistema de spawning
- Ajustar balance de dificultad

### Sistema de Progresión (Miembro 3)
- Crear escena `xp_gem.tscn`
- Implementar sistema de recolección
- Testear todas las mejoras
- Balancear valores de XP y niveles

### Interfaz de Usuario (Miembro 4)
- Crear todas las escenas de UI (.tscn)
- Diseñar layout de menús
- Agregar fuentes personalizadas
- Implementar transiciones entre pantallas

### Audio y Pulido (Miembro 5)
- Agregar todos los archivos de audio
- Conectar audio con eventos del juego
- Crear/agregar assets visuales faltantes
- Testing general y corrección de bugs

## Testing

Antes de hacer push:
- [ ] El juego inicia sin errores
- [ ] Todas las mecánicas funcionan correctamente
- [ ] No hay errores en la consola de Godot
- [ ] Los assets se cargan correctamente
- [ ] La UI responde correctamente

## Resolución de Conflictos

Si hay conflictos al hacer merge:
1. Comunícate con tu equipo
2. Resuelve los conflictos localmente
3. Prueba que todo funcione después de resolver
4. Haz commit de la resolución

## Preguntas Frecuentes

**P: ¿Qué archivos debo commitear?**
R: Scripts (.gd), escenas (.tscn), assets (imágenes, audio), pero NO archivos .import o carpeta .godot/

**P: ¿Cómo pruebo los cambios de otro compañero?**
R: `git checkout [nombre-de-su-rama]` y abre el proyecto en Godot

**P: ¿Puedo modificar los scripts de otros?**
R: Sí, pero coordínate primero para evitar conflictos

**P: ¿Dónde reporto bugs?**
R: En la sección de Issues del repositorio o en el chat del equipo
