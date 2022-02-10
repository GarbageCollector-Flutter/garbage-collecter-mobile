import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_three/core/init/database/firestore_provider.dart';
import 'package:first_three/model/player/player_model.dart';
import 'package:first_three/model/tournament/tournament_model.dart';


class TournamentFirestoreProvider
    implements FirestoreProvider<TournamentModel> {

  
  @override
  CollectionReference<Map<String, dynamic>>? collectionReference;

  @override
  Future<TournamentModel?> getItem(String id) {
    // TODO: implement getItem
    throw UnimplementedError();
  }


  @override
  Future<List<TournamentModel>> getItemList() async {
    List<TournamentModel> tournamentList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference!.
        get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> tournament
        in querySnapshot.docs) {
      tournament.data().addEntries([MapEntry('id', tournament.id)]);
      Map<String, dynamic> touramentWithId = tournament.data();
      touramentWithId['id'] = tournament.id;
      tournamentList.add(TournamentModel.fromJson(touramentWithId));
    }

    return tournamentList;
  }
    Future<TournamentModel> getTournamentFromPAth(String path) async {
   DocumentReference<Map<String, dynamic>> tournamentRef = FirebaseFirestore.instance.doc(path);
   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =await  tournamentRef.get();
  TournamentModel tournamentModel = TournamentModel.fromJson(documentSnapshot.data()!); 
  tournamentModel.id=path;
  return tournamentModel;
  }
      Future<List<PlayerModel>> getTournamentRanksFromPAth(String path) async {
List<PlayerModel> playerList=[];
   CollectionReference<Map<String, dynamic>> tournamentRef = FirebaseFirestore.instance.collection(path);
   QuerySnapshot<Map<String, dynamic>> documentSnapshot =await  tournamentRef.get();
  documentSnapshot.docs.forEach((element) { 
    playerList.add(PlayerModel.fromJson(element.data()));
  });
  return playerList;
  }


  @override
  Future<bool> insertItem(TournamentModel model) async {
    try {
      await collectionReference!.add(model.toJson()).then((value) => null);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isExist(TournamentModel model) {
    // TODO: implement isExist
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllItems() {
    // TODO: implement removeAllItems
    throw UnimplementedError();
  }

  @override
  Future<bool> removeItem(int id) {
    // TODO: implement removeItem
    throw UnimplementedError();
  }

  @override
  Future<bool> updateItem(int id, TournamentModel model) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }


  @override
  void setCollectionReference(CollectionReference<Map<String, dynamic>> collectionReference) {
    this.collectionReference =collectionReference;
  }

}
