import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modulo13_gerencia_estado/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:modulo13_gerencia_estado/bloc_pattern/imc_state.dart';
import 'package:modulo13_gerencia_estado/change_notifier/imc_change_notifier_controller.dart';
import 'package:modulo13_gerencia_estado/widgets/imc_gauge.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({ Key? key }) : super(key: key);

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final controller = ImcBlocPatternController();

  @override
  void dispose() {

    pesoEC.dispose();
    alturaEC.dispose();

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Pattern"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              StreamBuilder<ImcState>(
                stream: controller.imcOut,
                builder: (context,snapshot) {
                  var imc = snapshot.data?.imc ?? 0.0;

                  return ImcGauge(
                    imc: imc,
                  );
                }
              ),
              
              const SizedBox(
                height: 20,
              ),

              StreamBuilder<ImcState>(
                stream: controller.imcOut,
                builder: (context,snapshot) {

                  // Criando essa variável para ter a autopromoção de tipo
                  final dataValue = snapshot.data;

                  if(dataValue is ImcStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(dataValue is ImcStateError) {
                    return Center(
                      child: Text(
                        dataValue.message,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                }
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