// Test de widgets para verificar el Gestor de Tareas Académicas
// Autor: Jesús Pérez - Ingeniería de Sistemas - UDES Cúcuta

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_flutter/main.dart';

void main() {
  testWidgets('Verifica encabezado, métricas y banner motivacional', (WidgetTester tester) async {
    // 1. Inflar la aplicación
    await tester.pumpWidget(const GestorAcademicoApp());
    await tester.pumpAndSettle();

    // 2. Verificar datos del AppBar del autor e institución
    expect(find.text('Gestor Académico - Jesús Pérez'), findsOneWidget);
    expect(find.text('Ingeniería de Sistemas - UDES Cúcuta'), findsOneWidget);

    // 3. Verificar contadores métricos iniciales (3 completadas, 2 pendientes, 5 totales)
    expect(find.text('Totales'), findsOneWidget);
    expect(find.text('Completadas'), findsOneWidget);
    expect(find.text('Pendientes'), findsOneWidget);

    // En el estado inicial hay 3 completadas, por lo que aún no debe mostrarse el banner de meta (>= 5)
    expect(find.text('¡Meta alcanzada! 🎓'), findsNothing);

    // 4. Marcar dos tareas adicionales para alcanzar 5 completadas
    // Buscamos los Checkbox disponibles
    final checkboxes = find.byType(Checkbox);
    expect(checkboxes, findsWidgets);

    // Simulamos completar tareas pendientes tocando los checkboxes
    // Hay 5 tareas visibles por defecto; tocamos el 4to y 5to checkbox
    await tester.tap(checkboxes.at(3));
    await tester.pumpAndSettle();

    await tester.tap(checkboxes.at(4));
    await tester.pumpAndSettle();

    // 5. Ahora deben haber 5 tareas completadas y el banner debe aparecer
    expect(find.text('¡Meta alcanzada! 🎓'), findsOneWidget);

    // 6. Verificar presencia del botón de nueva tarea
    expect(find.text('Nueva Tarea'), findsOneWidget);
  });
}

