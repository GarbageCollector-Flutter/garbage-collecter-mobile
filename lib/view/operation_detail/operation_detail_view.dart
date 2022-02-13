import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/core/constants/navigation/navigation_constants.dart';
import 'package:first_three/core/init/navigation/navigation_service.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/model/user_officer/user_officer.dart';
import 'package:first_three/view/operation_detail/operation_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:first_three/core/extenstions/string_extension.dart';


class OperationDetailView extends StatefulWidget {
  const OperationDetailView({Key? key}) : super(key: key);

  @override
  State<OperationDetailView> createState() => _OperationDetailViewState();
}

class _OperationDetailViewState extends BaseState<OperationDetailView> {
  late OperationDetailViewModel viewModel;
  final f = DateFormat('yyyy-MM-dd hh:mm');
  int rank = 0;
  int officerRank=0;

  File? imgFile;
  String? tempFotoUrl;

  Future<File?> _resimSec(ImageSource source) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    var secilen = await picker.getImage(source: source);

    if (secilen != null) {
      imgFile = File(secilen.path);
      return imgFile;

    } else {
      return null;
    }
  }

  void _showImageDialog(
      {required BuildContext context, required bool isBefore}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text("Galeriden Fotoğraf Seç"),
              onTap: () async {
                File? imgFile = await _resimSec(ImageSource.gallery);
                if (imgFile != null) {
                       Navigator.pop(context);
               await   viewModel.addPhoto(imgFile: imgFile, isBefore: isBefore);
                "resim yükleme işlemi tamamlandı".snackBarExtension(context);
                }
           
               
              },
            ),
            ListTile(
              title: const Text("Kameradan Fotoğraf Çek"),
              onTap: () {
                _resimSec(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: OperationDetailViewModel(),
        onModelReady: (model) async {
          viewModel = model as OperationDetailViewModel;
          viewModel.setContext(this.context);
          viewModel.setAllProvidersCollectionReference();
          viewModel.operationPath =
              ModalRoute.of(context)!.settings.arguments as String;
           viewModel.getOperation();
          viewModel.getCurrentUser();
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
              child: Padding(padding: const EdgeInsets.all(8.0), child: myAppBar)),
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
          "Etkinlik Detayı",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      );

  Widget get body => Observer(builder: (context) {
     rank=0;
        return SizedBox(
          height: dynamicHeight(1) - 110,
          child: RefreshIndicator(
            onRefresh:  ()async=>viewModel.getOperation(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OperationIdentity,
                  afterPhotos,
                  beforePhotos,
                  organizator,
                  collecters,
                  for (UserOfficer userOfficer in viewModel.officers)
                    officer(userOfficer),
                  Container(
                      margin: const EdgeInsets.only(bottom: 50, top: 10),
                      child: beResponsibleButton),
                ],
              ),
            ),
          ),
        );
      });

  Widget get OperationIdentity => Observer(builder: (context) {
        if (viewModel.operationModel != null) {
          return EmptySurface(
              child: Column(
            children: [
              Text(
                viewModel.operationModel!.operationName,
                style: const TextStyle(fontSize: 30),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    viewModel.operationModel!.location,
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    f.format(DateTime.fromMillisecondsSinceEpoch(
                        viewModel.operationModel!.operationStart)),
                    style: const TextStyle(fontSize: 17),
                  )
                ],
              )
            ],
          ));
        } else {
          return const SizedBox(
            height: 0,
          );
        }
      });
  Widget get beforePhotos =>  viewModel.operationModel !=null ? EmptySurface(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              const Text(
                "öncesi",
                style: TextStyle(fontSize: 25),
              ),
              GestureDetector(
                onTap: () {
                  _showImageDialog(context: context, isBefore: true);
                },
                behavior: HitTestBehavior.opaque,
                child: const Icon(
                  Icons.add,
                  size: 27,
                ),
              )
            ],
          ),
        ),
        const Divider(),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: viewModel.operationModel!.beforePhoto.isEmpty
                ? const SizedBox(
                    child: Center(
                        child: Text("+ butonu ile görsel ekleyebilirsiniz...")),
                    // color: Colors.black45,
                    height: 150.0,
                  )
                : Row(
                    children: [
                      for (String imgUrl
                          in viewModel.operationModel!.beforePhoto)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              imgUrl,
                              height: 250.0,
                           
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    ],
                  )),
      ])):const SizedBox();
  Widget get afterPhotos => viewModel.operationModel !=null ?EmptySurface(
          child: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                const Text(
                  "sonrası",
                  style: TextStyle(fontSize: 25),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _showImageDialog(isBefore: false, context: context);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 27,
                  ),
                )
              ],
            )),
        const Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: viewModel.operationModel!.afterPhoto.isEmpty
              ? const SizedBox(
                  child: Center(
                      child: Text("+ butonu ile görsel ekleyebilirsiniz...")),
                  // color: Colors.black45,
                  height: 150.0,
                )
              : Row(children: [
                  for (String imgUrl in viewModel.operationModel!.afterPhoto)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imgUrl,
                          height: 250.0,
                       
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                ]),
        ),
      ])):const SizedBox();

  Widget get organizator => Observer(builder: (context) {
        if (viewModel.organizator != null) {
          return EmptySurface(
              child: Column(
            children: [
              const Text(
                "organizatör",
                style: TextStyle(fontSize: 25),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    viewModel.organizator!.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    viewModel.organizator!.phone,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              )
            ],
          ));
        } else {
          return const SizedBox(
            height: 0,
          );
        }
      });

  Widget get collecters => EmptySurface(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            const Text(
              "toplayıcılar",
              style: TextStyle(fontSize: 25),
            ),
           addOrRemoveCollecter
           
          ],
            ),
          ),
          const Divider(),
          for (UserModel item in viewModel.garbage_collecters) playerScore(item)
        ],
      ));

  Widget playerScore(UserModel userModel) {
    rank++;
    Color color;
    if (rank % 2 == 1) {
      color = Colors.grey.withOpacity(0.1);
    } else {
      color = Colors.white;
    }
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: dynamicWidth(0.2),
            child: Text(
              (rank).toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: dynamicWidth(0.6),
            child: Text(
              userModel.name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget officer(UserOfficer userOfficer) {
    officerRank=0;
    return EmptySurface(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "görevli",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: (){
                  NavigationService.instance.navigateToPage(path: NavigationConstants.PROFILE,data: userOfficer.usermodel.phone);
                },
                
                child: Text(
                  "${userOfficer.usermodel.name}",
                  style: const TextStyle(fontSize: 17, color: Color(0xff3366bb),),
                 
                ),
              ),
            ],
          ),
          const Divider(),
          for(String responsibility in userOfficer.officerModel.responsibilities)
                
          responsibilityRankV2(responsibility)
          //  Text(userOfficer.usermodel.name)
        ],
      ),
    );
  }
    Widget responsibilityRankV2(String responsibility) {
   
     officerRank ++;
    Color color;
    if (officerRank % 2 == 1) {
      color = Colors.grey.withOpacity(0.1);
    } else {
      color = Colors.white;
    }
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: dynamicWidth(0.2),
            child: Text(
              (officerRank).toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: dynamicWidth(0.6),
            child: Text(
              responsibility,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget responsibilityRank(List<String> responsibilities) {
   
    return Container(
      alignment: Alignment.topCenter,
      height: responsibilities.length * 40+ 40,
      child: ListView.builder(
        
        itemCount: responsibilities.length,
        itemBuilder: (BuildContext context, int index) {
          Color color;
          if (index % 2 == 1) {
            color = Colors.grey.withOpacity(0.1);
          } else {
            color = Colors.white;
          }
      
          return Container(
            alignment: Alignment.topCenter,
            color: color,
            height: 40,
            child: Container(
              color: color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: dynamicWidth(0.2),
                    child: Text(
                      (index+1).toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: dynamicWidth(0.6),
                    child: Text(
                      responsibilities[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get beResponsibleButton => ElevatedButton(
      onPressed: () {
NavigationService.instance.navigateToPage(path: NavigationConstants.OFFICER_FORM,data: viewModel
.operationModel);
      },
      child: Container(
        width: dynamicWidth(0.5),
        alignment: Alignment.center,
        height: 70,
        child: const Text(
          "görevli ol",
          style: TextStyle(fontSize: 25),
        ),
      ));
Widget get addOrRemoveCollecter=>Observer(builder:(context){
 
    if(viewModel.operationModel!=null&&viewModel.currentUserModel!=null){
 if( viewModel.operationModel!.garbageCollecters.contains(viewModel.currentUserModel!.phone)){
   return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
               await viewModel.removeCollecter();
              await  viewModel.getOperation();
                      "göreviniz iptal edildi".snackBarExtension(context);
                  },
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      size: 27,
                    ),
                  ),
                );

    }else{
return  GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await viewModel.addCollecter();
                    viewModel.getOperation();
                    rank = 0;
                    
                    "göreve atandınız".snackBarExtension(context);
                  },
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 27,
                    ),
                  ),
                );
    }
    }else{
      return Container();
    }

});


}
