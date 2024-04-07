import 'package:adf_calculadora_imc/changeNotifier/change_notifier_page.dart';
import 'package:adf_calculadora_imc/setState/imc_setstate_page.dart';
import 'package:adf_calculadora_imc/streamBuilder/stream_builder_page.dart';
import 'package:adf_calculadora_imc/valueNotifier/value_notifier_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TypeButton(
              text: "SetState",
              onPressed: () => _goToPage(context, const ImcSetState()),
            ),
            TypeButton(
              text: "ValueNotifier",
              onPressed: () => _goToPage(context, const ImcValueNotifier()),
            ),
            TypeButton(
              text: "ChangeNotifier",
              onPressed: () =>
                  _goToPage(context, const ImcChangeNotifierPage()),
            ),
            TypeButton(
              text: "Bloc Pattern",
              onPressed: () => _goToPage(context, const ImcStreamBuilderPage()),
            ),
          ],
        ),
      ),
    );
  }
}

class TypeButton extends StatelessWidget {
  final String text;
  final dynamic onPressed;
  const TypeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 175,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
