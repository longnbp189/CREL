import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/firebase_options.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/store/store_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:crel_mobile/modules/appointment/repos/contract_repo.dart';
import 'package:crel_mobile/modules/appointment/repos/store_repo.dart';
import 'package:crel_mobile/modules/authentication/blocs/authentication_bloc.dart';
import 'package:crel_mobile/modules/authentication/repos/authentication_repo.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/media/media_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/repos/brand_repo.dart';
import 'package:crel_mobile/modules/mission/blocs/district/district_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/location/location_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/project/project_bloc.dart';
import 'package:crel_mobile/modules/mission/repos/district_repo.dart';
import 'package:crel_mobile/modules/mission/repos/location_repo.dart';
import 'package:crel_mobile/modules/mission/repos/project_repo.dart';
import 'package:crel_mobile/modules/mission/repos/ward_repo.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/profile/blocs/suggest_property/suggest_property_bloc.dart';
import 'package:crel_mobile/modules/profile/blocs/team/team_bloc.dart';
import 'package:crel_mobile/modules/profile/repos/media_repo.dart';
import 'package:crel_mobile/modules/profile/repos/profile_repo.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:crel_mobile/modules/profile/repos/suggest_property_repo.dart';
import 'package:crel_mobile/modules/profile/repos/team_repo.dart';
import 'package:crel_mobile/modules/unauthentication/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
  LocalNotification.createanddisplaynotification(message);
}

Future<void> main() async {
  // HttpOverrides.global = MyHttpOverrides();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(statusBarColor: AppColor.primaryColor),
  // );
  //  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  LocalNotification.initialize;

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepo>(
            create: (context) => AuthenticationRepo()),
        RepositoryProvider<ProfileRepo>(create: (context) => ProfileRepo()),
        RepositoryProvider<PropertyRepo>(create: (context) => PropertyRepo()),
        RepositoryProvider<BrandRepo>(create: (context) => BrandRepo()),
        RepositoryProvider<TeamRepo>(create: (context) => TeamRepo()),
        RepositoryProvider<MediaRepo>(create: (context) => MediaRepo()),
        RepositoryProvider<LocationRepo>(create: (context) => LocationRepo()),
        RepositoryProvider<DistrictRepo>(create: (context) => DistrictRepo()),
        RepositoryProvider<WardRepo>(create: (context) => WardRepo()),
        RepositoryProvider<ProjectRepo>(create: (context) => ProjectRepo()),
        RepositoryProvider<AppointmentRepo>(
            create: (context) => AppointmentRepo()),
        RepositoryProvider<ContractRepo>(create: (context) => ContractRepo()),
        RepositoryProvider<SuggestPropertyRepo>(
            create: (context) => SuggestPropertyRepo()),
        RepositoryProvider<StoreRepo>(create: (context) => StoreRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
              profileRepo: RepositoryProvider.of<ProfileRepo>(context),
              authenticationRepo:
                  RepositoryProvider.of<AuthenticationRepo>(context),
            )..add(AppStarted()),
          ),
          BlocProvider<ProfileBloc>(
              create: (BuildContext context) => ProfileBloc(
                    profileRepo: RepositoryProvider.of<ProfileRepo>(context),
                  )
              // ..add(GetProfileRequested()),
              ),
          BlocProvider<PropertyForRentBloc>(
            create: (BuildContext context) => PropertyForRentBloc(
              propertyForRentRepo: RepositoryProvider.of<PropertyRepo>(context),
            ),
          ),
          BlocProvider<BrandBloc>(
            create: (BuildContext context) => BrandBloc(
              brandRepo: RepositoryProvider.of<BrandRepo>(context),
            )..add(const GetBrandRequested(true)),
          ),
          BlocProvider<TeamBloc>(
            create: (BuildContext context) => TeamBloc(
              teamRepo: RepositoryProvider.of<TeamRepo>(context),
            )..add(GetTeamRequested()),
          ),
          BlocProvider<MediaBloc>(
            create: (BuildContext context) => MediaBloc(
              mediaRepo: RepositoryProvider.of<MediaRepo>(context),
            ),
          ),
          BlocProvider<LocationBloc>(
            create: (BuildContext context) => LocationBloc(
              locationRepo: RepositoryProvider.of<LocationRepo>(context),
            ),
          ),
          BlocProvider<DistrictBloc>(
            create: (BuildContext context) => DistrictBloc(
              districtRepo: RepositoryProvider.of<DistrictRepo>(context),
            )..add(GetDistrictRequested()),
          ),
          // BlocProvider<WardBloc>(
          //   create: (BuildContext context) => WardBloc(
          //     wardRepo: RepositoryProvider.of<WardRepo>(context),
          //   ),
          // ),
          BlocProvider<ProjectBloc>(
              create: (BuildContext context) => ProjectBloc(
                    projectRepo: RepositoryProvider.of<ProjectRepo>(context),
                  )
              // ..add(GetProjectRequested())
              ),

          BlocProvider<AppointmentBloc>(
              create: (BuildContext context) => AppointmentBloc(
                    appointmentRepo:
                        RepositoryProvider.of<AppointmentRepo>(context),
                  )..add(SearchAppointmentByMonth(
                      AppFormat.startDayOfMonth(date),
                      AppFormat.endDayOfMonth(date),
                      true))),
          // ..add(const GetListConfirmAppointment(true))),

          BlocProvider<AppointmentConfirmBloc>(
              create: (BuildContext context) => AppointmentConfirmBloc(
                    appointmentRepo:
                        RepositoryProvider.of<AppointmentRepo>(context),
                  )..add(GetAppointmentConfirm())),
          BlocProvider<ContractBloc>(
              create: (BuildContext context) => ContractBloc(
                    propertyRepo: RepositoryProvider.of<PropertyRepo>(context),
                    contractRepo: RepositoryProvider.of<ContractRepo>(context),
                  )
              // ..add(const GetContractRequested(true))
              ),
          BlocProvider<SuggestPropertyBloc>(
              create: (BuildContext context) => SuggestPropertyBloc(
                    suggestPropertyRepo:
                        RepositoryProvider.of<SuggestPropertyRepo>(context),
                  )),
          BlocProvider<StoreBloc>(
              create: (BuildContext context) => StoreBloc(
                    storeRepo: RepositoryProvider.of<StoreRepo>(context),
                  )),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primaryColor: AppColor.primaryColor,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColor.primaryColor,
                selectionColor: AppColor.primaryColor.withOpacity(0.2),
                selectionHandleColor: AppColor.primaryColor,
              ),
              // scaffoldBackgroundColor: AppColor.primaryColor,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              SfGlobalLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('vi'),
              Locale('en'),
              // Locale('ja'),
            ],
            locale: const Locale('vi'),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const WelcomePage()),
      ),
    );
  }
}
