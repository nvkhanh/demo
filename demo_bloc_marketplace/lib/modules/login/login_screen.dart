import 'package:demo_bloc_marketplace/utils/resources.dart';
import 'package:demo_bloc_marketplace/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/app_text_field.dart';
import '../marketplace/marketplace_screen.dart';
import 'login_bloc.dart';
import 'login_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final apiRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(apiRepository),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MarketplaceScreen(),
            ));
          } else if (state is LoginFailure) {
            Utils.showDefaultDialog(
                context, const Text("Error"), Text(state.error));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(Resources.logoMarketplace),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppTextField(
                              controller: _usernameTextController,
                              hintText: "Username",
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AppTextField(
                              controller: _passwordTextController,
                              hintText: "Password",
                              textInputAction: TextInputAction.go,
                              obscureText: true,
                              onSubmitted: (password) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    RequestLoginEvent(
                                        _usernameTextController.text,
                                        _passwordTextController.text));
                              },
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      RequestLoginEvent(
                                          _usernameTextController.text,
                                          _passwordTextController.text));
                                },
                                child: const Text("Sign In"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              state is LoginLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
