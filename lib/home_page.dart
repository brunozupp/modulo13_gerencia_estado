import 'package:flutter/material.dart';
import 'package:modulo13_gerencia_estado/bloc_pattern/imc_bloc_pattern_page.dart';
import 'package:modulo13_gerencia_estado/bloc_pattern_mine/imc_bloc_pattern_page_mine.dart';
import 'package:modulo13_gerencia_estado/change_notifier/imc_change_notifier_page.dart';
import 'package:modulo13_gerencia_estado/set_state/imc_set_state_page.dart';
import 'package:modulo13_gerencia_estado/value_notifier/imc_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImcSetStatePage());
              }, 
              child: const Text(
                "SetState",
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImcChangeNotifierPage());
              }, 
              child: const Text(
                "ChangeNotifier",
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImcValueNotifierPage());
              }, 
              child: const Text(
                "ValueNotifier",
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImcBlocPatternPage());
              }, 
              child: const Text(
                "StreamBuilder (Bloc Pattern)",
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImcBlocPatternPageMine());
              }, 
              child: const Text(
                "StreamBuilder (Bloc Pattern) Mine",
              ),
            ),
            const SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
  }

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}