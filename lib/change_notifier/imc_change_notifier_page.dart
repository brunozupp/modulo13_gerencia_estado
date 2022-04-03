import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modulo13_gerencia_estado/change_notifier/imc_change_notifier_controller.dart';
import 'package:modulo13_gerencia_estado/widgets/imc_gauge.dart';

class ImcChangeNotifierPage extends StatefulWidget {
  const ImcChangeNotifierPage({ Key? key }) : super(key: key);

  @override
  State<ImcChangeNotifierPage> createState() => _ImcChangeNotifierPageState();
}

class _ImcChangeNotifierPageState extends State<ImcChangeNotifierPage> {

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final controller = ImcChangeNotifierController();

  @override
  void dispose() {

    pesoEC.dispose();
    alturaEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Notifier"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              AnimatedBuilder(
                animation: controller, 
                builder: (context, child) {
                  return ImcGauge(
                    imc: controller.imc,
                  );
                }
              ),
              
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: pesoEC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso',
                ),
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: "pt_BR",
                    symbol: "",
                    decimalDigits: 2,
                    turnOffGrouping: true,
                  ),
                ],
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Obrigatório";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: alturaEC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura',
                ),
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: "pt_BR",
                    symbol: "",
                    decimalDigits: 2,
                    turnOffGrouping: true,
                  ),
                ],
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Obrigatório";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final formValid = formKey.currentState?.validate() ?? false;

                  if(formValid) {
                    final formatter = NumberFormat.simpleCurrency(
                      locale: "pt_BR",
                      decimalDigits: 2
                    );

                    final peso = formatter.parse(pesoEC.text) as double;
                    final altura = formatter.parse(alturaEC.text) as double;

                    controller.calcularIMC(peso: peso, altura: altura);
                  }
                }, 
                child: const Text(
                  "Calcular IMC",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}