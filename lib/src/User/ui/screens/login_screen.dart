import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tyba_test/src/User/bloc/user_cubit.dart';
import 'package:tyba_test/src/settings/routes.dart';
import 'package:tyba_test/src/utils/request_status.dart';
import 'package:tyba_test/src/utils/widgets/custom_button.dart';
import 'package:tyba_test/src/utils/widgets/custom_password_input.dart';
import 'package:tyba_test/src/utils/widgets/custom_text_input.dart';
import 'package:tyba_test/src/utils/widgets/loading.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _requiredValidator =
      RequiredValidator(errorText: 'Este campo es requerido');

  @override
  Widget build(BuildContext context) {
    print("Printing login");
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state.authStatus == AuthStatus.authenticated) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Inicio de sesión exitoso'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (Route<dynamic> route) => false);
        });
      }
      if (state.status == RequestStatus.failed) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((state.message ?? '').isNotEmpty
                  ? state.message!
                  : 'Ocurrió un error al iniciar sesión'),
              duration: const Duration(seconds: 4),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
              color: Colors.white,
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 36),
                      Text(
                        'Inicia sesión',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 36),
                      CustomTextInput(
                        name: "Email",
                        controller: _emailController,
                        validator: MultiValidator([
                          _requiredValidator,
                          EmailValidator(errorText: 'Email inválido')
                        ]),
                      ),
                      const SizedBox(height: 10),
                      CustomPasswordInput(
                        name: "Contraseña",
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 24),
                      if (state.status == RequestStatus.inProgress)
                        const Loading(),
                      if (state.status != RequestStatus.inProgress)
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: CustomButton(
                              text: "Entrar",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await BlocProvider.of<UserCubit>(context)
                                      .login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              }),
                        ),
                      const SizedBox(height: 10),
                      if (state.status != RequestStatus.inProgress)
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: CustomButton(
                              text: "Registrarse",
                              onlyText: true,
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.register);
                              }),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
