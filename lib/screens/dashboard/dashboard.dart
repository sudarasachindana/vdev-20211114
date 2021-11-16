import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdev_test_project/data/sharedpref/constants/preferences.dart';
import 'package:vdev_test_project/stores/category/category_store.dart';
import 'package:vdev_test_project/stores/user/user_store.dart';
import 'package:vdev_test_project/utils/routes/routes.dart';
import 'package:vdev_test_project/widgets/progress_indicator_widget.dart';
import 'package:vdev_test_project/widgets/rounded_button_widget.dart';

class Dashboard extends StatefulWidget {


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //stores:---------------------------------------------------------------------
  late CategoryStore _categoryStore;
  late UserStore _userStore;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores using provider
    _categoryStore = Provider.of<CategoryStore>(context);
    _userStore = Provider.of<UserStore>(context);

    // check to see if already called api
    if (!_categoryStore.loading) {
      _categoryStore.getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Product Categories'),
    );
  }



  Widget _buildSignOutButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          //logged user text
          Observer(
            builder: (context) {
              return Text(_userStore.currentUserEmail);
            },
          ),



          // sign-out button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: RoundedButtonWidget(
              buttonText: 'Sign-Out',
              buttonColor: Colors.blue.shade300,
              textColor: Colors.black,
              onPressed: () {
                SharedPreferences.getInstance().then((preference) {
                  preference.setBool(Preferences.is_logged_in, false);
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTittle() {
    // header tittle
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text('Product Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    );
  }

  Widget _buildSignInAtText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // sign at lable
          Text('Sign-In at : ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

          // sign in timeStamp
          Text(_userStore.loggedTimeStamp),

        ],
      ),
    );
  }


  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _categoryStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return Container(
      child: Column(
        children: [

          _buildSignOutButton(),

          _buildHeaderTittle(),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _categoryStore.categoryModelList != null
                  ? ListView.separated(
                      itemCount: _categoryStore.categoryModelList!.categoryList!.length,
                      separatorBuilder: (context, position) {
                        return Divider();
                      },
                      itemBuilder: (context, position) {
                        return _buildListItem(position);
                      },
                    )
                  : Center(
                      child: Text(
                        'Not Found Category to Display',
                      ),
                    ),
            ),
          ),


          _buildSignInAtText(),



        ],
      ),
    );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_categoryStore.categoryModelList?.categoryList?[position].title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        '${_categoryStore.categoryModelList?.categoryList?[position].body}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_categoryStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_categoryStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: 'Error',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }




}
