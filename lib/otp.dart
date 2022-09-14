import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_pincode_input_field/theme/app_theme.dart';
import 'package:otp_pincode_input_field/timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import 'main_container.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({
    Key? key,
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppTheme.colors.primaryColor,
          title: SvgPicture.asset(
            'assets/svgs/mowi-logo.svg',
          ),
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                barRadius: const Radius.circular(25),
                progressColor: AppTheme.colors.primaryColor,
                lineHeight: 8,
                percent: 0.7,
              ),
            ],
          ),
        ),
        backgroundColor: AppTheme.colors.primaryColor,
        body: MainContainer(
            bodyPadding: const EdgeInsets.all(15),
            child: Column(
              children: [
                AutoSizeText(
                  'Ingresar codigo',
                  style: AppTheme.styles.titleBold24
                      .copyWith(color: AppTheme.colors.primaryColor),
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: Color.fromRGBO(83, 46, 83, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        // obscuringCharacter: '*',
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
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
                          inactiveFillColor:
                              const Color.fromRGBO(234, 239, 243, 1),
                          selectedColor: Colors.white,
                          inactiveColor: const Color.fromRGBO(83, 46, 83, 1),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor:
                              const Color.fromRGBO(234, 239, 243, 1),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/reload.svg',
                        width: 20,
                      ),
                      const SizedBox(width: 10),
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
                ),
                // InkWell(
                //   onTap: (() =>
                //       print('volver a enviar la solicitud de codigo otp')),
                //   child: Container(
                //     margin: const EdgeInsets.only(top: 20, left: 5),
                //     child: Row(
                //       children: [
                //         SvgPicture.asset(
                //           'assets/svgs/reload.svg',
                //           width: 20,
                //         ),
                //         const SizedBox(width: 10),
                //         Text('Reenviar mensaje',
                //             style: AppTheme.styles.infoTextRegular14),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 5),
                    child: const TimerWatch()),
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
                const SizedBox(height: 20),

                const SizedBox(height: 14),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  decoration: BoxDecoration(
                    color: AppTheme.colors.primaryColor,
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
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.colors.primaryColor,
                      ),
                      child: const Text("Limpiar"),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    )),
                    Flexible(
                        child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.colors.primaryColor,
                      ),
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
            )));
  }
}
