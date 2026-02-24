import 'package:dartz/dartz.dart';
import 'package:todos_api/core/error/failures.dart';

/// Contrat générique pour tous les use cases.
/// [Type] = type de retour, [Params] = paramètres d'entrée.
// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// À utiliser quand le use case ne nécessite aucun paramètre.
class NoParams {}
