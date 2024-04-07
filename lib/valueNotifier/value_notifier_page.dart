import 'dart:math';

import 'package:adf_calculadora_imc/widgets/imc_gauge_clock.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImcValueNotifier extends StatefulWidget {
  const ImcValueNotifier({super.key});

  @override
  State<ImcValueNotifier> createState() => _ImcValueNotifierState();
}

class _ImcValueNotifierState extends State<ImcValueNotifier> {
  final _formKey = GlobalKey<FormState>();

  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  var imc = ValueNotifier(0.0);

  var formatter =
      NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  void _calcularImc() {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      var peso = formatter.parse(_pesoController.text) as double;
      var altura = formatter.parse(_alturaController.text) as double;
      imc.value = peso / pow(altura, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Buildou o change notifier");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Calculo de IMC por Value Notifier"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<double>(
                      valueListenable: imc,
                      builder: (_, imcValue, __) {
                        return ImcGaugeClock(imc: imcValue);
                      }),
                  ImcTextInput(
                    controller: _pesoController,
                    label: "Seu peso",
                  ),
                  ImcTextInput(
                    controller: _alturaController,
                    label: "Sua Altura",
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: _calcularImc,
                      child: const Text("Calcular IMC"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImcTextInput extends StatelessWidget {
  ImcTextInput({super.key, required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        CurrencyTextInputFormatter(
          locale: 'pt_BR',
          symbol: '',
          decimalDigits: 2,
          turnOffGrouping: true,
        )
      ],
      controller: controller,
      decoration: InputDecoration(label: Text(label)),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "$label obrigatorio";
        }
      },
    );
  }
}
