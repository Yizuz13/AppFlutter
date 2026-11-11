// ============================================================================
// PROYECTO ACADÉMICO: GESTOR DE TAREAS ACADÉMICAS
// ============================================================================
// Autor: Jesús Pérez - Ingeniería de Sistemas
// Institución: Universidad de Santander (UDES) - Campus Cúcuta
// Repositorio: https://github.com/Yizuz13/AppFlutter.git
// Tecnologías: Flutter puro, Dart 3, Material Design 3 (Zero Dependencies)
// ============================================================================

import 'package:flutter/material.dart';

/// Punto de entrada principal de la aplicación Flutter.
/// La función [main] invoca [runApp] para inflar el widget raíz en el árbol de widgets.
void main() {
  runApp(const GestorAcademicoApp());
}

// ============================================================================
// 1. CONFIGURACIÓN DEL WIDGET RAÍZ (MaterialApp)
// ============================================================================

/// [GestorAcademicoApp] es un [StatelessWidget] porque su configuración
/// (título, tema, enrutamiento base) es inmutable durante el ciclo de vida de la app.
class GestorAcademicoApp extends StatelessWidget {
  const GestorAcademicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación en el sistema operativo / switcher de tareas
      title: 'Gestor Académico - UDES Cúcuta',
      debugShowCheckedModeBanner: false,

      // Configuración de Material Design 3 con semilla de color Índigo / Teal
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 2,
        ),
        cardTheme: CardTheme(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      // Pantalla principal del gestor
      home: const GestorTareasPage(),
    );
  }
}

// ============================================================================
// 2. MODELO DE DATOS (Data Model)
// ============================================================================

/// Modelo que encapsula los atributos esenciales de una tarea académica.
/// Implementa inmutabilidad recomendada en Flutter mediante campos 'final'
/// y un método [copyWith] para generar copias con estado actualizado.
class Tarea {
  final String id;
  final String titulo;
  final String categoria;
  final bool completada;
  final DateTime fechaCreacion;

  const Tarea({
    required this.id,
    required this.titulo,
    required this.categoria,
    this.completada = false,
    required this.fechaCreacion,
  });

  /// Lista constante de categorías académicas disponibles
  static const List<String> categoriasDisponibles = [
    'Examen',
    'Taller',
    'Proyecto',
    'Laboratorio',
    'Lectura',
  ];

  /// Obtiene el color temático asociado a la categoría para el diseño visual
  static Color obtenerColorCategoria(String categoria) {
    switch (categoria) {
      case 'Examen':
        return Colors.deepOrange;
      case 'Taller':
        return Colors.teal;
      case 'Proyecto':
        return Colors.indigo;
      case 'Laboratorio':
        return Colors.purple;
      case 'Lectura':
        return Colors.blueGrey;
      default:
        return Colors.indigo;
    }
  }

  /// Obtiene un icono representativo para la categoría
  static IconData obtenerIconoCategoria(String categoria) {
    switch (categoria) {
      case 'Examen':
        return Icons.quiz_outlined;
      case 'Taller':
        return Icons.edit_note_outlined;
      case 'Proyecto':
        return Icons.rocket_launch_outlined;
      case 'Laboratorio':
        return Icons.science_outlined;
      case 'Lectura':
        return Icons.menu_book_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  /// Genera una nueva instancia con atributos modificados selectivamente
  Tarea copyWith({
    String? id,
    String? titulo,
    String? categoria,
    bool? completada,
    DateTime? fechaCreacion,
  }) {
    return Tarea(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      categoria: categoria ?? this.categoria,
      completada: completada ?? this.completada,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}

// ============================================================================
// 3. PANTALLA PRINCIPAL CON MANEJO DE ESTADO (StatefulWidget)
// ============================================================================

/// [GestorTareasPage] maneja el estado dinámico de la lista de tareas.
/// En Flutter, se separa la clase widget inmutable de la clase [State] mutable.
class GestorTareasPage extends StatefulWidget {
  const GestorTareasPage({super.key});

  @override
  State<GestorTareasPage> createState() => _GestorTareasPageState();
}

/// [_GestorTareasPageState] almacena y gestiona el estado de las tareas
/// utilizando la llamada imperativa a [setState] para actualizar la UI reactivamente.
class _GestorTareasPageState extends State<GestorTareasPage> {
  // Lista en memoria que contiene las tareas académicas
  late List<Tarea> _tareas;

  // Filtro activo para la visualización: 'Todas', 'Pendientes', 'Completadas'
  String _filtroActivo = 'Todas';

  @override
  void initState() {
    super.initState();
    // Inicialización del estado: cargamos datos académicos de prueba
    _cargarTareasIniciales();
  }

  /// Carga datos iniciales representativos del programa de Ingeniería de Sistemas - UDES Cúcuta.
  /// Contiene 3 tareas completadas y 2 pendientes para facilitar probar el banner de meta (>= 5).
  void _cargarTareasIniciales() {
    _tareas = [
      Tarea(
        id: '1',
        titulo: 'Taller 1: Análisis Asintótico y Complejidad Big-O',
        categoria: 'Taller',
        completada: true,
        fechaCreacion: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Tarea(
        id: '2',
        titulo: 'Laboratorio 1: Configuración de Router y VLANS en Packet Tracer',
        categoria: 'Laboratorio',
        completada: true,
        fechaCreacion: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Tarea(
        id: '3',
        titulo: 'Lectura: Patrones de Diseño de Software (Gang of Four)',
        categoria: 'Lectura',
        completada: true,
        fechaCreacion: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Tarea(
        id: '4',
        titulo: 'Examen Parcial: Arquitectura de Software y Clean Code',
        categoria: 'Examen',
        completada: false,
        fechaCreacion: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Tarea(
        id: '5',
        titulo: 'Proyecto Integrador: Desarrollo de App Móvil con Flutter UDES',
        categoria: 'Proyecto',
        completada: false,
        fechaCreacion: DateTime.now(),
      ),
    ];
  }

  // ==========================================================================
  // GETTERS COMPUTADOS (Lógica de Negocio y Métricas)
  // ==========================================================================

  int get _totalTareas => _tareas.length;

  int get _totalCompletadas => _tareas.where((t) => t.completada).length;

  int get _totalPendientes => _totalTareas - _totalCompletadas;

  double get _porcentajeProgreso =>
      _totalTareas == 0 ? 0.0 : (_totalCompletadas / _totalTareas);

  /// Filtra la lista según la pestaña o chip seleccionado
  List<Tarea> get _tareasFiltradas {
    switch (_filtroActivo) {
      case 'Pendientes':
        return _tareas.where((t) => !t.completada).toList();
      case 'Completadas':
        return _tareas.where((t) => t.completada).toList();
      case 'Todas':
      default:
        return _tareas;
    }
  }

  // ==========================================================================
  // OPERACIONES CRUD Y ACCIONES CON setState()
  // ==========================================================================

  /// Alterna el estado completado/pendiente de una tarea
  void _alternarEstadoTarea(String id) {
    setState(() {
      final indice = _tareas.indexWhere((t) => t.id == id);
      if (indice != -1) {
        _tareas[indice] = _tareas[indice].copyWith(
          completada: !_tareas[indice].completada,
        );
      }
    });
  }

  /// Agrega una nueva tarea a la lista
  void _agregarTarea(String titulo, String categoria) {
    final nuevaTarea = Tarea(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: titulo.trim(),
      categoria: categoria,
      completada: false,
      fechaCreacion: DateTime.now(),
    );

    setState(() {
      // Se añade al inicio de la lista para visibilidad inmediata
      _tareas.insert(0, nuevaTarea);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarea "$titulo" agregada exitosamente.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo.shade800,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Elimina una tarea por su ID con opción pedagógica de "Deshacer"
  void _eliminarTarea(String id) {
    final indice = _tareas.indexWhere((t) => t.id == id);
    if (indice == -1) return;

    final tareaEliminada = _tareas[indice];

    setState(() {
      _tareas.removeAt(indice);
    });

    // Notificación flotante con botón para deshacer la acción
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarea "${tareaEliminada.titulo}" eliminada.'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'DESHACER',
          textColor: Colors.amberAccent,
          onPressed: () {
            setState(() {
              _tareas.insert(indice, tareaEliminada);
            });
          },
        ),
      ),
    );
  }

  /// Limpia todas las tareas que ya han sido completadas
  void _limpiarCompletadas() {
    final tareasCompletadas = _tareas.where((t) => t.completada).toList();
    if (tareasCompletadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay tareas completadas para limpiar.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.cleaning_services_outlined, color: Colors.indigo),
              SizedBox(width: 8),
              Text('Limpiar completadas'),
            ],
          ),
          content: Text(
            '¿Deseas eliminar las ${tareasCompletadas.length} tareas completadas?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton.tonal(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                setState(() {
                  _tareas.removeWhere((t) => t.completada);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Se han limpiado las tareas completadas.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  /// Restablece las tareas a los valores iniciales predeterminados
  void _reiniciarTareas() {
    setState(() {
      _cargarTareasIniciales();
      _filtroActivo = 'Todas';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tareas restablecidas a su estado inicial.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================================
  // MODAL PARA NUEVA TAREA (showModalBottomSheet con Validación)
  // ==========================================================================

  void _mostrarModalNuevaTarea() {
    final formKey = GlobalKey<FormState>();
    final tituloController = TextEditingController();
    String categoriaSeleccionada = Tarea.categoriasDisponibles.first;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permite ajustarse al teclado virtual
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              // Inset dinámico para que el modal suba al desplegar el teclado
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Encabezado del modal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.add_task_rounded,
                                  color: Colors.indigo,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Nueva Tarea Académica',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(modalContext).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Campo de texto con validación
                      TextFormField(
                        controller: tituloController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Título o descripción de la tarea',
                          hintText: 'Ej. Preparar sustentación de proyecto final',
                          prefixIcon: const Icon(Icons.title_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor ingresa un título para la tarea.';
                          }
                          if (value.trim().length < 4) {
                            return 'El título debe tener al menos 4 caracteres.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Selector de categoría académica
                      DropdownButtonFormField<String>(
                        value: categoriaSeleccionada,
                        decoration: InputDecoration(
                          labelText: 'Categoría académica',
                          prefixIcon: const Icon(Icons.category_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        items: Tarea.categoriasDisponibles.map((cat) {
                          final color = Tarea.obtenerColorCategoria(cat);
                          final icono = Tarea.obtenerIconoCategoria(cat);
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Row(
                              children: [
                                Icon(icono, color: color, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  cat,
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? nuevaCategoria) {
                          if (nuevaCategoria != null) {
                            setModalState(() {
                              categoriaSeleccionada = nuevaCategoria;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Botones de acción (Cancelar / Guardar)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(modalContext).pop(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Cancelar'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  _agregarTarea(
                                    tituloController.text,
                                    categoriaSeleccionada,
                                  );
                                  Navigator.of(modalContext).pop();
                                }
                              },
                              icon: const Icon(Icons.save_outlined),
                              label: const Text('Guardar'),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================================
  // DIÁLOGO ACERCA DE (Información Institucional)
  // ==========================================================================

  void _mostrarDialogoAcercaDe() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.school_outlined, color: Colors.indigo),
            SizedBox(width: 8),
            Text('Información Académica'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestor de Tareas Académicas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('• Autor: Jesús Pérez'),
            Text('• Programa: Ingeniería de Sistemas'),
            Text('• Institución: Universidad de Santander (UDES)'),
            Text('• Campus: Cúcuta, Colombia'),
            SizedBox(height: 8),
            Text(
              'Proyecto desarrollado en Flutter puro con Material Design 3, '
              'demostrando manejo de estado explícito con setState() y '
              'buenas prácticas de arquitectura modular.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // 4. CONSTRUCCIÓN DE LA INTERFAZ DE USUARIO (build method)
  // ==========================================================================

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      // ----------------------------------------------------------------------
      // APPBAR REQUERIDA CON AUTOR E INDICADOR INSTITUCIONAL
      // ----------------------------------------------------------------------
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gestor Académico - Jesús Pérez',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ingeniería de Sistemas - UDES Cúcuta',
              style: TextStyle(
                fontSize: 12,
                color: tema.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          // Menú desplegable con opciones de utilidad académica
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Opciones adicionales',
            onSelected: (valor) {
              if (valor == 'limpiar') {
                _limpiarCompletadas();
              } else if (valor == 'reiniciar') {
                _reiniciarTareas();
              } else if (valor == 'info') {
                _mostrarDialogoAcercaDe();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'limpiar',
                child: Row(
                  children: [
                    Icon(Icons.cleaning_services_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('Limpiar completadas'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'reiniciar',
                child: Row(
                  children: [
                    Icon(Icons.restore_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('Restablecer tareas'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    SizedBox(width: 8),
                    Text('Acerca de'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      // ----------------------------------------------------------------------
      // CUERPO PRINCIPAL (Column con Scroll y Lista Optimizada)
      // ----------------------------------------------------------------------
      body: Column(
        children: [
          // PANEL SUPERIOR: Resumen de métricas y barra de progreso
          _PanelResumenSuperior(
            total: _totalTareas,
            completadas: _totalCompletadas,
            pendientes: _totalPendientes,
            progreso: _porcentajeProgreso,
          ),

          // BANNER MOTIVACIONAL CONDICIONAL: Se activa cuando completadas >= 5
          // Demostración pedagógica del operador 'if (condición) ...[ ]' en Flutter
          if (_totalCompletadas >= 5) ...[
            const _BannerFelicitacion(),
          ],

          // BARRA DE FILTROS: Todas, Pendientes, Completadas
          _BarraFiltros(
            filtroActual: _filtroActivo,
            totalTodas: _totalTareas,
            totalPendientes: _totalPendientes,
            totalCompletadas: _totalCompletadas,
            onFiltroCambiado: (nuevoFiltro) {
              setState(() {
                _filtroActivo = nuevoFiltro;
              });
            },
          ),

          // LISTA INTERACTIVA: ListView.builder para eficiencia de memoria
          Expanded(
            child: _tareasFiltradas.isEmpty
                ? _EstadoVacio(filtro: _filtroActivo)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _tareasFiltradas.length,
                    itemBuilder: (context, index) {
                      final tarea = _tareasFiltradas[index];
                      return _TarjetaTarea(
                        tarea: tarea,
                        onToggle: () => _alternarEstadoTarea(tarea.id),
                        onDelete: () => _eliminarTarea(tarea.id),
                      );
                    },
                  ),
          ),
        ],
      ),

      // ----------------------------------------------------------------------
      // BOTÓN FLOTANTE PARA AÑADIR NUEVA TAREA
      // ----------------------------------------------------------------------
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarModalNuevaTarea,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task),
        label: const Text('Nueva Tarea'),
        tooltip: 'Registrar nueva tarea académica',
      ),
    );
  }
}

// ============================================================================
// 5. COMPONENTES MODULARES Y WIDGETS AUXILIARES
// ============================================================================

/// Panel visual superior que muestra contadores numéricos y la barra de avance
class _PanelResumenSuperior extends StatelessWidget {
  final int total;
  final int completadas;
  final int pendientes;
  final double progreso;

  const _PanelResumenSuperior({
    required this.total,
    required this.completadas,
    required this.pendientes,
    required this.progreso,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progreso del Semestre',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF2B3A4A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(progreso * 100).toInt()}% Completado',
                  style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Barra de progreso animada con Material 3
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progreso,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                progreso >= 1.0 ? Colors.green : Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Fila con tres tarjetas métricas: Total, Completadas, Pendientes
          Row(
            children: [
              Expanded(
                child: _TarjetaMetrica(
                  titulo: 'Totales',
                  valor: total,
                  icono: Icons.folder_open_outlined,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TarjetaMetrica(
                  titulo: 'Completadas',
                  valor: completadas,
                  icono: Icons.check_circle_outline,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TarjetaMetrica(
                  titulo: 'Pendientes',
                  valor: pendientes,
                  icono: Icons.hourglass_top_outlined,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Mini-tarjeta individual de métrica
class _TarjetaMetrica extends StatelessWidget {
  final String titulo;
  final int valor;
  final IconData icono;
  final Color color;

  const _TarjetaMetrica({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icono, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            valor.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Banner o tarjeta motivacional cuando el estudiante alcanza 5 o más tareas completadas
class _BannerFelicitacion extends StatelessWidget {
  const _BannerFelicitacion();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade600,
            Colors.orange.shade700,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: Colors.amber,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Meta alcanzada! 🎓',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Has completado 5 o más tareas. ¡Excelente dedicación académica, futuro Ingeniero de Sistemas UDES!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Selector de filtros con chips horizontales (Todas, Pendientes, Completadas)
class _BarraFiltros extends StatelessWidget {
  final String filtroActual;
  final int totalTodas;
  final int totalPendientes;
  final int totalCompletadas;
  final ValueChanged<String> onFiltroCambiado;

  const _BarraFiltros({
    required this.filtroActual,
    required this.totalTodas,
    required this.totalPendientes,
    required this.totalCompletadas,
    required this.onFiltroCambiado,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          _buildChip('Todas', totalTodas),
          const SizedBox(width: 8),
          _buildChip('Pendientes', totalPendientes),
          const SizedBox(width: 8),
          _buildChip('Completadas', totalCompletadas),
        ],
      ),
    );
  }

  Widget _buildChip(String label, int count) {
    final seleccionado = filtroActual == label;
    return ChoiceChip(
      selected: seleccionado,
      onSelected: (_) => onFiltroCambiado(label),
      label: Text('$label ($count)'),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: seleccionado ? FontWeight.bold : FontWeight.normal,
        color: seleccionado ? Colors.white : Colors.black87,
      ),
      selectedColor: Colors.indigo,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: seleccionado ? Colors.indigo : Colors.grey.shade300,
        ),
      ),
    );
  }
}

/// Tarjeta individual interactiva para cada tarea en el ListView
class _TarjetaTarea extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _TarjetaTarea({
    required this.tarea,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorCat = Tarea.obtenerColorCategoria(tarea.categoria);
    final iconoCat = Tarea.obtenerIconoCategoria(tarea.categoria);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: tarea.completada ? const Color(0xFFF1F3F5) : Colors.white,
      elevation: tarea.completada ? 0.5 : 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onToggle, // Tocar la tarjeta también alterna el estado
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              // Checkbox reactivo con animación nativa
              Checkbox(
                value: tarea.completada,
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onChanged: (_) => onToggle(),
              ),

              // Contenido de la tarea (Badge de categoría + Título)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge estilizado de la categoría
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colorCat.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(iconoCat, size: 14, color: colorCat),
                          const SizedBox(width: 4),
                          Text(
                            tarea.categoria,
                            style: TextStyle(
                              color: colorCat,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Título de la tarea con tachado si está completada
                    Text(
                      tarea.titulo,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: tarea.completada
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: tarea.completada
                            ? Colors.grey.shade500
                            : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),

              // Botón de eliminar con icono suave
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent,
                  size: 22,
                ),
                tooltip: 'Eliminar tarea',
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Estado visual cuando no hay tareas disponibles según el filtro
class _EstadoVacio extends StatelessWidget {
  final String filtro;

  const _EstadoVacio({required this.filtro});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.07),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment_turned_in_outlined,
                size: 56,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              filtro == 'Completadas'
                  ? 'Aún no has completado tareas'
                  : filtro == 'Pendientes'
                      ? '¡Excelente! No tienes tareas pendientes'
                      : 'No hay tareas académicas registradas',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Toca el botón "+ Nueva Tarea" para registrar entregas, talleres o proyectos.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

