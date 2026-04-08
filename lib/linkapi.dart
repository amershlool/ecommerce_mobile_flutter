class AppLink {
  static const String server = "http://10.0.2.2/backendPHP/BackendLUX";
  // static const String server = "https://94db677233bc.ngrok-free.app/lux";
  static const String test = "$server/test.php";
  //=========================Image==============================//
  static const String imageStatic = "http://10.0.2.2/backendPHP/BackendLUX";
  //static const String imageStatic =  "$server/";
  static const String imageCategories =  "$imageStatic/categories";
  static const String imageItems =  "$imageStatic/items/image_item";
  static const String imageMarketing =  "$imageStatic/marketing/imageMarketing";
  //=========================Auth==============================//
  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";
  static const String verifyCodeSignup = "$server/auth/verifycode.php";
  static const String resend = "$server/auth/resend.php";
  //=========================ForgetPassword==============================//
  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String resetPassword = "$server/forgetpassword/resetpassword.php";
  static const String verifyCodeForgetPassword = "$server/forgetpassword/verifycode.php";
//=========================HomePage==============================//
  static const String homePage = "$server/home.php";
//=========================Items==============================//
  static const String items = "$server/items/items.php";
  static const String searchItems = "$server/items/search.php";
//=========================Favorite==============================//
  static const String addFavorite = "$server/favorite/add.php";
  static const String removeFavorite = "$server/favorite/remove.php";
  static const String viewFavorite = "$server/favorite/view.php";
  static const String deleteFavorite = "$server/favorite/delete_from_favorite.php";
  static const String searchFavorite = "$server/favorite/search.php";
//=========================Cart==============================//
  static const String addCarr = "$server/cart/add.php";
  static const String removeCart = "$server/cart/remove.php";
  static const String setCartQuantity  = "$server/cart/set_cart_quantity.php";
  static const String viewCart  = "$server/cart/view.php";
//=========================Address==============================//
  static const String addAddress = "$server/address/add.php";
  static const String viewAddress = "$server/address/view.php";
  static const String deleteAddress = "$server/address/delete.php";
  static const String editAddress = "$server/address/edit.php";
//=========================Coupon==============================//
  static const String checkCoupon = "$server/coupon/check_coupon.php";
//=========================CheckOut==============================//
  static const String checkOut = "$server/orders/checkout.php";
  //=========================Rating==============================//
  static const String rating = "$server/orders/rating.php";
//=========================Orders==============================//
  static const String ordersViewAll = "$server/orders/viewAll.php";
  static const String ordersViewProgress = "$server/orders/viewProgress.php";
  static const String ordersViewInTheWay = "$server/orders/viewInTheWay.php";
  static const String ordersViewHistory = "$server/orders/viewHistory.php";
  static const String ordersViewDetails = "$server/orders/viewOrderDetails.php";
  static const String ordersViewAwaitApprove = "$server/orders/viewAwaitApprove.php";
  static const String ordersRemove = "$server/orders/removeOrder.php";
//=========================Tokens==============================//
  static const String tokenSave = "$server/token/save_token.php";
  static const String tokenRemove = "$server/token/remove_token.php";
//=========================Notification==============================//
  static const String notification = "$server/notification/notificationView.php";
  static const String notificationIsRead = "$server/notification/notificationIsRead.php";
  static const String notificationIsNotRead = "$server/notification/notificationIsNotRead.php";
  static const String notificationRemove = "$server/notification/notificationRemove.php";
  static const String notificationRemoveAll = "$server/notification/notificationRemoveAll.php";
//=========================Offers==============================//
  static const String offers = "$server/offers.php";
//=========================Marketing==============================//
  static const String marketingView = "$server/marketing/marketing_view.php";
  //=========================ProductDetails==============================//
  static const String productDetails = "$server/products_detsails.php";
//=========================FeaturedProducts==============================//
  static const String featuredProducts = "$server/featured_product.php";
//=========================TrendingNow==============================//
  static const String trendingNow = "$server/trendingnow/view.php";
//=========================Categories==============================//
  static const String countItemsInCategories = "$server/categories/categories_items_count.php";
//=========================Stripe==============================//
  static const String stripeAttach = "$server/stripe/attach_payment_method.php";
  static const String stripeCustomers = "$server/stripe/stripe_customer.php";
  static const String stripeView = "$server/stripe/View.php";
  static const String stripeDelete= "$server/stripe/delete_paymentMetho.php";
//=========================MissingItem==============================//
  static const String missingItem= "$server/items/missing_items.php";
//=========================Direct Advertising==============================//
  static const String directAdvertising= "$server/direct_advertising.php";


}