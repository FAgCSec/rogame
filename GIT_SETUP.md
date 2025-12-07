# Guía de Configuración de Git

## 📦 Instalación de Git

### Windows
1. Descarga Git desde: https://git-scm.com/download/win
2. Ejecuta el instalador
3. Opciones recomendadas:
   - Editor: Visual Studio Code (si lo tienes instalado)
   - PATH: "Git from the command line and also from 3rd-party software"
   - Line ending: "Checkout Windows-style, commit Unix-style"
4. Finaliza la instalación

### Verificar Instalación
Abre PowerShell o CMD y ejecuta:
```bash
git --version
```

Deberías ver algo como: `git version 2.x.x`

## 🔧 Configuración Inicial

### Configurar tu Identidad
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu.email@ejemplo.com"
```

### Verificar Configuración
```bash
git config --list
```

## 🚀 Crear Repositorio en GitHub/GitLab

### Opción A: GitHub

1. Ve a https://github.com/
2. Inicia sesión (crea cuenta si no tienes)
3. Click en "New repository" (botón verde)
4. Configuración:
   - **Repository name**: `rogame-survival` (o el nombre que prefieras)
   - **Description**: "Juego Arena Survival/Roguelite - Proyecto Electiva"
   - **Visibility**: Private (para trabajo en equipo) o Public
   - **NO** marques "Add a README" (ya tenemos uno)
   - **NO** agregues .gitignore ni license aún
5. Click "Create repository"

### Opción B: GitLab

1. Ve a https://gitlab.com/
2. Inicia sesión
3. Click "New project" > "Create blank project"
4. Similar configuración que GitHub
5. Click "Create project"

## 📂 Inicializar Repositorio Local

En la carpeta del proyecto (`rogame`), abre PowerShell y ejecuta:

```bash
# Navegar a la carpeta del proyecto
cd "C:\Users\User hp\Documents\ITP\6TO SEMESTRE\Electiva\rogame"

# Inicializar Git
git init

# Verificar archivos
git status

# Agregar todos los archivos
git add .

# Hacer el primer commit
git commit -m "Estructura inicial del proyecto Arena Survival Roguelite"

# Cambiar a rama main (si estás en master)
git branch -M main

# Conectar con el repositorio remoto (reemplaza URL con la tuya)
git remote add origin https://github.com/USUARIO/NOMBRE-REPO.git

# Verificar remote
git remote -v

# Subir cambios
git push -u origin main
```

### ⚠️ Nota sobre la URL
Reemplaza `https://github.com/USUARIO/NOMBRE-REPO.git` con la URL real que te da GitHub/GitLab después de crear el repositorio.

## 👥 Agregar Colaboradores

### En GitHub:
1. Ve a tu repositorio
2. Settings > Collaborators
3. Click "Add people"
4. Ingresa el username o email de tus compañeros
5. Envía invitación

### En GitLab:
1. Ve a tu repositorio
2. Project information > Members
3. Click "Invite members"
4. Agrega a tus compañeros

## 🔄 Workflow del Equipo

### Para Colaboradores: Clonar el Repositorio

```bash
# Navegar a la carpeta donde quieres el proyecto
cd "C:\Users\TuUsuario\Documents"

# Clonar
git clone https://github.com/USUARIO/NOMBRE-REPO.git

# Entrar a la carpeta
cd NOMBRE-REPO
```

### Workflow Diario

#### 1. Antes de empezar a trabajar:
```bash
# Asegurarte de estar en main
git checkout main

# Traer cambios del equipo
git pull origin main

# Crear tu rama de trabajo
git checkout -b feature/tu-feature
```

#### 2. Mientras trabajas:
```bash
# Ver estado de tus cambios
git status

# Agregar archivos modificados
git add .
# O específicos:
git add archivo1.gd archivo2.tscn

# Hacer commit
git commit -m "feat: descripción clara de tus cambios"

# Commits frecuentes son buenos
```

#### 3. Al terminar tu feature:
```bash
# Subir tu rama
git push origin feature/tu-feature
```

#### 4. Crear Pull Request (PR)
- Ve al repositorio en GitHub/GitLab
- Verás un botón "Compare & pull request"
- Describe tus cambios
- Asigna a alguien para revisión
- Espera aprobación y merge

#### 5. Después del merge:
```bash
# Volver a main
git checkout main

# Traer cambios actualizados (incluye tu merge)
git pull origin main

# Borrar tu rama local (ya está mergeada)
git branch -d feature/tu-feature
```

## 🌳 Estructura de Ramas

```
main (o master)
├── feature/player-system (Miembro 1)
├── feature/enemy-system (Miembro 2)
├── feature/ui-menus (Miembro 3)
├── feature/audio-integration (Miembro 4)
└── feature/game-balance (Miembro 5)
```

### Nombres de Ramas Sugeridos
- `feature/player-movement`
- `feature/enemy-spawning`
- `feature/ui-hud`
- `feature/upgrade-system`
- `feature/audio-sfx`
- `fix/player-collision-bug`
- `docs/update-readme`

## 🔍 Comandos Útiles

### Ver Estado
```bash
git status              # Ver archivos modificados
git log                 # Ver historial de commits
git log --oneline       # Historial resumido
git log --graph --all   # Ver árbol de ramas
```

### Manejo de Ramas
```bash
git branch              # Ver ramas locales
git branch -a           # Ver todas las ramas (incluso remotas)
git checkout main       # Cambiar a main
git checkout -b nueva   # Crear y cambiar a nueva rama
git branch -d rama      # Borrar rama local
```

### Sincronización
```bash
git fetch               # Traer info del remoto (sin merge)
git pull                # Traer y mergear cambios
git push                # Subir cambios
git push -u origin rama # Subir nueva rama
```

### Deshacer Cambios
```bash
git restore archivo.gd  # Descartar cambios no commiteados
git reset HEAD~1        # Deshacer último commit (mantiene cambios)
git reset --hard HEAD~1 # Deshacer último commit (BORRA cambios)
```

## 🛠️ Resolver Conflictos

Si hay conflictos al hacer `git pull` o merge:

1. Git marcará los archivos en conflicto
2. Abre el archivo, verás:
```
<<<<<<< HEAD
Tu código
=======
Código del otro
>>>>>>> rama-otra
```

3. Edita el archivo, elige qué código mantener
4. Elimina los marcadores (`<<<<`, `====`, `>>>>`)
5. Guarda el archivo
6. Agrega y commitea:
```bash
git add archivo-resuelto.gd
git commit -m "fix: resolver conflicto en archivo"
```

## 📝 Convenciones de Commits

### Formato
```
tipo: descripción corta

[descripción larga opcional]
```

### Tipos
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Cambios en documentación
- `style`: Formato, no afecta código
- `refactor`: Refactorización
- `test`: Agregar tests
- `chore`: Mantenimiento
- `asset`: Agregar/modificar assets

### Ejemplos
```bash
git commit -m "feat: implementar ataque automático del jugador"
git commit -m "fix: corregir colisión de proyectiles con enemigos"
git commit -m "docs: actualizar README con instrucciones de instalación"
git commit -m "asset: agregar sprites de enemigos"
git commit -m "refactor: optimizar sistema de spawning"
```

## 🔐 Autenticación

### GitHub con Token Personal

Si GitHub pide autenticación:

1. Ve a: GitHub > Settings > Developer settings > Personal access tokens > Tokens (classic)
2. "Generate new token"
3. Selecciona scopes: `repo` (todos)
4. Genera y copia el token
5. Cuando Git pida contraseña, usa el token

### Guardar Credenciales

```bash
# Para no tener que ingresar credenciales cada vez
git config --global credential.helper store
```

La primera vez que hagas `push`, te pedirá credenciales. Después las recordará.

## ⚠️ Archivos que NO commitear

El `.gitignore` ya está configurado para ignorar:
- `.godot/` - Carpeta de cache de Godot
- `.import/` - Archivos de importación
- `*.import` - Metadatos de importación

### Verificar antes de commit:
```bash
git status
```

No deberías ver archivos `.import` o carpeta `.godot/`

## 📊 Ver Contribuciones del Equipo

```bash
# Ver quién hizo qué
git log --oneline --graph --all --decorate

# Estadísticas por autor
git shortlog -sn

# Commits por persona
git log --author="Nombre"

# Archivos modificados por commit
git log --stat
```

## 🎯 Checklist Pre-Entrega

- [ ] Todos los miembros han hecho al menos 5 commits
- [ ] El historial muestra trabajo distribuido
- [ ] No hay archivos innecesarios (`.import`, `.godot/`)
- [ ] El README está actualizado
- [ ] Hay un .gitignore funcional
- [ ] El repositorio es accesible para el profesor
- [ ] Incluir URL del repositorio en la entrega

## 🆘 Problemas Comunes

### "fatal: not a git repository"
- No estás en la carpeta correcta
- Ejecuta `git init` primero

### "Permission denied"
- Verifica que eres colaborador del repo
- Revisa tus credenciales

### "Your branch is behind"
- Ejecuta `git pull` antes de `push`

### "Merge conflict"
- Ver sección de resolver conflictos arriba

### Archivos grandes no suben
- GitHub tiene límite de 100MB por archivo
- Para assets grandes, considera Git LFS

## 📚 Recursos Adicionales

- **Documentación oficial**: https://git-scm.com/doc
- **GitHub Guides**: https://guides.github.com/
- **GitLab Docs**: https://docs.gitlab.com/
- **Git Cheat Sheet**: https://education.github.com/git-cheat-sheet-education.pdf
- **Oh My Git!** (juego para aprender Git): https://ohmygit.org/

## 💡 Tips Pro

1. **Commits pequeños y frecuentes** > commits grandes
2. **Mensajes descriptivos** ayudan al equipo
3. **Pull antes de push** evita conflictos
4. **Ramas por feature** mantiene main estable
5. **Revisa los PR** de tus compañeros, aprenderás mucho
6. **Backup**: GitHub ES tu backup, úsalo frecuentemente

---

## 🚀 Setup Rápido para el Equipo

**El líder del equipo (quien crea el repo)**:
```bash
cd "C:\Users\User hp\Documents\ITP\6TO SEMESTRE\Electiva\rogame"
git init
git add .
git commit -m "Estructura inicial del proyecto"
git branch -M main
git remote add origin https://github.com/USUARIO/REPO.git
git push -u origin main
```

**Los colaboradores**:
```bash
cd "C:\Users\TuUsuario\Documents\ITP"
git clone https://github.com/USUARIO/REPO.git
cd REPO
git checkout -b feature/mi-tarea
# ... hacer cambios ...
git add .
git commit -m "feat: mi contribución"
git push origin feature/mi-tarea
# Crear PR en GitHub
```

---

¡Listo para colaborar! 🎮🤝
