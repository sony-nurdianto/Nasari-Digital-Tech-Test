import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadi_flutter_test/blocs/auth_bloc/auth_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/todo');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {

          if(state is AuthLoading) {
            return const CircularProgressIndicator();
          } 
          return Center(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login_bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 1,
                            blurRadius: 1,
                            // offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    width: 75.w,
                    // height: ,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                           SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: TextField(
                                    controller: _usernameController,
                                    decoration: const InputDecoration(
                                      labelText: 'UserName',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 0.0),
                                      ),
                                      labelStyle: TextStyle(fontSize: 12.0),
                                    ),

                                    style: const TextStyle(fontSize: 12.0),
                                    // decoration: const InputDecoration(labelText: 'Username'),
                                  ),
                                ),
                                 SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 0.0),
                                      ),
                                      labelStyle: TextStyle(fontSize: 12.0),
                                    ),
                                    style: const TextStyle(fontSize: 12.0),
                                    // decoration: const InputDecoration(labelText: 'Password'),
                                  ),
                                ),
                                 SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String username = _usernameController.text;
                                      String password = _passwordController.text;
                                      context.read<AuthBloc>().add(AuthLogin(username: username, password: password));
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
