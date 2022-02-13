import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/text/locale_text.dart';
import 'package:first_three/core/components/widgets/buttons/cancel_button.dart';
import 'package:first_three/core/components/widgets/buttons/text_button.dart';
import 'package:first_three/core/components/widgets/dialogs/default_dialog.dart';
import 'package:first_three/core/components/widgets/input_widgets/login_inputters.dart';
import 'package:first_three/core/components/widgets/buttons/sign_button.dart';
import 'package:first_three/core/components/widgets/others/animated_label.dart';
import 'package:first_three/core/constants/app/app_constants.dart';
import 'package:first_three/core/init/lang/locale_keys.g.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/view/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  bool isKeyboardHide = true;
  double keyboardHeight = 100;

  final focusNodeLoginPhone = FocusNode();
  final focusNodeRegisterPhone = FocusNode();
  final focusNodeRegisterName = FocusNode();
  TextStyle labelStyleSmall =
      GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: FontWeight.w300);
  TextStyle labelStyleBig =
      GoogleFonts.ibmPlexSans(fontSize: 19, fontWeight: FontWeight.w500);

  void errorDialog(String e) {
    showDialog(
        context: context,
        builder: (context) {
          return DefaultDialog(
            height: dynamicHeight(0.4),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                e,
                style: const TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            buttons: [
              CancelButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  size: const Size(150, 80))
            ],
          );
        });
  }

  late LoginViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom >= keyboardHeight - 1) {
      keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

      isKeyboardHide = false;
    }
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      isKeyboardHide = true;
    }

    return BaseView(
        viewModel: LoginViewModel(),
        onModelReady: (model) {
          viewModel = model as LoginViewModel;
          viewModel.setContext(this.context);
        },
        onPageBuilder: (context, value) => scaffold);
  }

  Widget get scaffold => Scaffold(
        body: body,
      );

  PreferredSizeWidget get appbar => AppBar(
        // ignore: prefer_const_constructors
        title: LocalText(value: LocaleKeys.welcome),
      );

  Widget get floatActionButton => FloatingActionButton(
        onPressed: () {
          viewModel.number++;
        },
        child: const Icon(Icons.add),
      );

  Widget get body {
    return Stack(children: [
      background,
      foreground,
    ]);
  }

  Widget get background => Container(
        padding: EdgeInsets.only(
            bottom: dynamicHeight(0.65),
            left: dynamicWidth(0.1),
            right: dynamicWidth(0.1),
            top: dynamicHeight(0.1)),
        child: SizedBox(
          width: dynamicWidth(1),
          child: SafeArea(child:
           Image.asset(ApplicationConstants.APP_ICON_PATH, color: ThemeData().primaryColor)),
        ),
      );

  Widget get foreground => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 500,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: tabs,
        ),
      );

  Widget get tabsAndLogo => Stack(
        children: [
          tabs,
          animatedLogo,
        ],
      );

  Widget get tabs => DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              width: dynamicWidth(0.5) + 100,
              child: TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: GoogleFonts.ibmPlexSans(
                      fontSize: 19, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: GoogleFonts.ibmPlexSans(
                      fontSize: 19, fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(text: "giriş"),
                    Tab(text: "kayıt"),
                  ]),
            ),
            formFields
          ],
        ),
      );
  Widget get animatedLogo => AnimatedContainer(
        width: isKeyboardHide ? 0 : 150,
        height: isKeyboardHide ? 0 : 70,
        alignment: Alignment.topCenter,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
        //color: Colors.red,
           child: SafeArea(child:
           Image.asset(ApplicationConstants.APP_ICON_PATH, color: Colors.white)),
      );

  Widget get formFields => Expanded(
        child: TabBarView(
          children: [loginForm, registerForm],
        ),
      );

  Widget get loginForm => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          animatedLogo,
          const SizedBox(
            height: 8,
          ),
          label("telefon numarası"),
          const SizedBox(
            height: 8,
          ),
          LoginInputters(
            controller: viewModel.phoneNumberLogin,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButon(
                text: "şifremi unuttum",
              ),
              SizedBox(
                  height: 100,
                  width: 180,
                  child: SignButton(
                    text: "Giriş",
                    onTap: () async {
                      try {
                        await viewModel.loginRequest(UserModel(
                          name: "",
                          phone: viewModel.phoneNumberLogin.text,
                          joinedOperations: [],
                        ));
                      } catch (e) {
                        errorDialog(e.toString());
                      }
                    },
                  ))
            ],
          )
        ]),
      );

  Widget get registerForm => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          animatedLogo,
          const SizedBox(
            height: 8,
          ),
          label("telefon numarası"),
          const SizedBox(
            height: 8,
          ),
          LoginInputters(controller: viewModel.phoneNumberRegister),
          const SizedBox(
            height: 8,
          ),
          label("ad soyad"),
          const SizedBox(
            height: 8,
          ),
          LoginInputters(
            controller: viewModel.nameController,
            textInputType: TextInputType.name,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButon(
                text: "şifremi unuttum",
              ),
              SizedBox(
                  height: 100,
                  width: 180,
                  child: SignButton(
                    text: "Kayıt",
                    onTap: () async {
                      try {
                        await viewModel.registerRequest(UserModel(
                            joinedOperations: [],
                            name: viewModel.nameController.text,
                            phone: viewModel.phoneNumberRegister.text));
                        await viewModel.loginRequest(UserModel(
                            joinedOperations: [],
                            name: viewModel.nameController.text,
                            phone: viewModel.phoneNumberRegister.text));
                      } catch (e) {
                        errorDialog(e.toString());
                      }
                    },
                  ))
            ],
          )
        ]),
      );
  Widget label(String text) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: AnimetedLabel(
            text: text,
            textStyle: isKeyboardHide ? labelStyleSmall : labelStyleBig));
  }
}
