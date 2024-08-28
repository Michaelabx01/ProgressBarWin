import 'dart:async';
import 'package:flutter/material.dart';

class ProgressBarWin extends StatefulWidget {
  const ProgressBarWin({super.key});

  @override
  _ProgressBarWinState createState() => _ProgressBarWinState();
}

class _ProgressBarWinState extends State<ProgressBarWin>
    with SingleTickerProviderStateMixin {
  double value = 0.0; // Valor inicial
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;
  int _interval = 200; // Intervalo inicial en milisegundos

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Duración de la animación
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: value).animate(_controller)
      ..addListener(() {
        setState(() {
          value = _animation.value;
        });
      });
  }

  void _setProgress(double newValue) {
    _controller.stop(); // Detener cualquier animación anterior

    // Establecer la nueva animación desde el valor actual al nuevo valor
    _animation = Tween<double>(begin: value, end: newValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {
          value = _animation.value;
        });
      });

    _controller.forward(from: 0.0); // Iniciar la animación desde el inicio
  }

  void _incrementProgress() {
    // Incrementar en un 2% y asegurarse de que no supere el 100%
    if (value < 1.0) {
      _setProgress((value + 0.02).clamp(0.0, 1.0));
    }
  }

  void _startAutoIncrement() {
    _interval = 200; // Reiniciar el intervalo cada vez que se empieza a presionar
    _timer = Timer.periodic(Duration(milliseconds: _interval), (timer) {
      _incrementProgress();
      if (value >= 1.0) {
        timer.cancel(); // Detener el timer si se alcanza el 100%
      } else {
        // Disminuir el intervalo para acelerar el incremento
        _interval = (_interval * 0.9).toInt(); // Reduce el intervalo en un 10%
        _timer?.cancel(); // Cancelar el timer anterior
        _startAutoIncrement(); // Iniciar un nuevo timer con el intervalo actualizado
      }
    });
  }

  void _stopAutoIncrement() {
    _timer?.cancel(); // Detener el timer si se suelta el botón
  }

  void _resetProgress() {
    _setProgress(0.0); // Animar el progreso hacia 0%
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel(); // Asegurarse de cancelar el timer al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress Bar con Animación y Botones")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 20, // Altura similar a la imagen
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade800, width: 1),
                    color: Colors.grey.shade300, // Fondo gris
                  ),
                  child: Row(
                    children: List.generate(50, (index) {
                      // Genera 50 segmentos para dar el efecto de la barra segmentada
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0.2), // Separación entre segmentos
                          decoration: BoxDecoration(
                            color: index / 50.0 < value
                                ? getGradientColor(index)
                                : Colors.transparent, // Color solo si está dentro del valor actual
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Text(
                  "${(value * 100).round()}%",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espacio entre la barra y los botones
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _setProgress(0.25),
                  child: const Text("25%"),
                ),
                ElevatedButton(
                  onPressed: () => _setProgress(0.45),
                  child: const Text("45%"),
                ),
                ElevatedButton(
                  onPressed: () => _setProgress(0.75),
                  child: const Text("75%"),
                ),
                ElevatedButton(
                  onPressed: () => _setProgress(1.0),
                  child: const Text("100%"),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espacio entre los botones y el botón de reinicio
            ElevatedButton(
              onPressed: _resetProgress,
              child: const Text("Reiniciar"),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onLongPressStart: (_) => _startAutoIncrement(),
        onLongPressEnd: (_) => _stopAutoIncrement(),
        child: FloatingActionButton(
          onPressed: _incrementProgress, // Incremento único al hacer clic
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Función que devuelve el color gradiente para cada segmento
  Color getGradientColor(int index) {
    double ratio = index / 50.0;
    if (ratio <= 0.33) {
      return Color.lerp(Colors.red, Colors.orange, ratio / 0.33)!;
    } else if (ratio <= 0.66) {
      return Color.lerp(Colors.orange, Colors.yellow, (ratio - 0.33) / 0.33)!;
    } else {
      return Color.lerp(Colors.yellow, Colors.green, (ratio - 0.66) / 0.34)!;
    }
  }
}
