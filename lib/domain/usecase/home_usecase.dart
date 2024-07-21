import 'package:app_with_clean_architecture/data/network/failure.dart';
import 'package:app_with_clean_architecture/domain/model/models.dart';
import 'package:app_with_clean_architecture/domain/repository/repository.dart';
import 'package:app_with_clean_architecture/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(
      void input) async {
    return await _repository.getHomeData();
  }
}



