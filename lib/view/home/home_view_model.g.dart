// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$outDatedOpertaionsAtom =
      Atom(name: '_HomeViewModelBase.outDatedOpertaions');

  @override
  ObservableList<OperationModel> get outDatedOpertaions {
    _$outDatedOpertaionsAtom.reportRead();
    return super.outDatedOpertaions;
  }

  @override
  set outDatedOpertaions(ObservableList<OperationModel> value) {
    _$outDatedOpertaionsAtom.reportWrite(value, super.outDatedOpertaions, () {
      super.outDatedOpertaions = value;
    });
  }

  final _$continuingOpertaionsAtom =
      Atom(name: '_HomeViewModelBase.continuingOpertaions');

  @override
  ObservableList<OperationModel> get continuingOpertaions {
    _$continuingOpertaionsAtom.reportRead();
    return super.continuingOpertaions;
  }

  @override
  set continuingOpertaions(ObservableList<OperationModel> value) {
    _$continuingOpertaionsAtom.reportWrite(value, super.continuingOpertaions,
        () {
      super.continuingOpertaions = value;
    });
  }

  final _$getAllOperationsAsyncAction =
      AsyncAction('_HomeViewModelBase.getAllOperations');

  @override
  Future<void> getAllOperations() {
    return _$getAllOperationsAsyncAction.run(() => super.getAllOperations());
  }

  @override
  String toString() {
    return '''
outDatedOpertaions: ${outDatedOpertaions},
continuingOpertaions: ${continuingOpertaions}
    ''';
  }
}
