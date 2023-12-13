import 'package:crel_mobile/common/widgets/stateful/custom_nav_bar.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/project.dart';
import 'package:crel_mobile/modules/appointment/pages/appointment_page.dart';
import 'package:crel_mobile/modules/appointment/pages/create_appointment_page.dart';
import 'package:crel_mobile/modules/appointment/pages/create_contract_page.dart';
import 'package:crel_mobile/modules/appointment/pages/add_property_appointment_page.dart';
import 'package:crel_mobile/modules/appointment/widgets/calender.dart';
import 'package:crel_mobile/modules/home/pages/brand_detail.dart';
import 'package:crel_mobile/modules/home/pages/home_page.dart';
import 'package:crel_mobile/modules/home/pages/project_detail.dart';
import 'package:crel_mobile/modules/home/pages/property_detail.dart';
import 'package:crel_mobile/modules/mission/pages/mission_page.dart';
import 'package:crel_mobile/modules/mission/pages/update_property_page.dart';
import 'package:crel_mobile/modules/notification/pages/notification_page.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/profile/pages/change_password_first_page.dart';
import 'package:crel_mobile/modules/profile/pages/contract_detail_page.dart';
import 'package:crel_mobile/modules/profile/pages/contract_page.dart';
import 'package:crel_mobile/modules/profile/pages/edit_contract_page_final.dart';
import 'package:crel_mobile/modules/profile/pages/edit_profile_page.dart';
import 'package:crel_mobile/modules/profile/pages/extend_contract_page.dart';
import 'package:crel_mobile/modules/profile/pages/profile_page.dart';
import 'package:crel_mobile/modules/profile/pages/change_password_page.dart';
import 'package:crel_mobile/modules/profile/pages/verify_contract_page.dart';
import 'package:crel_mobile/modules/profile/pages/view_profile_page.dart';
import 'package:crel_mobile/modules/profile/repos/profile_repo.dart';
import 'package:crel_mobile/modules/property_management/pages/property_management_page.dart';
import 'package:crel_mobile/modules/unauthentication/pages/forget_password_page.dart';
import 'package:crel_mobile/modules/unauthentication/pages/sign_up_page.dart';
import 'package:crel_mobile/modules/unauthentication/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const String homePage = "/";
  static const String profilePage = "/profile";
  static const String welcomePage = "/welcome";
  static const String appointmentPage = "/appointment";
  static const String changePasswordPage = "/change-password";
  static const String changePasswordPageFirst = "/change-password-first";
  static const String forgetPasswordPage = "/forget-password";
  static const String customNavBar = "/custom-nav-bar";
  static const String editProfile = "/edit-profile";
  static const String teamPage = "/team";
  static const String managerPropertyPage = "/manager-property";
  static const String missionPage = "/mission";
  static const String notificationPage = "/notification";
  static const String signUpPage = "/sign-up";
  static const String propertyDetail = "/property-detail";
  static const String brandDetail = "/brand-detail";
  static const String updateProperty = "/update-property";
  static const String showFullImage = "/show-full-imgae";
  static const String projectPage = "/project";
  static const String calendarView = "/calendar";
  static const String createContract = "/create-contract";
  static const String createAppointment = "/create-appointment";
  static const String suggestProperty = "/suggest-property";
  static const String contractPage = "/contract";
  static const String contractDetailPage = "/contract-detail";
  static const String editContractPage = "/edit-contract";
  static const String viewProfile = "/view-profile";
  static const String verifyContract = "/verify-contract";
  static const String extendContract = "/extend-contract";
  // static const String appointmentDetail = "/appointment-detail";
  static Route onGenerateRoute(RouteSettings settings) {
    print("This is route: ${settings.name}");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case welcomePage:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case appointmentPage:
        return MaterialPageRoute(builder: (_) => const AppointmentPage());
      case changePasswordPage:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case changePasswordPageFirst:
        return MaterialPageRoute(
            builder: (_) => const ChangePasswordFirstPage());
      case forgetPasswordPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileBloc(
                      profileRepo: RepositoryProvider.of<ProfileRepo>(context)),
                  child: const ForgetPasswordPage(),
                ));
      case customNavBar:
        return MaterialPageRoute(
            builder: (_) => CustomNavBar(
                  index: settings.arguments as int,
                ));
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case viewProfile:
        return MaterialPageRoute(builder: (_) => const ViewProfilePage());
      // case teamPage:
      //   return MaterialPageRoute(builder: (_) => const TeamPage());
      case managerPropertyPage:
        return MaterialPageRoute(
            builder: (_) => const PropertyManagementPage());
      case missionPage:
        return MaterialPageRoute(builder: (_) => const MissionPage());
      case notificationPage:
        return MaterialPageRoute(
            builder: (_) => NotificationPage(
                  id: settings.arguments as String,
                ));
      case signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case calendarView:
        return MaterialPageRoute(builder: (_) => const Calender());
      // case showFullImage:
      //   return MaterialPageRoute(
      //       builder: (_) => FullScreenImage(
      //             imageUrl: settings.arguments as String,
      //             tag: settings.arguments as String,
      //           ));
      case propertyDetail:
        return MaterialPageRoute(
            builder: (_) => PropertyDetail(
                  propertyForRent: settings.arguments as Property,
                ));
      // propertyForRent:
      //     (settings.arguments as ScreenPropertyArguments).property,
      // id: (settings.arguments as ScreenPropertyArguments).id));
      case updateProperty:
        return MaterialPageRoute(
            builder: (_) =>
                UpdatePropetyPage(property: settings.arguments as Property));
      case brandDetail:
        return MaterialPageRoute(
            builder: (_) => BrandDetail(
                  id: settings.arguments as int,
                ));
      case projectPage:
        return MaterialPageRoute(
            builder: (_) =>
                ProjectDetail(project: settings.arguments as Project));
      case createContract:
        return MaterialPageRoute(
            builder: (_) => CreateContractPage(
                appointment: settings.arguments as Appointment?));

      //  builder: (_) => CreateContractPage(
      //   property: (settings.arguments as Property?),
      //   appointment:
      //       (settings.arguments as Appointment?)));
      case createAppointment:
        return MaterialPageRoute(builder: (_) => const CreateAppointmentPage());
      case suggestProperty:
        return MaterialPageRoute(
            builder: (_) => const AddPropertyAppointmentPage());
      case contractPage:
        return MaterialPageRoute(
            builder: (_) => ContractPage(
                  id: settings.arguments as int?,
                ));
      case contractDetailPage:
        return MaterialPageRoute(
            builder: (_) => ContractDetailPage(
                  contract: settings.arguments as Contract,
                ));
      case editContractPage:
        return MaterialPageRoute(
            builder: (_) => EditContractPageFinal(
                contract: settings.arguments as Contract));
      case verifyContract:
        return MaterialPageRoute(
            builder: (_) =>
                VerifyContractPage(contract: settings.arguments as Contract));
      case extendContract:
        return MaterialPageRoute(
            builder: (_) => ExtendEditContractPage(
                contract: settings.arguments as Contract));
      //          case appointmentDetail:
      // return MaterialPageRoute(
      //     builder: (_) =>
      //         ProjectDetail(project: settings.arguments as Project));
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: "/error"),
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text("Error")),
            ));
  }
}

class ScreenContractArguments {
  final Contract contract;
  final int? id;

  ScreenContractArguments(this.contract, this.id);
}

class ScreenPropertyArguments {
  final Property property;
  final int? id;

  ScreenPropertyArguments(this.property, this.id);
}
