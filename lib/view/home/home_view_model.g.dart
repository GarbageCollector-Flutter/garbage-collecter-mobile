// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$outDatedTournamentsAtom =
      Atom(name: '_HomeViewModelBase.outDatedTournaments');

  @override
  List<TournamentModel> get outDatedTournaments {
    _$outDatedTournamentsAtom.reportRead();
    return super.outDatedTournaments;
  }

  @override
  set outDatedTournaments(List<TournamentModel> value) {
    _$outDatedTournamentsAtom.reportWrite(value, super.outDatedTournaments, () {
      super.outDatedTournaments = value;
    });
  }

  final _$continuingTournamentsAtom =
      Atom(name: '_HomeViewModelBase.continuingTournaments');

  @override
  List<TournamentModel> get continuingTournaments {
    _$continuingTournamentsAtom.reportRead();
    return super.continuingTournaments;
  }

  @override
  set continuingTournaments(List<TournamentModel> value) {
    _$continuingTournamentsAtom.reportWrite(value, super.continuingTournaments,
        () {
      super.continuingTournaments = value;
    });
  }

  @override
  String toString() {
    return '''
outDatedTournaments: ${outDatedTournaments},
continuingTournaments: ${continuingTournaments}
    ''';
  }
}
