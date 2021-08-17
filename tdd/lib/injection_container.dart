import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/core/utils/input_converter.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'package:tdd/features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'package:tdd/features/year_trivia/data/repositories/year_trivia_repository_impl.dart';
import 'package:tdd/features/year_trivia/domain/repositories/year_trivia_repository.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';
import 'package:tdd/features/year_trivia/domain/usecases/get_random_year_trivia.dart';
import 'package:tdd/features/year_trivia/presentation/bloc/year_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features = Number Trivia
  // BLoC - Number Trivia
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );
  // BLoC - Year Trivia
  sl.registerFactory(
    () => YearTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases - Number Trivia
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  // Use cases - Year Trivia
  sl.registerLazySingleton(() => GetConcreteYearTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomYearTrivia(sl()));

  // Repository - Number Trivia
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Repository - Year Trivia
  sl.registerLazySingleton<YearTrivaRepository>(
    () => YearTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources - Number Trivia
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  // Data sources - Year Trivia
  sl.registerLazySingleton<YearTriviaRemoteDataSource>(
    () => YearTriviaRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<YearTriviaLocalDataSource>(
    () => YearTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
