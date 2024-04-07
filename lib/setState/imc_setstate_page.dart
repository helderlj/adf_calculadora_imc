import 'dart:math';

import 'package:adf_calculadora_imc/widgets/imc_gauge_clock.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImcSetState extends StatefulWidget {
  const ImcSetState({super.key});

  @override
  State<ImcSetState> createState() => _ImcSetStateState();
}

class _ImcSetStateState extends State<ImcSetState> {
  final _formKey = GlobalKey<FormState>();

  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  double imc = 0.0;

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

      setState(() {
        imc = peso / pow(altura, 2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Buildou o set state");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Calculo de IMC por setState"),
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
                  ImcGaugeClock(imc: imc),
                  ImcTextInput(
                    controller: _pesoController,
                    label: "Seu peso",
                  ),
                  ImcTextInput(
                    controller: _alturaController,
                    label: "Sua Altura",
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: _calcularImc, child: Text("Calcular IMC"))
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
