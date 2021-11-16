# V-Dev Test Project

This test project created in flutter using MobX and Provider. V-Dev Test Project supports both Android and IOS. According to the test guidelines, First of all have to mention answers to the requested questions.

##### Q1. Using the terminal(command line/shell), initialize a Gitrepository in this directory
```
git init
```
##### Q2. Using the terminal, add the README.md file to the repo.
```
git add README.md
```

##### Q3. Make the first commit with the message “Empty project with README”
```
git commit -m "Empty project with README"
```

##### Q4.  Add the repository on GitHub as a remote to your local repository
```
git remote add origin https://github.com/sudarasachindana/vdev-20211114.git
```

##### Q5. Push the commits in your local repo to the remote repo on GitHub
```
git push -u origin main
```

## Getting Started
This project contains the minimal implementation required to user login and fetch data from rest API. The repository code is included with some basic components like basic app architecture, constants and required dependencies. 

## How to Use
##### Step 01:
Download or clone this repo by using the link below:
```
https://github.com/sudarasachindana/vdev-20211114
```

##### Step 02:
Go to project root and execute the following command in console to get the required dependencies:
```
flutter pub get 
```

##### Step 03:

This project uses `inject` library that works with code generation, execute the following command to generate files:
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```
or watch command in order to keep the source code synced automatically:
```
flutter packages pub run build_runner watch
```
## Hide Generated Files

n-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:
```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:
```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```
## Project Key Features:

+ Login
+ Dashboard
+ Routing
+ Dio
+ Database
+ MobX (to connect the reactive data of your application with the UI)
+ Provider (State Management)
+ Encryption
+ Validation
+ Code Generation
+ User Notifications
+ Dependency Injection

## Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```
Here is the folder structure I have been using in this project

```
lib/
|- constants/
|- data/
|- models/
|- screens/
|- utils/
|- stores/
|- widgets/
|- main.dart
|- routes.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
3- models – Contains all the plain data models.
4- stores - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI. 
5- screens — Contains all the ui of your project, contains sub directory for each screen.
6- util — Contains the utilities/common functions of your application.
7- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
8- routes.dart — This file contains all the routes for your application.
9- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

## Constants
This directory contains all the application level constants. A separate file is created for each type as shown in example below:
```
constants/
|- app_theme.dart
|- dimens.dart
|- endpoints.dart
|- preferences.dart
|- strings.dart
```

## Data
All the business logic of your application will go into this directory, it represents the data layer of your application. It is sub-divided into three directories `local`, `network` and `sharedperf`, each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.
```
data/
|- local/
    |- constants/
    |- datasources/
   
|- network/
    |- constants/
    |- exceptions/
    |- rest_client.dart
    
|- sharedpref
    |- constants/
    |- shared_preference_helper.dart
    
|- repository.dart

```
## Models
All plain data models file will be here. Depending on the number of the model files, if it is more than 10 files, we suggest separating the files by sub folder such as models/category, models/user etc. Else, keep it simple with every data model file is within this folder.
```
models/
|- category/
    |- category_model/
    |- category_list_model/
```

## Stores
The store is where all your application state lives in flutter. The Store is basically a widget that stands at the top of the widget tree and passes it's data down using special methods. In-case of multiple stores, a separate folder for each store is created as shown in the example below:
```
stores/
|- user/
    |- user_store.dart
```

## Screens
This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in widgets directory as shown in the example below:


```
screens/
|- login
   |- login_screen.dart
   |- widgets
      |- login_form.dart
      |- login_button.dart
```

## Utils
Contains the common file(s) and utilities used in a project. The folder structure is as follows:
```
utils/
|- device
   |- device_utils.dart

```


## Widgets
Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.
```
widgets/
|- app_icon_widget.dart
|- empty_app_bar.dart
|- progress_indicator.dart
```

## Routes
This file contains all the routes for your application.
```
import 'package:flutter/material.dart';
import 'package:vdev_test_project/screens/dashboard/dashboard.dart';
import 'package:vdev_test_project/screens/login/login.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String dashboard = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    dashboard: (BuildContext context) => Dashboard(),
  };
}

```



## UI Screens
![Demo](https://github.com/sudarasachindana/vdev-20211114/blob/main/assets/images/demo.png)
