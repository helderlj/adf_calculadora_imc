import 'dart:math';

import 'package:adf_calculadora_imc/streamBuilder/imc_state.dart';
import 'package:adf_calculadora_imc/streamBuilder/stream_builder_controller.dart';
import 'package:adf_calculadora_imc/widgets/imc_gauge_clock.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImcStreamBuilderPage extends StatefulWidget {
  const ImcStreamBuilderPage({super.key});

  @override
  State<ImcStreamBuilderPage> createState() => _ImcStreamBuilderPageState();
}

class _ImcStreamBuilderPageState extends State<ImcStreamBuilderPage> {
  final _formKey = GlobalKey<FormState>();

  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  final controller = ImcStreamBuilderController();

  var formatter =
      NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Buildou o stream builder");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calculo de IMC por Streams (Bloc Pattern)"),
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
                  StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      var imc = snapshot.data?.imc ?? 0;
                      return ImcGaugeClock(imc: imc);
                    },
                  ),
                  StreamBuilder(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      return Visibility(
                          visible: snapshot.data is ImcStateLoading,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    },
                  ),
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
                      onPressed: () {
                        var formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          var peso =
                              formatter.parse(_pesoController.text) as double;
                          var altura =
                              formatter.parse(_alturaController.text) as double;

                          controller.calcularImc(peso: peso, altura: altura);
                        }
                      },
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
