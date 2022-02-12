import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/view/officier_form/officier_form_view_model.dart';
import 'package:flutter/material.dart';

class OfficierFormView extends StatefulWidget {
  OfficierFormView({Key? key}) : super(key: key);

  @override
  State<OfficierFormView> createState() => _OfficierFormViewState();
}

class _OfficierFormViewState extends BaseState<OfficierFormView> {
  late OfficierFormViewModel viewModel;

  @override
  Widget build(BuildContext context) {
return BaseView(
        viewModel: OfficierFormViewModel(),
        onModelReady: (model) async {
          viewModel = model as OfficierFormViewModel;
          viewModel.setContext(this.context);
         viewModel.operationModelProvider.setCollectionReference();
            viewModel.operationModel =
              ModalRoute.of(context)!.settings.arguments as OperationModel;
        },
        onPageBuilder: (context, value) => scaffold);  }


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
  Widget get body=>EmptySurface(
    
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  inputLabel("etkinlik ismi"),
                  TextFormField(
                 //   controller: viewModel.nameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(),
                  ),
                  inputLabel("lokasyon"),
                  TextFormField(
                  //  controller: viewModel.locationController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   SizedBox(
                    height: 20,
                  ),
             
                ],
              ),
            ),
          ),
    
    
    
    );

      Widget inputLabel(String text) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ));
  }
}