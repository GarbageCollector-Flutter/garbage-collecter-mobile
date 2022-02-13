import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/buttons/cancel_button.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/model/operations/operation_model.dart';
import 'package:first_three/view/officier_form/officier_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:first_three/core/extenstions/string_extension.dart';


class OfficierFormView extends StatefulWidget {
  const OfficierFormView({Key? key}) : super(key: key);

  @override
  State<OfficierFormView> createState() => _OfficierFormViewState();
}

class _OfficierFormViewState extends BaseState<OfficierFormView> {
  late OfficierFormViewModel viewModel;




  @override
  Widget build(BuildContext context) {
return BaseView(
        viewModel: OfficierFormViewModel(),
        onDispose: (){
            for (final controller in viewModel.controllers) {
      controller.dispose();
    }
        },
        onModelReady: (model) async {
          viewModel = model as OfficierFormViewModel;
          viewModel.setContext(this.context);
         viewModel.operationModelProvider.setCollectionReference();
         viewModel.userModelProvider.setCollectionReference();
         await viewModel.getCurrentUser();
            viewModel.operationModel =
              ModalRoute.of(context)!.settings.arguments as OperationModel;
                       viewModel.setOfficerCollectionRef();

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
        suffix: CancelButton(onTap: ()async{
          
           String text = viewModel.controllers
          .where((element) => element.text != "")
          .fold("", (acc, element) => acc += "${element.text}\n");
      final alert = AlertDialog(
        title: Text("görevleriniz: ${viewModel.controllers.length}"),
        content: Text(text.trim()),
        actions: [
          TextButton(
            onPressed: ()async{
            bool isOk =  await viewModel.saveChanges();
            if(isOk){
             
              "göreve atandınız".snackBarExtension(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }else{
              "bir hata oluştu".snackBarExtension(context);
            }
            },
            child: const Text("OK"),
          ),
        ],
      );
      await showDialog(
        context: context,
        builder: (BuildContext context) => alert,
      );
      setState(() {});

                    }, size: const Size(120,50),child: const Text("kaydet",style: TextStyle(fontSize: 25)),),
      );
  Widget get body=>EmptySurface(
    
        child: SizedBox(
          height: dynamicHeight(1)-160,
          width: dynamicWidth(1),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            _addTile(),
            Expanded(
              flex: 1,
              child: _listView()),
     
           
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
  Widget _listView() {
  return ListView.builder(
    itemCount: viewModel.fields.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.all(5),
        child:  viewModel.fields[index],
      );
    },
  );
}
    Widget _addTile() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "görev ${viewModel.controllers.length + 1}",
          ),
        );

        setState(() {
          viewModel.controllers.add(controller);
          viewModel.fields.add(field);
        });
      },
    );
  }

}