import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:metaprogramacao_estatica/annotation/getters.dart';
import 'package:source_gen/source_gen.dart';

Builder gettersBuilder(BuilderOptions options) =>
    PartBuilder([GettersGenerator()], '.g.dart');

class GettersGenerator extends GeneratorForAnnotation<Getters> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'A anotação @Getter só pode ser aplicada a classes',
        element: element,
      );
    }

    final className = element.name;
    final buffer = StringBuffer();

    final privateFields = element.fields.where((f) => f.isPrivate);

    if (privateFields.isEmpty) {
      throw InvalidGenerationSourceError(
        'A classe $className não tem campos privados!',
        element: element,
      );
    }

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln();

    buffer.writeln('extension ${className}Getters on $className {');

    for (final f in privateFields) {
      final fieldName = f.name ?? '';
      final getterName = fieldName.substring(1);
      final fieldType = f.type.getDisplayString();

      buffer.writeln(
        '/// Getter gerado automaticamente para o campo privado $fieldName',
      );
      buffer.writeln('  $fieldType get $getterName => $fieldName');
      buffer.writeln();
    }
    buffer.writeln('}');
    return buffer.toString();
  }
}
