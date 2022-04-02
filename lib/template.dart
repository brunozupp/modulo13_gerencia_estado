import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:modulo13_gerencia_estado/widgets/imc_gauge.dart';
import 'package:modulo13_gerencia_estado/widgets/imc_gauge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({ Key? key }) : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

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
        child: Column(
          children: [
            
            const ImcGauge(
              imc: 0,
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
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {}, 
              child: Text(
                "Calcular IMC",
              ),
            ),
          ],
        ),
      ),
    );
  }
}