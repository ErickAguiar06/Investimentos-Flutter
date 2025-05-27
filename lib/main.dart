import 'package:flutter/material.dart';
import 'package:myapp/ui/calculadora.dart'; // ajuste conforme seu nome de projeto

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Investimentos',
      home: Calculadora(),
    ),
  );
}
