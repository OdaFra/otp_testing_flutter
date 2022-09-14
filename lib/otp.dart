import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const PinCodeVerificationScreen({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  // var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  //..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // onTapRecognizer = TapGestureRecognizer()
    //   ..onTap = () {
    //     Navigator.pop(context);
    //   };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/business-and-finance.png'),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Verificación del número de teléfono',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Ingrese el código enviado a ",
                      children: [
                        TextSpan(
                            text: "${widget.phoneNumber}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      // obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        // if (v!.length < 3) {
                        //   return "Validación";
                        // } else {
                        //   return null;
                        // }
                        if (v.toString().isEmpty || v!.length != 6) {
                          return "Por favor, introduzca un código válido";
                        }
                        return null;
                      },
                      dialogConfig: DialogConfig(
                          dialogTitle: "Pegar código",
                          dialogContent:
                              "¿Quieres pegar este código $currentText?",
                          affirmativeText: "Aceptar",
                          negativeText: "Cancelar"),
                      pinTheme: PinTheme(
                        inactiveFillColor: Colors.orange.shade100,
                        selectedColor: Colors.white,
                        inactiveColor: Colors.indigo,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.yellow,
                      ),
                      enablePinAutofill: true,
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completado");
                      },

                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Permitiendo pegar $text");
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError
                      ? "* Por favor llene todas las celdas correctamente"
                      : "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿No recibiste el código?",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => snackBar("OTP reenviado!!"),
                    child: const Text(
                      "Reenviar",
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 54, 42),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      print(currentText);
                      print(textEditingController);
                      formKey.currentState!.validate();
                      if (currentText.length != 6 || currentText.isEmpty) {
                        errorController!.add(ErrorAnimationType.shake);
                        setState(() => hasError = true);
                      } else {
                        setState(
                          () {
                            hasError = false;
                            snackBar("OTP Verificado!!");
                            print("OTP Verificado!!");
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      "Verificar".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: TextButton(
                    child: const Text("Limpiar"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  )),
                  Flexible(
                      child: TextButton(
                    child: const Text("Establecer código"),
                    onPressed: () {
                      setState(() {
                        textEditingController.text = "123456";
                      });
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
