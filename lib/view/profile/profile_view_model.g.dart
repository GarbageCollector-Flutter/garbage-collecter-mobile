// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$operationsAtom = Atom(name: '_ProfileViewModelBase.operations');

  @override
  ObservableList<OperationModel> get operations {
    _$operationsAtom.reportRead();
    return super.operations;
  }

  @override
  set operations(ObservableList<OperationModel> value) {
    _$operationsAtom.reportWrite(value, super.operations, () {
      super.operations = value;
    });
  }

  @override
  String toString() {
    return '''
operations: ${operations}
    ''';
  }
}
