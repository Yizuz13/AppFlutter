# 🎓 Gestor de Tareas Académicas - UDES Cúcuta

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Material Design 3](https://img.shields.io/badge/Material%20Design-3-indigo)](https://m3.material.io/)
[![Zero Dependencies](https://img.shields.io/badge/Dependencies-0%20External-success)](https://pub.dev)
[![Author](https://img.shields.io/badge/Autor-Jesús%20Pérez-blue)](https://github.com/Yizuz13)
[![License](https://img.shields.io/badge/Licencia-Académica%20UDES-green)](#)

> Proyecto académico desarrollado para el programa de **Ingeniería de Sistemas** de la **Universidad de Santander (UDES) - Campus Cúcuta**.

---

## 📌 1. Información General del Proyecto

* **Nombre de la Aplicación:** Gestor de Tareas Académicas
* **Autor:** Jesús Pérez
* **Programa Académico:** Ingeniería de Sistemas
* **Institución:** Universidad de Santander (UDES) – Campus Cúcuta
* **Repositorio Oficial:** [https://github.com/Yizuz13/AppFlutter.git](https://github.com/Yizuz13/AppFlutter.git)
* **Rama Principal:** `main`

---

## 🚀 2. Descripción y Objetivos Pedagógicos

El **Gestor de Tareas Académicas** es una aplicación móvil y web construida íntegramente con **Flutter puro** y **Material Design 3**, diseñada para que los estudiantes universitarios organicen eficientemente sus compromisos académicos (exámenes, talleres, proyectos de aula, laboratorios y lecturas complementarias).

### Objetivos Pedagógicos y Técnicos:
1. **Comprensión del Ciclo de Vida y Estado:** Implementar el patrón reactivo fundamental de Flutter mediante `StatefulWidget` y llamadas explícitas a `setState()`.
2. **Arquitectura Limpia y Modular en un Solo Archivo:** Organizar el código fuente en componentes reutilizables con alta cohesión y bajo acoplamiento en `lib/main.dart`.
3. **Restricción de Cero Dependencias:** Construir una solución completa, robusta y con alta fidelidad gráfica sin requerir paquetes externos en `pubspec.yaml`, aprovechando al máximo la biblioteca estándar de Flutter.
4. **Validación Declarativa de Formularios:** Uso de `Form`, `GlobalKey<FormState>`, `TextFormField` y validadores síncronos con manejo adaptativo del teclado en pantalla.
5. **Renderizado Condicional:** Explicación y aplicación de colecciones condicionales en el árbol de widgets (`if (condicion) ...[ ]`).

---

## 📱 3. Funcionalidades de la Aplicación

| Funcionalidad | Descripción Técnica |
| :--- | :--- |
| **AppBar Institucional** | Muestra el título principal `Gestor Académico - Jesús Pérez` y el subtítulo `Ingeniería de Sistemas - UDES Cúcuta`, además de un menú contextual para acciones globales. |
| **Modelo de Datos `Tarea`** | Entidad inmutable con `id`, `titulo`, `categoria` (Examen, Taller, Proyecto, Laboratorio, Lectura), estado `completada` (booleano) y `fechaCreacion`. Incluye método `copyWith`. |
| **Panel Superior de Métricas** | Tarjeta resumen con contadores en tiempo real de: **Tareas Totales**, **Completadas** y **Pendientes**, junto a una barra de progreso porcentual (`LinearProgressIndicator`). |
| **Banner Motivacional ("¡Meta alcanzada!")** | Si el usuario alcanza **5 o más tareas completadas**, se renderiza dinámicamente una tarjeta destacada con gradiente dorado y mensaje de felicitación al futuro Ingeniero. |
| **Lista Interactiva Optimizada** | Construida con `ListView.builder` para reciclaje eficiente de widgets en memoria. Cada tarjeta cuenta con checkbox reactivo, badge de color por categoría, tachado condicional de texto y botón de eliminación. |
| **Modal para Nueva Tarea** | Desplegable inferior (`showModalBottomSheet`) con ajuste al teclado (`viewInsets.bottom`), validación de título (mínimo 4 caracteres) y selector de categoría (`DropdownButtonFormField`). |
| **Eliminación con Deshacer** | Al borrar una tarea, se dispara un `SnackBar` flotante con la acción `DESHACER` que reinserta la tarea en su índice original si el usuario lo desea. |
| **Filtros por Estado** | Chips interactivos para filtrar rápidamente entre `Todas`, `Pendientes` y `Completadas`. |
| **Acciones de Reinicio y Limpieza** | Menú superior para "Limpiar completadas" (con diálogo de confirmación) o "Restablecer tareas" con el lote académico inicial. |

---

## 🏛️ 4. Arquitectura y Estructura del Código (`lib/main.dart`)

El archivo [lib/main.dart](file:///c:/Users/USUARIO/Desktop/AppFlutter/lib/main.dart) está estructurado en 5 secciones pedagógicas claramente delimitadas:

```
lib/
└── main.dart
    ├── 1. Punto de Entrada & MaterialApp (GestorAcademicoApp)
    ├── 2. Modelo de Datos Inmutable (Tarea + métodos helper de categoría)
    ├── 3. Pantalla de Estado (GestorTareasPage & _GestorTareasPageState)
    │      ├── Getters computados (_totalTareas, _porcentajeProgreso, etc.)
    │      ├── Métodos de mutación de estado con setState()
    │      ├── showModalBottomSheet con Form y validaciones
    │      └── build() con AppBar, Panel, Banner, Filtros y ListView.builder
    └── 4. Widgets Modulares Auxiliares
           ├── _PanelResumenSuperior & _TarjetaMetrica
           ├── _BannerFelicitacion (Renderizado condicional si completadas >= 5)
           ├── _BarraFiltros (ChoiceChips reactivos)
           ├── _TarjetaTarea (Card interactiva con Checkbox y badges)
           └── _EstadoVacio (Ilustración y mensaje cuando no hay registros)
```

---

## 🧠 5. Conceptos Clave de Flutter Explicados

### A. ¿Por qué separar `StatefulWidget` y `State`?
En Flutter, los widgets son configuraciones inmutables y transitorias. La clase que hereda de `StatefulWidget` se recrea con frecuencia cuando el árbol se reconstruye. Por el contrario, la instancia de `State` es persistente y conserva las variables mutables (`_tareas`, `_filtroActivo`) a través de los múltiples ciclos de vida.

### B. El rol de `setState()`
Cuando se ejecuta:
```dart
setState(() {
  _tareas[indice] = _tareas[indice].copyWith(completada: !tarea.completada);
});
```
`setState()` notifica al framework que el estado interno ha mutado. Flutter marca el widget como "sucio" (*dirty*) y programa una ejecución de su método `build()` en el siguiente frame, reconciliando eficientemente el árbol de elementos.

### C. Eficiencia con `ListView.builder`
A diferencia de un `SingleChildScrollView` con un `Column`, `ListView.builder` implementa una ventana virtualizada: solo crea e infla en memoria los widgets de las tareas que actualmente son visibles en la pantalla, garantizando un rendimiento de 60/120 FPS incluso con cientos de tareas.

### D. Renderizado Condicional Limpio
```dart
if (_totalCompletadas >= 5) ...[
  const _BannerFelicitacion(),
],
```
Utiliza la sintaxis de *collection-if* y el operador de propagación (*spread operator* `...`) introducido en Dart, evitando código imperativo complejo dentro del árbol declarativo.

---

## 🛠️ 6. Requisitos de Instalación y Ejecución

### Prerrequisitos:
* **Flutter SDK:** Versión 3.10.0 o superior ([Instalar Flutter](https://docs.flutter.dev/get-started/install)).
* **Dart SDK:** Incluido automáticamente con Flutter.
* **Navegador Web / Emulador / Dispositivo Físico:** Chrome, Edge, Windows Desktop o Emulador Android.

### Paso a paso para ejecutar el proyecto:

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/Yizuz13/AppFlutter.git
   cd AppFlutter
   ```

2. **Verificar el entorno:**
   ```bash
   flutter doctor
   ```

3. **Obtener las dependencias del SDK (sin paquetes externos):**
   ```bash
   flutter pub get
   ```

4. **Ejecutar en la plataforma deseada:**
   * **Navegador Web (Chrome / Edge):**
     ```bash
     flutter run -d chrome
     ```
   * **Escritorio de Windows:**
     ```bash
     flutter run -d windows
     ```
   * **Dispositivo Android / Emulador:**
     ```bash
     flutter run
     ```

5. **Ejecutar las pruebas unitarias y de widgets:**
   ```bash
   flutter test
   ```

---

## 📦 7. Archivo de Configuración (`pubspec.yaml`)

Se garantiza el cumplimiento de la restricción de **cero dependencias externas**:

```yaml
name: app_flutter
description: "Gestor de Tareas Académicas - UDES Cúcuta - Jesús Pérez"
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

---

## 📋 8. Comandos Git para Sincronizar con el Repositorio

Para subir la solución al repositorio oficial configurado ([https://github.com/Yizuz13/AppFlutter.git](https://github.com/Yizuz13/AppFlutter.git)):

```bash
# 1. Verificar estado de los archivos creados
git status

# 2. Agregar los archivos al área de preparación
git add .

# 3. Crear el commit descriptivo
git commit -m "feat: Implementación completa del Gestor de Tareas Académicas UDES Cúcuta"

# 4. Asegurar la rama principal
git branch -M main

# 5. Enviar cambios al repositorio remoto
git push -u origin main
```

---

## 👨‍💻 9. Créditos y Autoría

* **Estudiante:** Jesús Pérez
* **Carrera:** Ingeniería de Sistemas
* **Materia:** Desarrollo Móvil / Programación en Nuevas Tecnologías
* **Universidad:** Universidad de Santander (UDES)
* **Campus:** Cúcuta, Norte de Santander, Colombia
* **Año:** 2026

