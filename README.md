# ProgressBarWin - Flutter Widget

Este proyecto contiene un widget personalizado en Flutter que muestra una barra de progreso animada con varias opciones de control. La barra de progreso se puede controlar de manera manual mediante botones, o de manera automática mediante una pulsación prolongada en un botón flotante.

## Descripción

El widget `ProgressBarWin` es un componente interactivo que permite visualizar y controlar el progreso mediante una barra animada. La barra de progreso se actualiza con una animación suave y tiene la opción de incrementar automáticamente cuando se mantiene pulsado un botón flotante.

### Características

- **Incremento manual**: Botones que permiten ajustar el progreso a valores específicos (25%, 45%, 75%, 100%).
- **Incremento automático**: Pulsación prolongada en un botón flotante que incrementa el progreso de manera continua hasta llegar al 100%.
- **Reinicio del progreso**: Un botón para reiniciar el progreso a 0%.
- **Barra de progreso segmentada**: La barra de progreso está visualmente dividida en segmentos y cambia de color gradualmente de rojo a verde a medida que avanza el progreso.

## Cómo funciona

### Animación de la Barra de Progreso

- La barra de progreso usa un `AnimationController` para gestionar la animación desde el valor actual hasta el nuevo valor objetivo.
- Los colores de la barra cambian de rojo a verde en función del progreso, lo que proporciona una retroalimentación visual clara.

### Incremento Automático

- El incremento automático se activa al mantener pulsado el botón flotante.
- A medida que el progreso aumenta, el intervalo de tiempo entre incrementos se reduce, lo que acelera el progreso.
- El incremento automático se detiene cuando se alcanza el 100% o cuando se suelta el botón flotante.

### Controles

- **Botones de Progreso**: Cada botón ajusta el progreso a un valor fijo (25%, 45%, 75%, 100%).
- **Botón de Reinicio**: Reinicia el progreso a 0%.
- **Botón Flotante**: Puede usarse para incrementar manualmente el progreso en un 2% con un clic o para iniciar un incremento automático al mantenerlo presionado.

## Uso

Para usar este widget, simplemente inclúyelo en tu aplicación de Flutter:

```dart
import 'package:flutter/material.dart';
import 'path_to_your_widget/progress_bar_win.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ProgressBarWin(),
    ),
  ));
}
