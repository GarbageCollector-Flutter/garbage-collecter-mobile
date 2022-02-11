import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/cards/game_mode_card.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/core/constants/app/app_constants.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/view/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseState<ProfileView> {
  late ProfileViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: ProfileViewModel(),
        onModelReady: (model) async {
          viewModel = model as ProfileViewModel;
          viewModel.setContext(this.context);
          viewModel.userId =
              ModalRoute.of(context)!.settings.arguments as String;
              viewModel.setOperationProviderReference();
              viewModel.setOperationProviderReference();
              viewModel.getUser();
        },
        onPageBuilder: (context, value) => scaffold);
  }

  Widget get scaffold => Scaffold(
          body: Stack(
        children: [
          Positioned(
              top: 110,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: body,
              )),
          Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: Padding(padding: EdgeInsets.all(8.0), child: myAppBar)),
        ],
      ));

  Widget get myAppBar => MyAppBar(
        lead: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Profil",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      );
  Widget get body =>Observer(builder: (context){
    return Column(children: [
    userIdentity,
    operations
    ],);
  });

  Widget get userIdentity => EmptySurface(
        child: Column(
          children: [
            SizedBox(
                height: 150,
                child: Image.asset(ApplicationConstants.USER_PROFILE_PATH,
                    color: themeData.primaryColorLight)),
            Text(
              "onur can",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "+905396420208",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            
          ],
        ),
      );

        Widget get operations => Padding(
      padding: EdgeInsets.all(8),
      child: Observer(
        builder: (context) {
          return Column(
           children: [
              for (OperationModel item in viewModel.operations)
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: GameModeCard(
                    maxHeight: 150,
                    maxWidth: 500,
                    icon: Text("fotoğraf eklenecek"),
                    firstTitle: item.location,
                    subTitle:item.operationStart.toString(),
                    onTap: () {
                             NavigationService.instance.navigateToPage(
                          path: NavigationConstants.OPERATION_DETAIL, data: item.docId);
                    },
                  ),
                ),
            ],
          );
        },
      ));
}
