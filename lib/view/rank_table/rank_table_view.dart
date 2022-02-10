import 'package:easy_localization/easy_localization.dart';
import 'package:first_three/core/base/state/base_state.dart';
import 'package:first_three/core/base/view/base_view.dart';
import 'package:first_three/core/components/widgets/cards/empty_surface.dart';
import 'package:first_three/core/components/widgets/others/my_appbar.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/model/tournament/tournament_model.dart';
import 'package:first_three/view/rank_table/rank_table_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RankTableView extends StatefulWidget {
  RankTableView({Key? key}) : super(key: key);

  @override
  State<RankTableView> createState() => _RankTableViewState();
}

class _RankTableViewState extends BaseState<RankTableView> {
  late RankTableViewModel viewModel;
  int placement = 0;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: RankTableViewModel(),
        onModelReady: (model) {
          viewModel = model as RankTableViewModel;
          viewModel.setContext(this.context);
          viewModel.tournamentPath =
              ModalRoute.of(context)!.settings.arguments as String;
          viewModel.getRanks();
          viewModel.getTournament();
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
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyAppBar(
                    lead: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("Turnuva",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w800)),
                  ))),
        ],
      ));

  Widget get body => Column(children: [tournamentInfo,rankFields]);

  Widget get tournamentInfo => EmptySurface(child:Observer(builder: (context){
    if(TournamentModel != null){
      final f = new DateFormat('yyyy-MM-dd hh:mm');

    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          Text(viewModel.tournamentModel!.gameName!,style: TextStyle(fontSize: 20),),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("turnuva ödülü: ${viewModel.tournamentModel!.reward}"),Text("bitiş: "+f.format(new DateTime.fromMillisecondsSinceEpoch(viewModel.tournamentModel!.tournamentFinishTime!)))
],)
        ],
      ),
    );
    }else{
      return Container();
    }

  },));
  Widget get rankFields => EmptySurface(child: Container(
        child: Observer(builder: (context) {
          return Column(
            children: [
              tableHeader,
              for (PlayerModel playerModel in viewModel.ranks)
                playerScore(playerModel)
            ],
          );
        }),
      ));
  Widget get tableHeader => Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.3),
              child: Text(
                "sıra",
                style: TextStyle(
                    fontSize: 25,
                    color: themeData.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.3),
              child: Text(
                "puan",
                style: TextStyle(
                    fontSize: 25,
                    color: themeData.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.3),
              child: Text(
                "isim",
                style: TextStyle(
                    fontSize: 25,
                    color: themeData.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
  Widget playerScore(PlayerModel playerModel) {
    placement++;
    Color color;
    if (placement % 2 == 1) {
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
              width: dynamicWidth(0.3),
              child: Text(
                placement.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.3),
              child: Text(
                playerModel.highScore.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: dynamicWidth(0.3),
              child: Text(
                playerModel.name.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
