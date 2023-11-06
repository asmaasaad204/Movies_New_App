import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/popular_movies_responses.dart';
import '../../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../../../data/repos/movies_repo/movies_repo.dart';

class PopMoviesModelView extends Cubit<MoviesStatePop> {
  MoviesRepo moviesRepo = MoviesRepo(OnlineDataSources());

  PopMoviesModelView() : super(LoadingStatePop());

  void getPop() async {
    emit(LoadingStatePop());
    try {
      PopularMoviesResponses? response = await moviesRepo.getPopMovies();
      if (response != null && response.results!.isNotEmpty == true) {
        emit(SuccessStatePop(response.results!));
      } else {
        throw "Something went wrong please try again later...!";
      }
    } catch (error) {
      emit(ErrorStatePop(error.toString()));
    }
  }
}

class MoviesStatePop {}

class SuccessStatePop extends MoviesStatePop {
  List<ResultsPop> results = [];

  SuccessStatePop(this.results);
}

class LoadingStatePop extends MoviesStatePop {}

class ErrorStatePop extends MoviesStatePop {
  String errorText;

  ErrorStatePop(this.errorText);
}
