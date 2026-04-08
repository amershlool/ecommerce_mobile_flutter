import "package:e_commerce/view/screen/paymentMethod/add_payment_method.dart";
import "package:e_commerce/view/screen/address/address_add.dart";
import "package:e_commerce/view/screen/address/address_edit.dart";
import "package:e_commerce/view/screen/address/address_view.dart";
import "package:e_commerce/view/screen/all_offers.dart";
import "package:e_commerce/view/screen/cart.dart";
import "package:e_commerce/view/screen/categories.dart";
import "package:e_commerce/view/screen/check_out.dart";
import "package:e_commerce/view/screen/featured_products.dart";
import "package:e_commerce/view/screen/home_screen.dart";
import "package:e_commerce/view/screen/items.dart";
import "package:e_commerce/view/screen/my_favorite.dart";
import "package:e_commerce/view/screen/notification.dart";
import "package:e_commerce/view/screen/offers.dart";
import "package:e_commerce/view/screen/orders.dart";
import "package:e_commerce/view/screen/change_password.dart";
import "package:e_commerce/view/screen/paymentMethod/payment_methods.dart";
import "package:e_commerce/view/screen/profile.dart";
import "package:e_commerce/view/screen/settings.dart";
import "package:e_commerce/view/widget/orders/custom_orders_list_card_cond_in_history.dart";
import "package:get/get.dart";
import "package:e_commerce/core/middleware/mymiddleware.dart";
import "package:e_commerce/view/screen/auth/forgotpassword/forgotpassword.dart";
import "package:e_commerce/view/screen/auth/forgotpassword/newpassword.dart";
import "package:e_commerce/view/screen/auth/forgotpassword/verificationpassword.dart";
import "package:e_commerce/view/screen/auth/login.dart";
import "package:e_commerce/view/screen/auth/signup.dart";
import "package:e_commerce/view/screen/auth/startauth.dart";
import "package:e_commerce/view/screen/auth/successsignup.dart";
import "package:e_commerce/view/screen/auth/verificationsignup.dart";
import "package:e_commerce/view/screen/onBoarding.dart";
import "core/constant/routesname.dart";

List<GetPage<dynamic>>? routes = [
  //=====================INIT==============================
  GetPage(
    name: "/",
    page: () => const MyOnBoarding(),
    middlewares: [MyMiddleware()],
  ),
  //GetPage(name: "/", page: ()=>const ProductDetails()),
  // GetPage(name: "/", page: ()=>const TestView()),
  // GetPage(name: "/", page: () => const Cart()),
  //=====================AUTH==============================
  GetPage(name: AppRoutes.startAuth, page: () => const StartAuth()),
  GetPage(name: AppRoutes.logIn, page: () => const Login()),
  GetPage(name: AppRoutes.signup, page: () => const Signup()),
  GetPage(
    name: AppRoutes.verificationSignUp,
    page: () => const VerificationSignUp(),
  ),
  //=====================FORGOT==============================
  GetPage(name: AppRoutes.forgot, page: () => const ForgotPassword()),
  GetPage(name: AppRoutes.newPassword, page: () => const NewPassword()),
  GetPage(
    name: AppRoutes.verificationPassword,
    page: () => const VerificationPassword(),
  ),
  //=====================SUCCESS==============================
  GetPage(name: AppRoutes.successSignup, page: () => const SuccessSignup()),
  //=====================Home==============================
  GetPage(name: AppRoutes.homepage, page: () => const HomeScreen()),
  //=====================Items==============================
  GetPage(name: AppRoutes.items, page: () => const Items()),
  //=====================Favorite==============================
  GetPage(name: AppRoutes.myFavorite, page: () =>  MyFavorite()),
  //=====================Settings==============================
  GetPage(name: AppRoutes.settings, page: () => const Settings()),

  //=====================Cart==============================
  GetPage(name: AppRoutes.cart, page: () => Cart()),
  GetPage(name: AppRoutes.checkOut, page: () => CheckOut()),
  //=====================Address==============================
  GetPage(name: AppRoutes.addressView, page: () => const AddressView()),
  GetPage(name: AppRoutes.addressAdd, page: () => const AddressAdd()),
  GetPage(name: AppRoutes.addressEdit, page: () => const AddressEdit()),
  //=====================Orders==============================
  GetPage(name: AppRoutes.orders, page: () => const Orders()),
  GetPage(
    name: AppRoutes.ordersHistory,
    page: () => const CustomOrdersListCardCondHistory(isAppBar: true),
  ),
  //=====================Notification==============================
  GetPage(name: AppRoutes.notification, page: () => const NotificationScreen()),
  //=====================Offers==============================
  GetPage(name: AppRoutes.offers, page: () =>  Offers()),
  GetPage(name: AppRoutes.allOffers, page: () =>  AllOffers()),
  //=====================FeaturedProducts==============================
  GetPage(name: AppRoutes.featuredProducts, page: () =>  FeaturedProducts()),
  //=====================Categories==============================
  GetPage(name: AppRoutes.categories, page: () =>  Categories()),
  //=====================Profile==============================
  GetPage(name: AppRoutes.profile, page: () =>  Profile()),
  //=====================paymentMethods==============================
  GetPage(name: AppRoutes.paymentMethods, page: () =>  PaymentMethods()),
  GetPage(name: AppRoutes.addPaymentMethods, page: () =>  AddPaymentMethod()),
  //=====================Change Password==============================
GetPage(name: AppRoutes.changePassword, page: ()=>ChangePassword()),

];
