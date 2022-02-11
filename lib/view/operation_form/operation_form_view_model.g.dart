// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_form_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OperationFormViewModel on _OperationFormViewModelBase, Store {
  final _$outDatedOpertaionsAtom =
      Atom(name: '_OperationFormViewModelBase.outDatedOpertaions');

  @override
  List<OperationModel> get outDatedOpertaions {
    _$outDatedOpertaionsAtom.reportRead();
    return super.outDatedOpertaions;
  }

  @override
  set outDatedOpertaions(List<OperationModel> value) {
    _$outDatedOpertaionsAtom.reportWrite(value, super.outDatedOpertaions, () {
      super.outDatedOpertaions = value;
    });
  }

  final _$continuingOpertaionsAtom =
      Atom(name: '_OperationFormViewModelBase.continuingOpertaions');

  @override
  List<OperationModel> get continuingOpertaions {
    _$continuingOpertaionsAtom.reportRead();
    return super.continuingOpertaions;
  }

  @override
  set continuingOpertaions(List<OperationModel> value) {
    _$continuingOpertaionsAtom.reportWrite(value, super.continuingOpertaions,
        () {
      super.continuingOpertaions = value;
    });
  }

  @override
  String toString() {
    return '''
outDatedOpertaions: ${outDatedOpertaions},
continuingOpertaions: ${continuingOpertaions}
    ''';
  }
}
