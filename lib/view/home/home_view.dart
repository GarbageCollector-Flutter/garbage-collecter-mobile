// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/cards/game_mode_card.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/core/constants/app/app_constants.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/view/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_three/core/extenstions/int_time_format_extension.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  bool _isMenuOpen = false;
  late HomeViewModel viewModel;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void onTapProfile() async {
    final SharedPreferences prefs = await _prefs;
    String? userId = prefs.getString('currentUserPhone');
    if (userId != null) {
      NavigationService.instance
          .navigateToPage(path: NavigationConstants.PROFILE, data: userId);
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: HomeViewModel(),
        onModelReady: (model) async {
          viewModel = model as HomeViewModel;
          viewModel.setContext(this.context);
          await viewModel.getAllOperations().then((value) {
            setState(() {
              
            });
          });
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
                child: tabs,
              )),
          Positioned(
              left: 0,
              right: 0,
              top: 20,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyAppBar(
                    onChange: () {
                      setState(() {
                        if (_isMenuOpen) {
                          _isMenuOpen = false;
                        } else {
                          _isMenuOpen = true;
                        }
                      });
                    },
                    buttons: {
                      'hakkımızda': onTapProfile,
                      "profil": onTapProfile,
                      "çıkış": signout,
                    },
                    title: Text("Akış",
                        style: TextStyle(
                            fontSize: 20,
                            color: _isMenuOpen
                                ? themeData.primaryColorLight
                                : Colors.white,
                            fontWeight: FontWeight.w800)),
                  ))),
        ],
      ));

  Widget get tabs => Container(
        height: dynamicHeight(1) - 100,
        child: DefaultTabController(
          length: 2,
          child: RefreshIndicator(
            onRefresh: () async =>
                await viewModel.getAllOperations().then((value) {
                  setState(() {
                    
                  });
                }),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: dynamicWidth(0.6),
                    height: 70,
                    child: EmptySurface(
                      child: TabBar(
                        indicatorPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        labelStyle: GoogleFonts.ibmPlexSans(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        unselectedLabelStyle: GoogleFonts.ibmPlexSans(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        tabs: const [
                          Tab(
                            text: "aktif",
                          ),
                          Tab(text: "biten"),
                        ],
                        onTap: (val) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  tabFields
                ],
              ),
            ),
          ),
        ),
      );
  Widget get tabFields => Container(
        height: viewModel.continuingOpertaions.length < viewModel.outDatedOpertaions.length
            ? viewModel.outDatedOpertaions.length * 200
            : viewModel.continuingOpertaions.length * 200,
        width: double.infinity,
        child: TabBarView(
          children: [continuing, outDated],
        ),
      );

  Widget get outDated => Padding(
      padding: EdgeInsets.all(8),
      child: Observer(
        builder: (context) {
          return Column(
            children: [
              for (OperationModel item in viewModel.outDatedOpertaions)
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: GameModeCard(
                    maxHeight: 150,
                    maxWidth: 500,

                      icon:  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                        item.beforePhoto.isEmpty ?  
                       ApplicationConstants.DEFAULT_IMG_URL : 
                        item.beforePhoto[0]
                      ,
                         fit: BoxFit.fill,)),
                    ),
                //    icon:  Text("fotoğraf eklenecek"),

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
        },
      ));
  Widget get continuing => Padding(
      padding: EdgeInsets.all(8),
      child: Observer(
        builder: (context) {
          return Column(
            children: [
              for (OperationModel item in viewModel.continuingOpertaions)
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: GameModeCard(
                    maxHeight: 150,
                    maxWidth: 500,
                    icon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                        item.beforePhoto.isEmpty ?  
                       ApplicationConstants.DEFAULT_IMG_URL : 
                        item.beforePhoto[0]
                      ,
                         fit: BoxFit.fill,)),
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
        },
      ));
}
