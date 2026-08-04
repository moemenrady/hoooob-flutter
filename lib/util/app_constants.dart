import 'package:get/get.dart';
import 'package:hoooob_app/features/onboard/domain/models/on_boarding_model.dart';
import 'package:hoooob_app/localization/language_model.dart';
import 'package:hoooob_app/util/images.dart';

class AppConstants {
  // ==========================================
  // General App Info
  // ==========================================
  static const String appName = 'hoooob';
  static const String baseUrl = 'https://hoooob.com';
  static const double appVersion = 2.1;
  static const String mapKey = "AIzaSyCeF4BHLDezqD1pH7mlzxEchtX962QU9Os";
  static const String fontFamily = 'Cairo';
  static const double coverageRadiusInMeter = 50;

  // ==========================================
  // Auth & User Profile
  // ==========================================
  static const String registration = '/api/customer/auth/registration';
  static const String loginUri = '/api/customer/auth/login';
  static const String logOutUri = '/api/user/logout';
  static const String deleteAccount = '/api/user/delete';
  static const String sendOTP = '/api/customer/auth/send-otp';
  static const String otpVerification = '/api/customer/auth/otp-verification';
  static const String otpLogin = '/api/customer/auth/otp-login';
  static const String otpFirebaseVerification =
      '/api/customer/auth/firebase-otp-verification';
  static const String checkRegisteredUserUri = '/api/customer/auth/check';
  static const String resetPassword = '/api/customer/auth/reset-password';
  static const String changePassword = '/api/user/change-password';
  static const String forgetPassword = '/api/customer/auth/forget-password';
  static const String socialLogin = '/api/customer/auth/social-login';
  static const String externalLoginUri = '/api/customer/auth/external-login';
  static const String profileInfo = '/api/customer/info';
  static const String updateProfileInfo = '/api/customer/update/profile';
  static const String getProfileLevel = '/api/customer/level';
  static const String fcmTokenUpdate = '/api/customer/update/fcm-token';
  static const String changeLanguage = '/api/customer/change-language';

  // ==========================================
  // Configuration & Location Services
  // ==========================================
  static const String configUri = '/api/customer/configuration';
  static const String getZone = '/api/customer/config/get-zone-id';
  static const String carpoolStationSearch = '/api/carpool-station/search';
  static const String geoCodeURI = '/api/customer/config/geocode-api';
  static const String searchLocationUri =
      '/api/customer/config/place-api-autocomplete';
  static const String getDistanceFromLatLng =
      '/api/customer/config/distance_api';
  static const String placeApiDetails =
      '/api/customer/config/place-api-details';
  static const String remainDistance = '/api/customer/config/get-routes';
  static const String rideCancellationReasonList =
      '/api/customer/config/cancellation-reason-list';
  static const String parcelCancellationReasonList =
      '/api/customer/config/parcel-cancellation-reason-list';
  static const String getParcelRefundReasonList =
      '/api/customer/config/parcel-refund-reason-list';

  // ==========================================
  // Payments
  // ==========================================
  
  static const String withdrawRequest = '/api/driver/withdraw/request';
  static const String getPaymentMethods = '/api/v1/payment-config';
  static const String credit = '/api/v1/credit';
  // ==========================================
  // Ride & Trip Management
  // ==========================================
  static const String estimatedFare = '/api/customer/ride/get-estimated-fare';
  static const String rideRequest = '/api/customer/ride/create';
  static const String updateLasLocation = '/api/customer/ride/track-location';
  static const String tripDetails = '/api/customer/ride/details/';
  static const String tripAcceptOrReject = '/api/customer/ride/trip-action';
  static const String applyCoupon = '/api/customer/ride/apply-coupon';
  static const String removeCoupon = '/api/customer/ride/cancel-coupon';
  static const String biddingList = '/api/customer/ride/bidding-list/';
  static const String ignoreBidding = '/api/customer/ride/ignore-bidding';
  static const String nearestDriverList = '/api/customer/drivers-near-me';
  static const String currentRideStatus =
      '/api/customer/ride/ride-resume-status';
  static const String updateTripStatus = '/api/customer/ride/update-status/';
  static const String finalFare = '/api/customer/ride/final-fare';
  static const String tripList = '/api/customer/ride/list';
  static const String paymentUri = '/api/customer/ride/payment';
  static const String digitalPayment = '/api/customer/ride/digital-payment';
  static const String arrivalPickupPoint = '/api/customer/ride/arrival-time';
  static const String parcelOngoingList =
      '/api/customer/ride/ongoing-parcel-list?limit=100&offset=1';
  static const String parcelUnpaidList =
      '/api/customer/ride/unpaid-parcel-list?limit=100&offset=1';
  static const String parcelReceived =
      '/api/customer/ride/received-returning-parcel/';

  // ==========================================
  // Car & Vehicle Management
  // ==========================================
  static const String vehicleMainCategory =
      '/api/customer/vehicle/category?limit=100&offset=1';
  static const String carBrandList = '/api/customer/vehicle/brand/list?offset=';
  static const String carMainCategory =
      '/api/customer/vehicle/category/list?offset=';
  static const String addNewCar = '/api/customer/vehicle/store';
  static const String vehicleList = '/api/customer/vehicle/list';
  static const String driverAllTripeList = '/api/customer/vehicle';
  static const String deleteVehicle = '/api/customer/vehicle';

  // ==========================================
  // Address & Banners & Coupons & Offers
  // ==========================================
  static const String addNewAddress = '/api/customer/address/add';
  static const String getAddressList =
      '/api/customer/address/all-address?limit=10&offset=';
  static const String getRecentAddressList = '/api/customer/recent-address';
  static const String updateAddress = '/api/customer/address/update';
  static const String deleteAddress = '/api/customer/address/delete';
  static const String bannerUei =
      '/api/customer/banner/list?limit=100&offset=1';
  static const String bannerCountUpdate =
      '/api/customer/banner/update-redirection-count';
  static const String couponList = '/api/customer/coupon/list?limit=10&offset=';
  static const String customerAppliedCoupon = '/api/customer/applied-coupon';
  static const String bestOfferList =
      '/api/customer/discount/list?limit=10&offset=';

  // ==========================================
  // Chat & Messaging
  // ==========================================
  static const String createChannel = '/api/customer/chat/create-channel';
  static const String channelList = '/api/customer/chat/channel-list';
  static const String conversationList = '/api/customer/chat/conversation';
  static const String sendMessage = '/api/customer/chat/send-message';
  static const String findChannelRideStatus = '/api/customer/chat/find-channel';

  // ==========================================
  // Parcell & Reviews & Finance & Loyalty
  // ==========================================
  static const String parcelCategoryUri =
      '/api/customer/parcel/category?limit=100&offset=1';
  static const String suggestedVehicleCategory =
      '/api/customer/parcel/suggested-vehicle-category?parcel_weight=';
  static const String parcelRefundCreate = '/api/customer/parcel/refund/create';
  static const String submitReview = '/api/customer/review/store';
  static const String alreadySubmittedReview =
      '/api/customer/review/check-submission';
  static const String notificationList =
      '/api/customer/notification-list?limit=10&offset=';
  static const String transactionListUri =
      '/api/customer/transaction/list?limit=10&offset=';
  static const String loyaltyPointListUri =
      '/api/customer/loyalty-points/list?limit=10&offset=';
  static const String pointConvert = '/api/customer/loyalty-points/convert';
  static const String transferMoneyFromDrivemondToMart =
      '/api/customer/wallet/transfer-drivemond-to-mart';
  static const String referralDetails = '/api/customer/referral-details';
  static const String referralEarningList =
      '/api/customer/transaction/referral-earning-list?limit=10&offset=';

  // ==========================================
  // Ride Sharing (Car Pooling/Trips)
  // ==========================================
  static const String userSearchTripe = '/api/passenger/find-match';
  static const String addDriverTripe = '/api/driver/register-route';
  static const String allSearchTripe = '/api/passenger/find-match?category=';
  static const String joinTripe = '/api/passenger/join';
  static const String allVehicles = '/api/driver/vehicle/list';
  static const String driverAllTripe =
      '/api/driver/current-trips-with-passengers';
  static const String passengerAllTripe = '/api/passenger/trips';
  static const String cancelAndAcceptTripe = '/api/driver/review';
  static const String startTrip = '/api/driver/start-trip';
  static const String endTrip = '/api/driver/end-trip';
  static const String currentTripsWithPassengersUri =
      '/api/driver/current-trips-with-passengers';

  // ==========================================
  // Shared Keys & Local Storage
  // ==========================================
  static const String notification = 'notification';
  static const String theme = 'theme';
  static const String token = 'token';
  static const String paymentMethod = 'payment_method';
  static const String paymentType = 'paymentType';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String haveOngoingRides = 'have_ongoing_rides';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String loginCountryCode = 'login_country_code';
  static const String searchAddress = 'search_address';
  static const String localization = 'X-Localization';
  static const String topic = 'notify';
  static const String intro = 'intro';
  static const String zoneId = 'zone_id';
  static const String externalUserPhone = 'external_user_phone';
  static const String externalUserPassword = 'external_user_password';
  static const String externalUserCountryCode = 'external_user_countryCode';

  // ==========================================
  // App Settings & Status
  // ==========================================
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String ongoing = 'ongoing';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const double otpShownArea = 500;
  static const double mapZoom = 20;
  static const int limitOfPickedIdentityImageNumber = 2;
  static const double limitOfPickedImageSizeInMB = 2;

  // ==========================================
  // Data Objects
  // ==========================================
  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: Images.unitedKingdom,
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
        imageUrl: Images.saudi,
        languageName: 'عربي',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  static List<OnBoardingModel> onBoardPagerData = [
    OnBoardingModel(
        title: 'on_boarding_1_title'.tr,
        image: 'assets/image/on_board_one.png'),
    OnBoardingModel(
        title: 'on_boarding_2_title'.tr,
        image: 'assets/image/on_board_two.png'),
    OnBoardingModel(
        title: 'on_boarding_3_title'.tr,
        image: 'assets/image/on_board_three.png'),
    OnBoardingModel(
        title: 'on_boarding_4_title'.tr,
        image: 'assets/image/on_board_four.png'),
  ];
}
