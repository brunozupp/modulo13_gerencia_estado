import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modulo13_gerencia_estado/widgets/imc_gauge.dart';
import 'package:modulo13_gerencia_estado/widgets/imc_gauge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcSetStatePage extends StatefulWidget {
  const ImcSetStatePage({ Key? key }) : super(key: key);

  @override
  State<ImcSetStatePage> createState() => _ImcSetStatePageState();
}

class _ImcSetStatePageState extends State<ImcSetStatePage> {

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var imc = 0.0;

  void _calcularIMC({
    required double peso,
    required double altura,
  }) async {

    setState(() {
      imc = 0;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      imc = peso / pow(altura, 2);
    });
  }

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
        title: const Text("SetState"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              
              ImcGauge(
                imc: imc,
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

                    _calcularIMC(peso: peso, altura: altura);
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