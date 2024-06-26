
import 'package:equatable/equatable.dart';


abstract class Failure extends Equatable{

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure{}
class DatabaseFailure extends Failure{}

class CacheFailure extends Failure{}

class NoDataFailure extends Failure{}

class SerializationFailure extends Failure{}

class ValidationFailure extends Failure{
  final Map<String, List<String>> errors;
  ValidationFailure({required this.errors});
}
class SingleMessageFailure extends Failure{
  final String message;
  SingleMessageFailure({required this.message});
}