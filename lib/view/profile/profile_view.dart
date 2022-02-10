import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/view/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        onModelReady: (model) {
          viewModel = model as ProfileViewModel;
          viewModel.setContext(this.context);
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
              bottom: 0,
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
  Widget get body =>
      SingleChildScrollView(child: EmptySurface(child: playerInfo));
  Widget get playerInfo => FutureBuilder(
      future: viewModel.getPlayer(),
      builder:
          (BuildContext context, AsyncSnapshot<PlayerModel?> asyncSnapshot) {
        if (asyncSnapshot.data != null) {
          print("-------------------------------------" +
              asyncSnapshot.data!.toString());

          return userCard(asyncSnapshot.data!);
        }
        return Container();
      });
  Widget userCard(PlayerModel playerModel) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(40),
          height: dynamicHeight(0.4),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(180),
                  bottomRight: Radius.circular(180))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/uicons/user_icon2.png',
                  color: Colors.white,
                  height: dynamicHeight(0.2),
                  width: dynamicWidth(0.4),
                ),
              ),
                                Text(playerModel.name ?? "isim bilgisi bulunamadı",   style: TextStyle(fontSize: 22, color: Colors.white),),
SizedBox(height: 20,),
                                 Text(playerModel.phone ?? playerModel.palyerId!,   style: TextStyle(fontSize: 22, color: Colors.white),),
                                 

            ],
          ),
        ),
        QrImage(
          data: playerModel.palyerId!,
          version: QrVersions.auto,
          size: dynamicHeight(0.2),
        ),
      ],
    );
  }
}
