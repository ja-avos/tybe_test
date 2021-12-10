import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_test/src/User/bloc/user_cubit.dart';
import 'package:tyba_test/src/settings/routes.dart';
import 'package:tyba_test/src/utils/request_status.dart';
import 'package:tyba_test/src/utils/widgets/custom_text_input.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state.authStatus != AuthStatus.authenticated) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.login,
            (Route<dynamic> route) => false,
          );
        });
      }
      if (state.status == RequestStatus.failed) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ocurrió un error'),
              duration: Duration(seconds: 4),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
      _nameController.text = state.user?.name ?? "NA";
      _emailController.text = state.user?.email ?? "NA";
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Perfil',
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextInput(
                    name: "Nombre",
                    controller: _nameController,
                    editable: false,
                  ),
                  CustomTextInput(
                    name: "Email",
                    controller: _emailController,
                    editable: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cerrar sesión",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<UserCubit>(context).logout();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
