# Overview
This is advanced base template included localization, Theme management, Navigation management and sqflite with using strategic pattern. This project is upgraded version of  [my previous project](https://github.com/onurcankurum/Advanced-Fluttter-Base-Template-MVVM-State-Management) that include MVVM and State Management 
<br>
<img src="assets/screen_shots/dark_en.jpg" width="250">
<img src="assets/screen_shots/light_de.jpg" width="250">
<img src="assets/screen_shots/first_page.jpg" width="250">
<img src="assets/screen_shots/database.jpg" width="250">

# dependencies
If you wonder what they does these depencies. Chekout the second header 

<pre>
dependencies:
  build_runner: ^2.1.7
  cupertino_icons: ^1.0.2
  <strong>easy_localization: ^3.0.0</strong>
  flutter:
    sdk: flutter
  flutter_mobx: ^2.0.2
  mobx: ^2.0.5
  mobx_codegen: ^2.0.4
  <strong>sqflite: ^2.0.2</strong>
  <strong>provider: ^6.0.1</strong>

</pre>
## What Is These Depencies (second header)

* [easy_localization:](https://pub.dev/packages/easy_localization)
  * This package allows you to translate many languages using Easy Localization Loader, load translations like JSON, CSV, Yaml, Xml. Also can React and persist to locale changes
* [provider:](https://pub.dev/packages/provider)
  * A wrapper around InheritedWidget to make them easier to use and more reusable. 



## 1. Lanuage Management
let's look out core component relating to language managing
### core/init/lang/language_manager.dart
A singleton class for knowing what languages available and selecting a available  language
```dart
class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    if (_instance == null) {
      _instance = LanguageManager._init();
      return _instance!;
    }
    return _instance!;
  }

   final enLocale = const Locale("en","US");
   final germen = const Locale("de","DE");
  List<Locale> get supportedLocales =>[enLocale,germen];

  LanguageManager._init();
  
}
```
### assets/lang*
We have two json files and their keys are exactly same but values different according their languages. Don not forget to these files should named according their locale code. [More information](https://pub.dev/packages/easy_localization)

### EasyLocation widget
Run ensureInitialized method and wrap with EasyLocalization with root widget.  
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
        child:  const MyApp(),
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH),//this constant determine that file path that including language translations file 
  ));
}

```
### generating codes
[flutter pub run easy_localization:generate -O lib/core/init/lang -f keys -o locale_keys.g.dart -S assets/lang/]  run this command on terminal. Now we are ready to use localization

### Using Localization
```dart
 Text(LocaleKeys.de).tr()
const LocalText(value: LocaleKeys.de),//this widget is not in localization package only has this project
context.setLocale(LanguageManager.instance.germen);//this line changes the application language



```
## 2. Theme Management
For state management used  provider package. 
#### lib/core/init/thme/app_theme_light.dart
This singleton class has our light theme (also we have same class for darktheme in same path)

```dart
import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    if (_instance == null) {
      _instance = AppThemeLight._init();
      return _instance!;
    }
    return _instance!;
  }

  @override
  ThemeData get theme => ThemeData(
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
        scaffoldBackgroundColor: const Color(0xFFe5f0f9),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF639edc),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: const Color(0xFF639edc))),
      );

  AppThemeLight._init();
}
```
#### lib/core/init/notifier/provider_list.dart
This file includes our singleton provider manager.
#### lib/core/init/notifier/theme_notifier.dart
This file allow changing themes to notify listener by provider using enums and aforementioned singleton themes.
```dart
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  AppThemes _currenThemeEnum = AppThemes.LIGHT;

  /// Applicaton theme enum.
  /// Deafult value is [AppThemes.LIGHT]
  AppThemes get currenThemeEnum => _currenThemeEnum;

  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme = AppThemeLight.instance.theme;
    } else {
      _currentTheme = AppThemeDark.instance.theme;
    }
    notifyListeners();
  }

  /// Change your app theme with [currenThemeEnum] value.
  void changeTheme() {
    if (_currenThemeEnum == AppThemes.LIGHT) {
      _currentTheme = ThemeData.dark();
      _currenThemeEnum = AppThemes.DARK;
    } else {
      _currentTheme = AppThemeDark.instance.theme;
      _currenThemeEnum = AppThemes.LIGHT;
    }
    notifyListeners();
  }
}

```
#### using provider widget
Use Multiprovider for and add providers. now we can change themes

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: EasyLocalization(
        child:  const MyApp(),
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH),
  ));
}

```
#### changing themes
Can change the theme

```dart
  Provider.of<ThemeNotifier>(context!,listen: false).changeValue(AppThemes.DARK);

```
# Navigation 
This template project also include advanced navigation components. You can see this components at core/init/navigation folder.
## lib/core/init/navigation/navigation_service.dart
This singleton class is helps us for navigation management. 

```dart
class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final removeAllOldRoutes = (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({String? path, Object? data}) async {
    await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path!, removeAllOldRoutes, arguments: data);
  }
}
```
## lib/core/init/navigation/navigation_route.dart
This singleton class is helps us for generating routes. if you wanna add a new route then you should add a new case for your route in switch case field at shown below
```dart
class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME_VIEW:
        return normalNavigate( const HomeView(), NavigationConstants.HOME_VIEW);
      case NavigationConstants.FIRST_PAGE:
        return normalNavigate(FirstPage(), NavigationConstants.FIRST_PAGE);
      case NavigationConstants.SECOND_PAGE:
        return normalNavigate(SecondPage(), NavigationConstants.SECOND_PAGE);
      default:
        return MaterialPageRoute(
          builder: (context) =>  NotFound(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget,
        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName));
  }
}
```
## main.dart
In the end you must add your navigatorkey to navigatorKey in MaterialApp and Your route generator to onGenerateRoute in MaterialApp

```dart
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      // navigatorObservers: [AnalytcisManager.instance.observer],
      theme: context.watch<ThemeNotifier>().currentTheme,
      home:   HomeView(),
    );
  }
```
## usage of navigation
```dart
 NavigationService.instance.navigateToPage(path: NavigationConstants.FIRST_PAGE); // to open new page
 NavigationService.instance.navigateToPageClear(path:NavigationConstants.HOME_VIEW); // to popping untill specific page
```
# Sqflite
With this package we will use sqllite with strategic pattern

## lib/core/init/database/database_model.dart
Our models should extends this generic abstract class.
```dart
abstract class DatabaseModel<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```
## lib/core/init/database/database_provider.dart
Also each Models should have to own generic provider for standard CRUD operations.

```dart
abstract class DatabaseProvider<T extends DatabaseModel> {
  Database? database;

  Future open();
  Future<T?> getItem(int id);
  Future<List<T>> getItemList();
  Future<bool> updateItem(int id,T model);
  Future<bool> removeItem(int id);
  Future<bool> insertItem(T model);
  Future<void> removeAllItems();
  Future<void> close() async {
    if (database != null) {
      await database!.close();
    }
  }
}

```
## Example of model class | lib/view/second_page/model/user_model.dart
```dart
import 'package:first_three/core/init/database/database_model.dart';

class UserModel extends DatabaseModel {
  String? userName;
  int? age;
  int? isMarried;
 

  UserModel({this.userName, this.age, this.isMarried});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    age = json['age'];
    isMarried = json['isMarried'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = userName;
    data['age'] = age;
    data['isMarried'] = isMarried;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}

```
## Example of provider of model | lib/view/second_page/model/user_database_provider.dart
```dart
import 'package:first_three/core/init/database/database_model.dart';
import 'package:first_three/core/init/database/database_provider.dart';
import 'package:first_three/view/second_page/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDataBaseProvider implements DatabaseProvider<UserModel> {
  @override
  Database? database;
  final int version = 1;
  final String _userDatabaseName = "advancedSqflite";
  final String _userTableName = "users";

  // table' s columns names
  final String _columnId = "id";
  final String _columnUserName = "name";
  final String _columnUserAge = "age";
  final String _columnIsMarried = "isMarried";

  @override
  Future<void> open() async {
    database = await openDatabase(_userDatabaseName, version: version,
        onCreate: (db, version) {
      db.execute('''CREATE TABLE $_userTableName 
          ( $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnUserName VARCHAR(20),
            $_columnUserAge INTEGER ,
            $_columnIsMarried INTEGER )''');
    });
  }

  @override
  Future<List<UserModel>> getItemList() async {
    if(database==null){
      await open();
    }
    List<Map<String, dynamic>> userMap = await database!.query(_userTableName);
    return userMap.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel?> getItem(int id) async {
    
    if(database==null){
      await open();
    }
    List<Map<String, dynamic>> userMap = await database!.query(_userTableName,
        where: '$_columnId = ?', columns: [_columnId], whereArgs: [id]);
    if (userMap.isNotEmpty) {
      return UserModel.fromJson(userMap.elementAt(0));
    } else {
      return null;
    }
  }

  @override
  Future<bool> removeItem(int id) async {
    final int totalAffected = await database!
        .delete(_userTableName, where: '$_columnId = ?', whereArgs: [id]);
    if (totalAffected >= 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> insertItem(UserModel userModel) async {
    final int isOk = await database!.insert(_userTableName, userModel.toJson());
    if (isOk >= 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateItem(int id, UserModel model) async {
    final int isOk = await database!.update(_userTableName, model.toJson(),
        where: '$_columnId = ?', whereArgs: [id]);
    if (isOk >= 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() async {
    await database!.close();
  }

  @override
  Future<void> removeAllItems() async {
    // ignore: unused_local_variable
    final int totalAffected = await database!.delete(_userTableName);
  }

}

```
## usage of this pattern

Firstly create a provider instance in your view model class.
```dart
  UserDataBaseProvider userDataBaseProvider = UserDataBaseProvider();
```
finnaly access them like this
```dart
  viewModel!.userDataBaseProvider.open();
  viewModel!.userDataBaseProvider.insertItem(userModel);//if userModel created before

```

"# garbage-collecter-mobile" 
