import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/buttons/cancel_button.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/view/operation_form/operation_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:first_three/core/extenstions/string_extension.dart';


class OperationFormView extends StatefulWidget {
  const OperationFormView({Key? key}) : super(key: key);

  @override
  State<OperationFormView> createState() => _OperationFormViewState();
}

class _OperationFormViewState extends BaseState<OperationFormView> {
  late OperationFormViewModel viewModel;
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: OperationFormViewModel(),
        onModelReady: (model) async {
          viewModel = model as OperationFormViewModel;
          viewModel.setContext(this.context);
          viewModel.operationModelProvider.setCollectionReference();
          viewModel.userModelProvider.setCollectionReference();
        
          viewModel.userId =
              ModalRoute.of(context)!.settings.arguments as String;
         
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
          "Etkinlik Bilgileri",
          style: TextStyle(fontSize: 22, color: Colors.white),

        ),
           suffix: CancelButton(onTap: ()async{
           bool isOk = await viewModel.createOperation();
           if(isOk ==true){
             "etkinlik olu??turuldu".snackBarExtension(context);
             Navigator.pop(context);
           }else{
              "bir hata olu??tu".snackBarExtension(context);
           }

                    }, size: const Size(120,50),child: const Text("kaydet",style: TextStyle(fontSize: 25)),),
      );

  Widget get body => SizedBox(
        height: 500,
        width: 100,
        child: EmptySurface(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  inputLabel("etkinlik ismi"),
                  TextFormField(
                    controller: viewModel.nameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(),
                  ),
                  inputLabel("lokasyon"),
                  TextFormField(
                    controller: viewModel.locationController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  timePickerStart,
             
                ],
              ),
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

  Widget get timePickerStart => TextButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        DatePicker.showDateTimePicker(context, showTitleActions: true,
            onChanged: (date) {
          viewModel.startTime = date;
        }, onConfirm: (date) {
          setState(() {
            viewModel.startTime = date;
          });
        }, currentTime: DateTime.now(), locale: LocaleType.tr);
      },
      child: Text(
        "etkinlik tarihi ${formatter.format(viewModel.startTime)}  ${viewModel.startTime.hour}:${viewModel.startTime.minute}",
        style: const TextStyle(color: Colors.blue, fontSize: 20),
      ));

 
}
