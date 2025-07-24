# UiPath Robot CI/CD with GitHub Actions

🤖 Este repositorio contiene la configuración completa para ejecutar robots de UiPath usando GitHub Actions de forma automatizada.

## ✨ Características

- ✅ Ejecución automática en push/pull request
- 🎯 Ejecución manual con parámetros personalizables
- 📊 Logs automáticos y artefactos
- 🔄 Integración completa con UiPath Orchestrator
- 🛡️ Configuración segura usando GitHub Secrets

## 🚀 Configuración Inicial

### Prerrequisitos

1. **UiPath Orchestrator** configurado y accesible
2. **Token de API** de UiPath
3. **Acceso** al repositorio de GitHub

### GitHub Secrets Requeridos

Configura estos secrets en tu repositorio (Settings → Secrets and variables → Actions):

```
UIPATH_API_TOKEN          # Tu token de API de UiPath
UIPATH_ORCHESTRATOR_URL   # URL de tu Orchestrator (ej: https://cloud.uipath.com/)
UIPATH_ORCHESTRATOR_TENANT # Nombre de tu tenant
```

### 📁 Estructura del Proyecto

```
├── .github/workflows/
│   └── uipath-robot.yml      # Workflow de GitHub Actions
├── config/
│   └── uipath-config.json    # Configuración del robot
├── scripts/
│   └── run-uipath-robot.ps1  # Script de ejecución
├── logs/                     # Logs de ejecución (generados automáticamente)
└── [tus archivos de UiPath]  # Project.json, Main.xaml, etc.
```

## 🎯 Uso

### Ejecución Automática

El robot se ejecutará automáticamente cuando:
- 📤 Hagas push a las ramas `main` o `develop`
- 🔄 Se abra un pull request hacia `main`

### Ejecución Manual

1. Ve a la pestaña **Actions** en tu repositorio
2. Selecciona **"UiPath Robot Execution"**
3. Haz clic en **"Run workflow"**
4. Ingresa el nombre del proceso a ejecutar
5. Haz clic en **"Run workflow"**

## ⚙️ Configuración Avanzada

### Modificar el Workflow

Edita `.github/workflows/uipath-robot.yml` para:
- Cambiar las ramas que disparan la ejecución
- Modificar la versión del UiPath CLI
- Ajustar el timeout de ejecución
- Personalizar los steps del workflow

### Configuración del Robot

Modifica `config/uipath-config.json` para:
- Ajustar el timeout de ejecución
- Cambiar el nivel de logging
- Configurar argumentos de entrada/salida
- Personalizar la configuración de reintentos

### Script de Ejecución

El archivo `scripts/run-uipath-robot.ps1` se puede personalizar para:
- Lógica de pre/post ejecución
- Manejo personalizado de errores
- Configuración específica del entorno

## 📊 Logs y Monitoreo

- **Logs automáticos**: Se generan en la carpeta `logs/`
- **Artefactos**: Los logs se suben automáticamente como artefactos de GitHub Actions
- **Descarga**: Puedes descargar los logs desde la interfaz de GitHub Actions

## 🔧 Troubleshooting

### Errores Comunes

1. **Error de autenticación**
   - ✅ Verifica que los secrets estén configurados correctamente
   - ✅ Confirma que el token tenga los permisos necesarios

2. **Error al encontrar el proceso**
   - ✅ Verifica que el proceso esté publicado en Orchestrator
   - ✅ Confirma el nombre exacto del proceso

3. **Timeout de ejecución**
   - ✅ Ajusta el `TimeoutMinutes` en el script
   - ✅ Optimiza tu proceso UiPath para que sea más eficiente

## 🤝 Contribuir

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

⭐ **¿Te gustó este proyecto?** ¡Dale una estrella y compártelo!

🐛 **¿Encontraste un bug?** Abre un issue y lo resolveremos juntos.

💡 **¿Tienes una idea?** ¡Las contribuciones son bienvenidas!