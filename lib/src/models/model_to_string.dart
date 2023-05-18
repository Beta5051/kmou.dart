import 'dart:mirrors';

mixin ModelToString {
  @override
  String toString() {
    final reflectModel = reflect(this);
    return '$runtimeType(${reflectModel.type.declarations.values.whereType<VariableMirror>().map((variable) => '${MirrorSystem.getName(variable.simpleName)}: ${reflectModel.getField(variable.simpleName).reflectee}').join(', ')})';
  }
}
