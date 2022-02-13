import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/cards/operation_card.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/core/constants/app/app_constants.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/extenstions/int_time_format_extension.dart';
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
          viewModel.userModelProvider.setCollectionReference();
          viewModel.operationModelProvider.setCollectionReference();
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
              child:
                  Padding(padding: const EdgeInsets.all(8.0), child: myAppBar)),
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
  Widget get body => Observer(builder: (context) {
        return Container(
          alignment: Alignment.topCenter,
          height: dynamicHeight(1) - 120,
          width: dynamicWidth(1),
          child: RefreshIndicator(
            onRefresh: () async => await viewModel.getUser(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [userIdentity, operations, createNewOperation],
              ),
            ),
          ),
        );
      });

  Widget get userIdentity => EmptySurface(
        child: Column(
          children: [
            SizedBox(
                height: 150,
                child: Image.asset(ApplicationConstants.USER_PROFILE_PATH,
                    color: themeData.primaryColorLight)),
            Text(
              viewModel.userModel != null
                  ? viewModel.userModel!.name
                  : "isim soyisim",
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              viewModel.userModel != null
                  ? viewModel.userModel!.phone
                  : "telefon numarası",
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
          ],
        ),
      );

  Widget get operations => Padding(
      padding: const EdgeInsets.all(8),
      child: Observer(
        builder: (context) {
          if (viewModel.operations.isNotEmpty) {
            return Column(
              children: [
                for (OperationModel item in viewModel.operations)
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: OperationCard(
                      maxHeight: 150,
                      maxWidth: 500,
                      icon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              item.beforePhoto.isEmpty
                                  ? ApplicationConstants.DEFAULT_IMG_URL
                                  : item.beforePhoto[0],
                              fit: BoxFit.fill,
                            )),
                      ),
                      firstTitle: item.location,
                      subTitle: item.operationStart.toFormattedTime,
                      onTap: () {
                        NavigationService.instance.navigateToPage(
                            path: NavigationConstants.OPERATION_DETAIL,
                            data: item.docId);
                      },
                    ),
                  ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ));
  Widget get createNewOperation => ElevatedButton(
      onPressed: () {
        NavigationService.instance.navigateToPage(
            path: NavigationConstants.OPERATION_FORM, data: viewModel.userId);
      },
      child: Container(
        width: dynamicWidth(0.5),
        alignment: Alignment.center,
        height: 70,
        child: Text(
          "Etkinlik Oluştur",
          style: TextStyle(fontSize: 25),
        ),
      ));
}
