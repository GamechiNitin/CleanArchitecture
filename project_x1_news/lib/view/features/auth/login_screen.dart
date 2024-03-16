import 'package:flutter/material.dart';
import 'package:project_x1_news/utils/app_assets.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/utils/app_string.dart';
import 'package:project_x1_news/utils/dimens.dart';
import 'package:project_x1_news/utils/helper.dart';
import 'package:project_x1_news/view/widget/button_widget.dart';
import 'package:project_x1_news/view/widget/social_button.dart';
import 'package:project_x1_news/view/widget/textform_widget.dart';
import 'package:project_x1_news/view/widget/welcome_widget.dart';
import 'package:shimmer/shimmer.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailIdFn = FocusNode();
  FocusNode passwordFn = FocusNode();
  FocusNode userNameFn = FocusNode();

  String? emailErrorText;
  String? passwordErrorText;
  String? userNameErrorText;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool obscureText = true;

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    passwordFn.unfocus();
    emailIdController.clear();
    passwordController.clear();
    emailIdFn.unfocus();
    super.dispose();
  }

  void gotoForgotPasswordScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ForgotPasswordPage(
    //       email: emailIdController.text.trim(),
    //     ),
    //   ),
    // );
  }

  void gotoSignUpPage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SignUpPage(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (c) => const NavBarPage()),
              //   (route) => false,
              // );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: size16,
                  color: kBlackColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding:
                const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 60),
            children: [
              const WelcomeWidget(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormWidget(
                      textInputAction: TextInputAction.next,
                      controller: emailIdController,
                      focusNode: emailIdFn,
                      label: 'Enter email ',
                      hint: 'Ex. dash@gmail.com',
                      prefixIcon: Icons.email,
                      errorText: emailErrorText,
                      onEditingComplete: () {
                        if (emailIdController.text.isEmpty) {
                          emailErrorText = 'Enter the Email Id';
                        } else if (!emailIdController.text.contains('@') ||
                            !emailIdController.text.contains('.')) {
                          emailErrorText = 'Enter valid the email';
                        } else {
                          emailErrorText = null;
                        }
                        _notify();
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          emailErrorText = 'Enter the Email Id';
                          return emailErrorText;
                        } else if (!val.contains('@') || !val.contains('.')) {
                          emailErrorText = 'Enter valid the email';
                          return emailErrorText;
                        } else {
                          emailErrorText = null;
                          return emailErrorText;
                        }
                      },
                      onChanged: (val) {
                        if (val.isEmpty) {
                          emailErrorText = 'Enter the Email Id';
                        } else if (!val.contains('@') || !val.contains('.')) {
                          emailErrorText = 'Enter valid the email';
                        } else {
                          emailErrorText = null;
                        }
                        _notify();
                      },
                    ),
                    const SizedBox(height: testFeildPadding),
                    TextFormWidget(
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      controller: passwordController,
                      focusNode: passwordFn,
                      label: 'Enter Password',
                      hint: "Ex. Dash@123",
                      prefixIcon: Icons.lock,
                      suffixIcon:
                          obscureText ? Icons.visibility : Icons.visibility_off,
                      obscureText: obscureText,
                      errorText: passwordErrorText,
                      onSuffixIxonTap: () {
                        obscureText = !obscureText;
                        _notify();
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return passwordErrorText =
                              AppString.passwordIsEmptyValidation;
                        } else if (!Helper.validatePassowrd(val)) {
                          return passwordErrorText =
                              AppString.passwordValidation;
                        } else if (val.length < 8) {
                          return passwordErrorText =
                              AppString.passwordLengthValidation;
                        } else {
                          passwordErrorText = null;
                          return passwordErrorText;
                        }
                      },
                      onChanged: (val) {
                        if (val.isEmpty) {
                          passwordErrorText =
                              AppString.passwordIsEmptyValidation;
                        } else if (!Helper.validatePassowrd(val)) {
                          passwordErrorText = AppString.passwordValidation;
                        } else if (val.length < 8) {
                          passwordErrorText =
                              AppString.passwordLengthValidation;
                        } else {
                          passwordErrorText = null;
                        }
                        _notify();
                      },
                      onEditingComplete: () {
                        if (passwordController.text.isEmpty) {
                          passwordErrorText =
                              AppString.passwordIsEmptyValidation;
                        } else if (!Helper.validatePassowrd(
                            passwordController.text.trim())) {
                          passwordErrorText = AppString.passwordValidation;
                        } else if (passwordController.text.length < 8) {
                          passwordErrorText =
                              AppString.passwordLengthValidation;
                        } else {
                          passwordErrorText = null;
                          passwordFn.unfocus();
                        }
                        _notify();
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        gotoForgotPasswordScreen();
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: size14,
                            color: kBlueColor,
                          ),
                        ),
                      ),
                    ),
                    ButtonWidget(
                      margin: const EdgeInsets.symmetric(
                          vertical: testFeildPadding),
                      text: 'Log In',
                      onTap: () {
                        passwordFn.unfocus();
                        _formKey.currentState?.validate();
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // UserModel userModel = UserModel(
                          //   email: emailIdController.text.trim(),
                          //   password: passwordController.text.trim(),
                          // );
                          // logInBloc.add(LogInToAccountEvent(userModel));
                        }
                      },
                    ),
                    Text(
                      'or',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),

                    // Social Button
                    const SocialButtonWidget(
                      label: "Login with Google",
                      assetsPath: DashAssets.google,
                    ),
                    const SizedBox(height: 20),
                    const SocialButtonWidget(
                      label: "Login with Apple",
                      assetsPath: DashAssets.appleLogo,
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        gotoSignUpPage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Shimmer.fromColors(
                            baseColor: kSecondaryColor,
                            highlightColor: Colors.lightGreenAccent,
                            child: Text(
                              "Create Account",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: kBlueColor,
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
