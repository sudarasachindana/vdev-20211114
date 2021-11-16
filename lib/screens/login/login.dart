import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdev_test_project/constants/assets.dart';
import 'package:vdev_test_project/data/sharedpref/constants/preferences.dart';
import 'package:vdev_test_project/stores/form/form_store.dart';
import 'package:vdev_test_project/stores/user/user_store.dart';
import 'package:vdev_test_project/utils/device/device_utils.dart';
import 'package:vdev_test_project/utils/routes/routes.dart';
import 'package:vdev_test_project/widgets/app_icon_widget.dart';
import 'package:vdev_test_project/widgets/empty_app_bar_widget.dart';
import 'package:vdev_test_project/widgets/progress_indicator_widget.dart';
import 'package:vdev_test_project/widgets/rounded_button_widget.dart';
import 'package:vdev_test_project/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late UserStore _userStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    _buildContent(),
                  ],
                )
              : Center(child: _buildContent()),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }


  Widget _buildContent() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            SizedBox(height: 30.0),
            _buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return Row(
          children: [
            // email label
            Expanded(
              flex: 1,
                child: Text('Email :')),

            // email textField
            Expanded(
              flex: 2,
              child: TextFieldWidget(
                hint: 'Enter user email',
                inputType: TextInputType.emailAddress,
                icon: Icons.person,
                iconColor:  Colors.black54,
                textController: _userEmailController,
                inputAction: TextInputAction.next,
                autoFocus: false,
                onChanged: (value) {
                  _store.setUserId(_userEmailController.text);
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                errorText: _store.formErrorStore.userEmail,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return Row(
          children: [

            // password label
            Expanded(
              flex: 1,
                child: Text('Password :')),

            //password field
            Expanded(
              flex: 2,
              child: TextFieldWidget(
                hint:'Enter password',
                isObscure: true,
                padding: EdgeInsets.only(top: 16.0),
                icon: Icons.lock,
                iconColor:  Colors.black54,
                textController: _passwordController,
                focusNode: _passwordFocusNode,
                errorText: _store.formErrorStore.password,
                onChanged: (value) {
                  _store.setPassword(_passwordController.text);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSignInButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: RoundedButtonWidget(
        buttonText: 'Sign-In',
        buttonColor: Colors.blueAccent.shade200,
        textColor: Colors.black,
        onPressed: () async {
          if (_store.canLogin) {
            DeviceUtils.hideKeyboard(context);
            _store.login();
          } else {
            _showErrorMessage('Please fill in all fields');
          }
        },
      ),
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    _userStore.setLoggedUser(_store.userEmail);
    _userStore.setLoggedTimeStamp(dateTimeToString(DateTime.now()));


    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: 'Error',
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat('MMM-dd – hh:mm a').format(dateTime);
    return formattedDate;
  }

}