import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/text/locale_text.dart';
import 'package:first_three/core/components/widgets/buttons/sign_button.dart';
import 'package:first_three/core/init/lang/locale_keys.g.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/view/otp_sign/otp_sign_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpSignView extends StatefulWidget {
  const OtpSignView({
    Key? key,
  }) : super(key: key);

  @override
  _OtpSignViewState createState() => _OtpSignViewState();
}

class _OtpSignViewState extends BaseState<OtpSignView> {
  late OtpSignViewModel viewModel;
  TextEditingController pinPutController = TextEditingController();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: OtpSignViewModel(),
        onModelReady: (model) {
          viewModel = model as OtpSignViewModel;
          viewModel.setContext(this.context);
          viewModel.userModel =
              ModalRoute.of(context)!.settings.arguments as UserModel;
          viewModel.phoneVerification();
        },
        onPageBuilder: (context, value) => scaffold);
  }

  Widget get scaffold => Scaffold(appBar: appbar, body: body);
  PreferredSizeWidget get appbar =>
      AppBar(title: const LocalText(value: LocaleKeys.first_page));
  Widget get body => Stack(
        children: [
          Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  nameText,
                  phoneNumberText,
                  inputPin,
                  const SizedBox(
                    height: 20,
                  ),
                  timerAndButtonRow,
                ],
              )),
          autoFillPopUp
        ],
      );
  Widget get autoFillPopUp => Observer(builder: (context) {
        return Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: AnimatedContainer(
              //  padding: EdgeInsets.all(10),
              height: viewModel.smsCode != null ? 120 : 0,
              width: double.infinity,
              duration: const Duration(milliseconds: 200),
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                        "sms kodunuzun otomatik doldurulmasını istiyor musunuz? SMS kodunuz: ${viewModel.smsCode}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              viewModel.smsCode = null;
                            },
                            child: const Text("red")),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.completeAutoLogin();
                            },
                            child: const Text("onay")),
                      ],
                    )
                  ],
                ),
              ),
            ));
      });

  Widget get timerAndButtonRow => SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            countDownTimer,
            SizedBox(
                height: 90,
                width: 150,
                child: SignButton(
                  text: "Giriş",
                  onTap: () {
                    viewModel.manuelLogin(pinPutController.text);
                  },
                ))
          ],
        ),
      );

  Widget get countDownTimer => CircularCountDownTimer(
        duration: 120,
        initialDuration: 0,
        controller: CountDownController(),
        width: 90,
        height: 90,
        ringColor: Colors.grey,
        ringGradient: null,
        fillColor: Colors.white,
        fillGradient: null,
        backgroundColor: Theme.of(context).primaryColor,
        backgroundGradient: null,
        strokeWidth: 5.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.MM_SS,
        isReverse: true,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        onStart: () {
          // ignore: todo
          //TODO start
        },
        onComplete: () {
          // ignore: avoid_print
          print('Countdown Ended');
        },
      );

  Widget get inputPin => SizedBox(
        width: 300,
        child: PinPut(
          keyboardType: TextInputType.number,
          fieldsCount: 6,
          textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
          eachFieldWidth: 40.0,
          eachFieldHeight: 55.0,
          // focusNode: _pinPutFocusNode,
          controller: pinPutController,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: pinPutDecoration,
          followingFieldDecoration: pinPutDecoration,
          pinAnimationType: PinAnimationType.fade,
          onSubmit: (pin) async {},
        ),
      );

  Widget get phoneNumberText => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: dynamicWidth(0.1), vertical: 10),
        child: const Text(
          '5***** 0208 no\' lu telefonunuza gönderilen sms şifresini giriniz',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black87),
        ),
      );

  Widget get nameText => const Text(
        'Sayın Onur Can Kurum',
        style: TextStyle(
            fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black87),
      );
}
