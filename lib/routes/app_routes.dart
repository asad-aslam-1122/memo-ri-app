import 'package:get/get.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/change_password_view.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/congratulation_view.dart';
import 'package:memo_ri_app/src/auth/view/forget_reset_password/view/forget_password_view.dart';
import 'package:memo_ri_app/src/auth/view/login_view.dart';
import 'package:memo_ri_app/src/auth/view/sign_up_view.dart';
import 'package:memo_ri_app/src/auth/view/terms_and_privacy_view.dart';
import 'package:memo_ri_app/src/base/view/base_view.dart';
import 'package:memo_ri_app/src/base/view/pages/events/view/pages/edit_event_view.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/home_view.dart';
import 'package:memo_ri_app/src/base/view/pages/home/view/pages/notification_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/album_photos_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/all_cate_albums.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/all_music_view.dart';
import 'package:memo_ri_app/src/base/view/pages/memory/view/pages/memory_dashboard_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/pages/contact_us_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/pages/delete_account_view.dart';
import 'package:memo_ri_app/src/base/view/pages/settings/view/pages/my_profile_view.dart';
import 'package:memo_ri_app/src/base/view/pages/subscription_view/view/subscription_view.dart';
import 'package:memo_ri_app/src/landing/onboard/view/onboard_view.dart';
import 'package:memo_ri_app/src/landing/splash_view.dart';
import 'package:memo_ri_app/src/language/view/language_view.dart';

import '../src/auth/view/forget_reset_password/view/verification_view.dart';
import '../src/base/view/pages/events/view/pages/create_event_view.dart';
import '../src/base/view/pages/events/view/pages/create_event_view2.dart';
import '../src/base/view/pages/home/view/pages/album_content_tab/main_album_tab_view.dart';
import '../src/base/view/pages/home/view/pages/album_content_tab/photos_view.dart';
import '../src/base/view/pages/home/view/pages/album_content_tab/video_player_view.dart';
import '../src/base/view/pages/home/view/pages/albums_view.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
        name: SplashView.route,
        page: () => const SplashView(),
        transition: Transition.circularReveal),
    GetPage(
        name: OnboardView.route,
        page: () => const OnboardView(),
        transition: Transition.fade),
    GetPage(
        name: LoginView.route,
        page: () => const LoginView(),
        transition: Transition.fade),
    GetPage(
        name: SignUpView.route,
        page: () => const SignUpView(),
        transition: Transition.fade),
    GetPage(
        name: TermsAndPrivacyView.route,
        page: () => const TermsAndPrivacyView(),
        transition: Transition.fade),
    GetPage(
        name: ForgetPasswordView.route,
        page: () => const ForgetPasswordView(),
        transition: Transition.fade),
    GetPage(
        name: VerificationView.route,
        page: () => const VerificationView(),
        transition: Transition.fade),
    GetPage(
        name: ChangePasswordView.route,
        page: () => const ChangePasswordView(),
        transition: Transition.fade),
    GetPage(
        name: CongratulationView.route,
        page: () => const CongratulationView(),
        transition: Transition.fade),
    GetPage(
        name: LanguageView.route,
        page: () => const LanguageView(),
        transition: Transition.fade),
    GetPage(
        name: BaseView.route,
        page: () => const BaseView(),
        transition: Transition.fade),
    GetPage(
        name: AlbumsView.route,
        page: () => const AlbumsView(),
        transition: Transition.fade),
    GetPage(
        name: MainAlbumTabView.route,
        page: () => const MainAlbumTabView(),
        transition: Transition.fade),
    GetPage(
        name: MyProfileView.route,
        page: () => const MyProfileView(),
        transition: Transition.fade),
    GetPage(
        name: ContactUsView.route,
        page: () => const ContactUsView(),
        transition: Transition.fade),
    GetPage(
        name: DeleteAccountView.route,
        page: () => const DeleteAccountView(),
        transition: Transition.fade),
    GetPage(
        name: CreateEventView.route,
        page: () => const CreateEventView(),
        transition: Transition.fade),
    GetPage(
        name: CreateEventView2.route,
        page: () => const CreateEventView2(),
        transition: Transition.fade),
    GetPage(
        name: VideoPlayerView.route,
        page: () => const VideoPlayerView(),
        transition: Transition.fade),
    GetPage(
        name: PhotosView.route,
        page: () => const PhotosView(),
        transition: Transition.fade),
    GetPage(
        name: NotificationView.route,
        page: () => const NotificationView(),
        transition: Transition.fade),
    GetPage(
        name: SubscriptionView.route,
        page: () => const SubscriptionView(),
        transition: Transition.fade),
    GetPage(
        name: EditEventView.route,
        page: () => const EditEventView(),
        transition: Transition.fade),
    GetPage(
        name: HomeView.route,
        page: () => const HomeView(),
        transition: Transition.fade),
    GetPage(
        name: AllMusicView.route,
        page: () => const AllMusicView(),
        transition: Transition.fade),
    GetPage(
        name: MemoryDashboardView.route,
        page: () => const MemoryDashboardView(),
        transition: Transition.fade),
    GetPage(
        name: AllCateAlbums.route,
        page: () => const AllCateAlbums(),
        transition: Transition.fade),
    GetPage(
        name: AlbumPhotosView.route,
        page: () => const AlbumPhotosView(),
        transition: Transition.fade),
  ];
}
