import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/shared/ui_helpers.dart';
import 'package:teukoo_code/UI/widgets/my_material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/busy_button.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/input_field.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/text_link.dart';
import 'package:teukoo_code/service_locator.dart';
import 'package:teukoo_code/services/authentication_service.dart';
import 'package:teukoo_code/viewmodels/login_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
        viewModel: LoginViewModel(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: MyColor.primaryBackground,
            body: SingleChildScrollView(
                child: InkWell(
                    onTap: (() =>
                        {FocusScope.of(context).requestFocus(FocusNode())}),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SafeArea(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    height: 150,
                                    child: Image.asset("assets/Logo_app.png"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: InputField(
                                    placeholder: 'Email',
                                    controller: emailController,
                                  ),
                                ),
                                verticalSpaceSmall,
                                InputField(
                                  placeholder: 'Password',
                                  maxLines: 1,
                                  password: true,
                                  controller: passwordController,
                                ),
                                verticalSpaceMedium,
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BusyButton(
                                      title: 'Login',
                                      busy: model.busy,
                                      onPressed: () {
                                        model.login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                verticalSpaceMedium,
                                TextLink(
                                  'Forgot Password?',
                                  onPressed: ()  async{
                                    _authenticationService.resetPassword(emailController.text);
                                  },
                                ),
                                verticalSpaceLarge,
                                TextLink(
                                  'Sign Up',
                                  onPressed: () {
                                    model.navigateToSignUp();
                                  },
                                ),
                              ]),
                        ))))));
  }
}
