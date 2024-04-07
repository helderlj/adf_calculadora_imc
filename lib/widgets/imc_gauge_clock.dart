import 'package:adf_calculadora_imc/widgets/imc_gauge_range.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeClock extends StatelessWidget {
  final double imc;

  const ImcGaugeClock({super.key, required this.imc});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.9,
          ranges: [
            ImcGaugeRange(
              color: Colors.deepPurple[200]!,
              start: 12.5,
              end: 18.5,
              label: "Magro",
            ),
            ImcGaugeRange(
              color: Colors.deepPurple[400]!,
              start: 18.5,
              end: 24.5,
              label: "Normal",
            ),
            ImcGaugeRange(
              color: Colors.deepPurple[500]!,
              start: 24.5,
              end: 29.9,
              label: "Sobrepeso",
            ),
            ImcGaugeRange(
              color: Colors.deepPurple[700]!,
              start: 29.9,
              end: 39.9,
              label: "Obesidade",
            ),
            ImcGaugeRange(
              color: Colors.deepPurple[900]!,
              start: 39.9,
              end: 47.9,
              label: "Obesidade Severa",
            ),
          ],
          pointers: [
            NeedlePointer(
              enableAnimation: true,
              value: imc,
            )
          ],
        ),
      ],
    );
  }
}
