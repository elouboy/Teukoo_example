import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:teukoo_code/UI/shared/ui_helpers.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/busy_button.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/expansion_list.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/input_field.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/text_link.dart';
import 'package:teukoo_code/constants/route_names.dart';
import 'package:teukoo_code/service_locator.dart';
import 'package:teukoo_code/services/dialog_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';
import 'package:teukoo_code/viewmodels/signup_view_model.dart';

class SignUP extends StatefulWidget {
  SignUP({Key key}) : super(key: key);

  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  bool _checkBoxVal = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: MyColor.primaryBackground,
        body: SingleChildScrollView(
          child: InkWell(
            onTap: (() => {FocusScope.of(context).requestFocus(FocusNode())}),
            child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child:Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(top: 50),
                  child:Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 38, color: Color(0xFFFFFFFF)),
                  ),
                  ),
                  
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Email',
                    controller: emailController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Password',
                    password: true,
                    maxLines: 1,
                    controller: passwordController,
                    additionalNote:
                        'Password has to be a minimum of 6 characters.',
                  ),
                  verticalSpaceSmall,
                  ExpansionList<int>(
                    items:  [13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60],
                    title: 'age', 
                    onItemSelected: model.setSelectedage,
                     ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        activeColor: MyColor.nextCamera,
                        checkColor: MyColor.closeCamera,
                        focusColor: Color(0xFFFFFFFF),
                        onChanged: (bool value ) {
                          setState(() => this._checkBoxVal = value);
                        },
                        value: this._checkBoxVal,
                      ),
                      TextLink(
                        'Terms of Use',
                        onPressed: () { _navigationService.navigateTo(TermsRoute);},
                      ),
                      Spacer(flex: 1),
                      Text("and",
                          style: TextStyle(
                            color: Color(0xFF696969),
                            fontSize: 11,
                          )),
                      Spacer(flex: 1),
                      TextLink(
                        'Private Policy',
                        onPressed: () {
                           _navigationService.navigateTo(PrivateRoute);
                        },
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BusyButton(
                        title: 'Sign Up',
                        busy: model.busy,
                        onPressed: () {
                         
                            if (_checkBoxVal) {
                            model.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          } else {
                            _dialogService.showDialog(
                              title: 'Sign Up Failure',
                              description:
                                  'Accept Terms of use And the Private policy',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  Center(
                    child: TextLink(
                      'Login',
                      onPressed: () {
                        model.navigateToLogin();
                      },
                    ),
                  ),
                  
                ],
              ),
            
            ),
          ),
        ),
      ),
      ),
    );
  }
}
