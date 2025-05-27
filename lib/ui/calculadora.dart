import 'package:flutter/material.dart';
import 'dart:math';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController valorController = TextEditingController();
  final TextEditingController mesesController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();

  double montanteTotal = 0.0;
  double totalSemJuros = 0.0;

  void calcularInvestimento() {
    double aporteMensal = double.tryParse(valorController.text) ?? 0.0;
    int numeroMeses = int.tryParse(mesesController.text) ?? 0;
    double taxa =
        double.tryParse(taxaController.text.replaceAll('%', '').trim()) ?? 0.0;
    double taxaMensal = taxa / 100;

    if (aporteMensal > 0 && numeroMeses > 0 && taxaMensal >= 0) {
      double montante =
          aporteMensal * (pow(1 + taxaMensal, numeroMeses) - 1) / taxaMensal;
      double semJuros = aporteMensal * numeroMeses;

      setState(() {
        montanteTotal = montante;
        totalSemJuros = semJuros;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira valores válidos!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF5EC),
      appBar: AppBar(
        title: const Text('Simulador de Investimentos / Erick'),
        backgroundColor: const Color(0xFF14532D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Investimento mensal:',
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                controller: valorController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text('Número de meses:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: mesesController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                'Taxa de juros ao mês:',
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                controller: taxaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 45, 34, 192),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  onPressed: calcularInvestimento,
                  child: const Text('Simular'),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Valor total sem juros: R\$ ${totalSemJuros.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Valor total com juros compostos: R\$ ${montanteTotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
