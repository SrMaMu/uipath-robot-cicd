# Guía de Configuración Detallada

## 📋 Paso a Paso para Configurar tu Proyecto UiPath

### 1. Preparar tu Proyecto UiPath

Antes de subir tu proyecto, asegúrate de que:

- ✅ Tu proyecto UiPath esté funcionando correctamente en local
- ✅ Tengas un archivo `project.json` en la raíz
- ✅ El proceso principal esté en `Main.xaml`
- ✅ No haya dependencias locales o rutas hardcodeadas

### 2. Configurar UiPath Orchestrator

#### Crear un Token de API

1. Accede a tu UiPath Orchestrator
2. Ve a **Admin** → **Users**
3. Selecciona tu usuario
4. En **API Access**, crea un nuevo token
5. **¡IMPORTANTE!** Copia el token inmediatamente (no podrás verlo después)

#### Verificar Configuración

- ✅ Tu usuario tiene permisos para:
  - Crear/actualizar procesos
  - Ejecutar jobs
  - Acceder al folder configurado
- ✅ El environment está configurado correctamente
- ✅ Tienes robots disponibles para ejecutar

### 3. Configurar GitHub Secrets

#### Acceder a la Configuración

1. Ve a tu repositorio en GitHub
2. Click en **Settings** (pestaña superior)
3. En el menú izquierdo: **Secrets and variables** → **Actions**
4. Click en **New repository secret**

#### Secrets Requeridos

| Nombre | Descripción | Ejemplo |
|--------|-------------|----------|
| `UIPATH_API_TOKEN` | Token de API de UiPath | `eyJhbGciOiJSUzI1NiIsImtpZCI6...` |
| `UIPATH_ORCHESTRATOR_URL` | URL base de Orchestrator | `https://cloud.uipath.com/` |
| `UIPATH_ORCHESTRATOR_TENANT` | Nombre del tenant | `Default` o `MiEmpresa` |

### 4. Estructura de Archivos del Proyecto

#### Archivos Obligatorios de UiPath

```
project.json              # Configuración del proyecto
Main.xaml                # Workflow principal
```

#### Archivos Opcionales Comunes

```
Data/                    # Archivos de datos
Framework/               # Workflows del framework
Tests/                   # Tests automatizados
Config.xlsx              # Configuración en Excel
```

### 5. Personalizar la Configuración

#### Modificar `config/uipath-config.json`

```json
{
  "robotSettings": {
    "executionTimeout": 3600,     # 1 hora en segundos
    "logLevel": "Information",    # Trace, Debug, Information, Warning, Error
    "enableAnalytics": false,
    "enableLogging": true
  },
  "orchestratorSettings": {
    "folderPath": "/MiFolder",    # Cambiar por tu folder
    "environment": "Production"   # Development, Testing, Production
  },
  "processSettings": {
    "defaultProcess": "Main",
    "inputArguments": {
      "ConfigFile": "Config.xlsx",
      "Environment": "Prod"
    },
    "outputArguments": {}
  }
}
```

#### Modificar el Workflow

Para que el workflow funcione correctamente, necesitas:

1. **Mover el archivo del workflow a la ubicación correcta**:
   - Crear la carpeta `.github/workflows/`
   - Mover `workflows/uipath-robot.yml` a `.github/workflows/uipath-robot.yml`

2. **Personalizar configuraciones**:

```yaml
# Cambiar versión del CLI
env:
  UIPATH_CLI_VERSION: '23.4.8753.19456'  # Versión más reciente

# Cambiar branches que disparan el workflow
on:
  push:
    branches: [ main, develop, staging ]  # Agregar más branches

# Modificar timeout
- name: Run UiPath Process
  timeout-minutes: 60  # 60 minutos máximo
```

### 6. Testing y Validación

#### Test Manual

1. Haz un push a la rama `main`
2. Ve a **Actions** en GitHub
3. Observa la ejecución del workflow
4. Verifica que no haya errores

#### Test con Workflow Dispatch

1. Ve a **Actions** → **UiPath Robot Execution**
2. Click en **Run workflow**
3. Ingresa el nombre del proceso
4. Ejecuta y verifica resultados

### 7. Monitoreo y Logs

#### Ver Logs en GitHub

1. Ve a **Actions**
2. Click en la ejecución específica
3. Expande cada step para ver logs detallados
4. Descarga artefactos si es necesario

#### Ver Logs en Orchestrator

1. Ve a **Jobs** en Orchestrator
2. Busca tu job por fecha/hora
3. Click en el job para ver logs detallados

### 8. Solución de Problemas Comunes

#### Error: "Package not found"

**Causa**: El proceso no está publicado en Orchestrator

**Solución**:
1. Verifica que el step "Deploy to Orchestrator" se ejecute correctamente
2. Confirma permisos en Orchestrator
3. Verifica el nombre del proceso

#### Error: "Authentication failed"

**Causa**: Token o URL incorrectos

**Solución**:
1. Regenera el token en Orchestrator
2. Actualiza el secret `UIPATH_API_TOKEN`
3. Verifica la URL (debe incluir https://)

#### Error: "No robots available"

**Causa**: No hay robots configurados en el environment

**Solución**:
1. Ve a Orchestrator → Environments
2. Verifica que haya robots asignados
3. Confirma que estén online y disponibles

### 9. Mejores Prácticas

#### Seguridad

- ✅ Nunca hardcodees credenciales en el código
- ✅ Usa GitHub Secrets para información sensible
- ✅ Rota tokens regularmente
- ✅ Limita permisos al mínimo necesario

#### Performance

- ✅ Optimiza tus workflows para ejecución rápida
- ✅ Usa timeouts apropiados
- ✅ Implementa retry logic para operaciones críticas
- ✅ Limpia recursos temporales

#### Mantenimiento

- ✅ Actualiza regularmente la versión del UiPath CLI
- ✅ Mantén la documentación actualizada
- ✅ Revisa logs regularmente
- ✅ Implementa tests automatizados

---

¿Necesitas ayuda adicional? ¡Abre un issue en el repositorio!