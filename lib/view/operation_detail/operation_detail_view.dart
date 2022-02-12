import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/model/user/user_model.dart';
import 'package:first_three/model/user_officer/user_officer.dart';
import 'package:first_three/view/operation_detail/operation_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class OperationDetailView extends StatefulWidget {
  const OperationDetailView({Key? key}) : super(key: key);

  @override
  State<OperationDetailView> createState() => _OperationDetailViewState();
}

class _OperationDetailViewState extends BaseState<OperationDetailView> {
  late OperationDetailViewModel viewModel;
  final f = DateFormat('yyyy-MM-dd hh:mm');
  int rank = 0;

  File? imgFile;
  String? tempFotoUrl;

  Future<File?> _resimSec(ImageSource source) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    var secilen = await picker.getImage(source: source);

    if (secilen != null) {
      imgFile = File(secilen.path);
      return imgFile;

      //upload firabase
      //     var url = await StrageService().userimgUpload(imgFile!, userID);

      // setState(() {});
    }else{
      return null;
    }
  }

  void _showImageDialog({required BuildContext context ,required bool isBefore}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text("Galeriden Fotoğraf Seç"),
              onTap: () async{
              File? imgFile =await  _resimSec(ImageSource.gallery);
              if(imgFile!=null){
                viewModel.addPhoto(imgFile: imgFile, isBefore: isBefore);
              }
              Navigator.pop(context);
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
          await viewModel.getOperation();
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

  Widget get body => Observer(builder: (context) {
        rank = 0;
        return SizedBox(
          height: dynamicHeight(1) - 110,
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
                    margin: EdgeInsets.only(bottom: 50, top: 10),
                    child: beResponsibleButton),
              ],
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
                style: TextStyle(fontSize: 30),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    viewModel.operationModel!.location,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    f.format(new DateTime.fromMillisecondsSinceEpoch(
                        viewModel.operationModel!.operationStart)),
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )
            ],
          ));
        } else {
          return SizedBox(
            height: 0,
          );
        }
      });
  Widget get beforePhotos => EmptySurface(
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

                  _showImageDialog(context :context,isBefore: true);
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
        Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
        ),
      ]));
  Widget get afterPhotos => EmptySurface(
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
                    _showImageDialog(isBefore:false, context: context);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 27,
                  ),
                )
              ],
            )),
        Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
        ),
      ]));

  Widget get organizator => Observer(builder: (context) {
        if (viewModel.organizator != null) {
          return EmptySurface(
              child: Column(
            children: [
              Text(
                "organizatör",
                style: TextStyle(fontSize: 25),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    viewModel.organizator!.name,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    viewModel.organizator!.phone,
                    style: TextStyle(fontSize: 17),
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
          child: Container(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  "toplayıcılar",
                  style: TextStyle(fontSize: 25),
                ),
                addOrRemoveCollecter()
               
              ],
            ),
          ),
          Divider(),
          for (UserModel item in viewModel.garbage_collecters) playerScore(item)
        ],
      )));

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
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.2),
              child: Text(
                rank.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.6),
              child: Text(
                userModel.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget officer(UserOfficer userOfficer) {
    return EmptySurface(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "görevli",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${userOfficer.usermodel.name}",
                style: TextStyle(fontSize: 17, color: Color(0xff3366bb)),
              ),
            ],
          ),
          Divider(),
          responsibilityRank(userOfficer.officerModel.responsibilities)
          //  Text(userOfficer.usermodel.name)
        ],
      ),
    );
  }

  Widget responsibilityRank(List<String> responsibilities) {
    return Container(
      height: responsibilities.length * 40 + 50,
      child: ListView.builder(
        itemCount: responsibilities.length,
        itemBuilder: (BuildContext context, int index) {
          Color color;
          if (index % 2 == 1) {
            color = Colors.grey.withOpacity(0.1);
          } else {
            color = Colors.white;
          }
          print("------------------------" + responsibilities[index]);
          return Container(
            color: color,
            height: 40,
            child: Container(
              color: color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: dynamicWidth(0.2),
                    child: Text(
                      index.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: dynamicWidth(0.6),
                    child: Text(
                      responsibilities[index],
                      style: TextStyle(fontSize: 20),
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

      },
      child: Container(
        width: dynamicWidth(0.5),
        alignment: Alignment.center,
        height: 70,
        child: Text(
          "görevli ol",
          style: TextStyle(fontSize: 25),
        ),
      ));
  Widget  addOrRemoveCollecter(){
    if(viewModel.operationModel!=null&&viewModel.currentUserModel!=null){
 if( viewModel.operationModel!.garbageCollecters.contains(viewModel.currentUserModel!.phone)){
   return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await viewModel.addCollecter();
                    viewModel.getOperation();
                    rank = 0;
                  },
                  child: Center(
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
                  },
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 27,
                    ),
                  ),
                );
    }
    }else{
      print("---------------------------nulll bbunlar");
      return Container();
    }
   
  }
}
