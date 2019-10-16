import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText = "Informe seus dados!";
  int _radioGroup;
  double imc;
  String _result = "0.0";
  int val;
  Color corCerta = Colors.blue;

  GlobalKey<FormState> _chaveGlobal = GlobalKey<FormState>();

  TextEditingController pesoController = TextEditingController();

  TextEditingController alturaController = TextEditingController();

  void _calculate() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    imc = peso / (altura * altura);
    setState(() {
      switch (_radioGroup) {
        case 0:
          _mulherForma();
          break;
        case 1:
          _homemForma();
          break;
      }
    });
  }

  void _mulherForma() {
    setState(() {
      if (imc < 19.1) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.green;
        _infoText = "Abaixo do peso!";
      } else if (imc >= 19.1 && imc < 25.8) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.purpleAccent;
        _infoText = "Peso ideal!";
      } else if (imc >= 25.8 && imc < 27.3) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.lime;
        _infoText = "Levemente acima do peso!";
      } else if (imc >= 27.3 && imc < 32.3) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.indigo;
        _infoText = "Obeso 1!.";
      } else {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.red;
        _infoText = "Obeso 2!";
      }
    });
  }

  void _homemForma() {
    setState(() {
      if (imc < 20.7) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.green;
        _infoText = "Abaixo do peso!";
      } else if (imc >= 20.7 && imc < 26.4) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.purpleAccent;
        _infoText = "Peso ideal! ";
      } else if (imc >= 26.4 && imc < 27.8) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.lime;
        _infoText = "Levemente acima do peso!";
      } else if (imc >= 27.8 && imc < 31.1) {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.indigo;
        _infoText = "Obeso 1!";
      } else {
        _result = "${imc.toStringAsPrecision(3)}";
        corCerta = Colors.red;
        _infoText = "Obeso 2!";
      }
    });
  }

  void _selectedRadio(val) {
    setState(() {
      _radioGroup = val;
    });
  }

  void _resetFields() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _result = "0.0";
      _infoText = "Informe seus dados!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _chaveGlobal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 100.0, color: Colors.blue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        activeColor: Colors.pink,
                        groupValue: _radioGroup,
                        onChanged: _selectedRadio,
                      ),
                      Text(
                        "Mulher",
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                      Radio(
                        value: 1,
                        activeColor: Colors.lightBlueAccent,
                        groupValue: _radioGroup,
                        onChanged: _selectedRadio,
                      ),
                      Text(
                        "Homem",
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25),
                    controller: pesoController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.blue),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                      controller: alturaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura!";
                        }
                      }),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: _calculate,
                            child: Text(
                              "Calcular IMC",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                            color: Colors.blue,
                          ))),
                  Text(_result,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold)),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: corCerta,
                        fontSize: 20.0,
                      ))
                ],
              ),
            )));
  }
}
