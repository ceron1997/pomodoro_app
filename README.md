# Pomodoro App

Aplicación Pomodoro hecha con Flutter — temporizador simple y configurable
para gestionar sesiones de trabajo y descansos.

## Contenido

- `lib/` — código fuente de la aplicación (configuración, dominio, infraestructura y presentación).
- `assets/` — recursos (sonidos).
- `docs/` — documentación del proyecto. Ver `docs/ARCHITECTURE_UPDATED.md` para la arquitectura.

## Características

- Temporizador Pomodoro con sesiones configurables (trabajo, corto y largo descanso).
- Persistencia de preferencias (duración de sesiones, sonidos, tema).
- Reproducción de sonido al finalizar sesión.
- Estructura por capas: `domain`, `infrastructure`, `presentation`.

## Requisitos

- Flutter SDK (estable).
- Plataforma de desarrollo según destino (Android/iOS/Windows/macOS/Linux).

## Ejecutar la app (desarrollo)

1. Instala dependencias:

```bash
flutter pub get
```

2. Ejecuta en el dispositivo o emulador conectado:

```bash
flutter run
```

Para ejecutar en Windows (si tienes soporte):

```bash
flutter run -d windows
```

## Tests

Ejecuta los tests unitarios y de widgets con:

```bash
flutter test
```

## Formateo y lint

Formatea el código con:

```bash
flutter format .
```

Corre el analyzer:

```bash
flutter analyze
```

## Estructura y buenas prácticas

- Mantener la lógica de negocio en `lib/domain` y exponer contratos (repositorios/servicios).
- Implementaciones concretas en `lib/infrastructure`.
- Providers/notifiers y UI en `lib/presentation`.
- Composición de dependencias en `lib/main.dart` o en la capa de `presentation` para facilitar tests.

Consulta `docs/ARCHITECTURE_UPDATED.md` para más detalles sobre la arquitectura.

## Contribuir

1. Crea un fork y una rama con una descripción clara del cambio.
2. Asegúrate de que `flutter analyze` y `flutter test` pasen localmente.
3. Abre un Pull Request describiendo el propósito del cambio.

## Contacto

Abre issues en el repositorio para reportar bugs o proponer mejoras.

---

Archivo generado: actualización del README para describir el proyecto y pasos de desarrollo.
