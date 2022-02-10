import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/text/locale_text.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/lang/locale_keys.g.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:first_three/view/second_page/model/user_model.dart';
import 'package:first_three/view/second_page/second_page_view_model.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends BaseState<SecondPage> {
  SecondPageViewModel? viewModel;
  UserModel userModel = UserModel();

  @override
  void dispose() {
    if (viewModel != null) {
      viewModel!.userDataBaseProvider.close();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: SecondPageViewModel(),
        onModelReady: (model) {
          viewModel = model as SecondPageViewModel;
          viewModel!.setContext(this.context);
          viewModel!.userDataBaseProvider.open();
        },
        onPageBuilder: (context, value) => scaffold);
  }

  Widget get scaffold => Scaffold(
      appBar: appBar,
      body: Container(alignment: Alignment.center, child: body));
  PreferredSizeWidget get appBar => AppBar(
        title: LocalText(value: LocaleKeys.database_page),
      );
  Widget get body => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          for (Widget item in inputs)
            Padding(padding: EdgeInsets.all(10), child: item),
          buttons,
          listUsers
        ]),
      );
  Widget userItemCard(UserModel userModel) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: dynamicHeight(0.01), horizontal: dynamicWidth(0.1)),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text(userModel.userName!=null? userModel.userName!:"")),
            Expanded(flex: 1, child: Text(userModel.age.toString())),
            Expanded(  flex: 1,child: Text(userModel.isMarried == 1 ? "married" : "single"))
          ],
        ),
      );
  Widget get listUsers => FutureBuilder(
      future: viewModel!.userDataBaseProvider.getItemList(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>?> users) {
        if (users.hasData) {
          return Expanded(
              child: SingleChildScrollView(
                child: Column(
            children: [for (UserModel item in users.data!) userItemCard(item)],
          ),
              ));
          //users.data!.forEach((element) {print(element.toJson().toString());});

        }
        return Container();
      });

  List<Widget> get inputs => [
        TextField(
          onChanged: (value) {
            userModel.userName = value;
          },
          decoration: InputDecoration(
              hintText: LocaleKeys.user_name.tr(), border: OutlineInputBorder()),
        ),
        TextField(
          onChanged: (value) {
            userModel.age = int.tryParse(value);
          },
          decoration:
              InputDecoration(hintText: LocaleKeys.age.tr(), border: OutlineInputBorder()),
        ),
        TextField(
          onChanged: (value) {
            userModel.isMarried = value.isNotEmpty ? 1 : 0;
          },
          decoration: InputDecoration(
              hintText: "isMarried", border: OutlineInputBorder()),
        ),
      ];

  Widget get buttons => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: Text("back to home page"),
            onPressed: () {
              NavigationService.instance.navigateToPageClear(
                path: NavigationConstants.HOME_VIEW,
              );
            },
          ),
          ElevatedButton(
            child: Text("save user"),
            onPressed: () async {
              await viewModel!.userDataBaseProvider.insertItem(userModel);

              setState(() {});
            },
          ),
          ElevatedButton(
            child: Text("delete all"),
            onPressed: () async {
              await viewModel!.userDataBaseProvider.removeAllItems();
              setState(() {});
            },
          ),
        ],
      );
}
