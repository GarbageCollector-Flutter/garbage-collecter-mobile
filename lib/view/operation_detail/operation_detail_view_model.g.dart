// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OperationDetailViewModel on _OperationDetailViewModelBase, Store {
  final _$operationModelAtom =
      Atom(name: '_OperationDetailViewModelBase.operationModel');

  @override
  OperationModel? get operationModel {
    _$operationModelAtom.reportRead();
    return super.operationModel;
  }

  @override
  set operationModel(OperationModel? value) {
    _$operationModelAtom.reportWrite(value, super.operationModel, () {
      super.operationModel = value;
    });
  }

  final _$organizatorAtom =
      Atom(name: '_OperationDetailViewModelBase.organizator');

  @override
  UserModel? get organizator {
    _$organizatorAtom.reportRead();
    return super.organizator;
  }

  @override
  set organizator(UserModel? value) {
    _$organizatorAtom.reportWrite(value, super.organizator, () {
      super.organizator = value;
    });
  }

  final _$officersAtom = Atom(name: '_OperationDetailViewModelBase.officers');

  @override
  ObservableList<UserOfficer> get officers {
    _$officersAtom.reportRead();
    return super.officers;
  }

  @override
  set officers(ObservableList<UserOfficer> value) {
    _$officersAtom.reportWrite(value, super.officers, () {
      super.officers = value;
    });
  }

  final _$garbage_collectersAtom =
      Atom(name: '_OperationDetailViewModelBase.garbage_collecters');

  @override
  ObservableList<UserModel> get garbage_collecters {
    _$garbage_collectersAtom.reportRead();
    return super.garbage_collecters;
  }

  @override
  set garbage_collecters(ObservableList<UserModel> value) {
    _$garbage_collectersAtom.reportWrite(value, super.garbage_collecters, () {
      super.garbage_collecters = value;
    });
  }

  @override
  String toString() {
    return '''
operationModel: ${operationModel},
organizator: ${organizator},
officers: ${officers},
garbage_collecters: ${garbage_collecters}
    ''';
  }
}
