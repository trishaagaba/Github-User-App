import 'package:flutter/material.dart';
import 'package:git_user_app/features/user_profile/data/repository/userprofile_rep_imp.dart';
import 'package:git_user_app/features/user_profile/domain/usecases/userdetails_usecase.dart';
import 'package:provider/provider.dart';
import 'features/user_lists/data/datasources/remote/data_source.dart';
import 'features/user_lists/data/repository/user_repository_impl.dart';
import 'features/user_lists/domain/usecases/get_users_useCase.dart';
import 'features/user_lists/presentation/providers/user_provider.dart';
import 'features/user_lists/presentation/providers/connectivity_provider.dart';
import 'features/user_lists/presentation/screens/splash.dart';
import 'features/user_profile/data/datasources/details_source.dart';
import 'features/user_profile/presentation/providers/user_profile_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = DataSource();
    final userRepository = UserRepositoryImpl(dataSource);
    final getUsersUseCase = GetUsersUseCase(userRepository);

    final detailsSource = DetailsSource();
    final userProfileRep = UserprofileRepImp(detailsSource);
    final userDetailsUseCase = UserdetailsUsecase(userProfileRep);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider(getUsersUseCase)),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider(userDetailsUseCase)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Web App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD1BBCC)),
          useMaterial3: true,
        ),
        home: const WelcomePage(),
      ),
    );
  }
}
