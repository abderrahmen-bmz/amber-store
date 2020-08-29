import 'package:amber_store/app/sign_in/sign_in_button.dart';
import 'package:amber_store/common_widgets/platform_exception_alert_dialog.dart';
import 'package:amber_store/services/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInGoogle(BuildContext context) async {
     final auth = Provider.of<AuthBase>(context,listen: false);
    try {
        await auth.signInWithGoogle();
        print("You are pass succee...");
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amber Store'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              SizedBox(
                height: 50.0,
                child: _buildHeader(context),
              ),
              SignInButton(
                assetName: 'assets/icons/google-logo.png',
                text: 'Sign in with Google ',
                color: Colors.white,
                textColor: Colors.black87,
                onPressed: () => _signInGoogle(context),
              ),
              SizedBox(height: 8.0),
              SignInButton(
                assetName: 'assets/icons/facebook-logo.png',
                text: 'Sign in with Facebook',
                textColor: Colors.white,
                color: Color(0xFF334D92),
                onPressed: () {},
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
