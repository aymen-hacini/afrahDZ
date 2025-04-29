class ApiLinkNames {
  static String server = "https://afrahdz.com/api";
  static String serverimage = "https://afrahdz.com/";
  // static String server = "http://localhost:8000";
  static String signupclient = "$server/client";
  static String signupmember = "$server/membre";
  static String loginclient = "$server/client/login";
  static String loginmember = "$server/membre/login";

  static String sendOTPClient = "$server/client/OTP";
  static String sendOTPMembre = "$server/membre/OTP";

  static String resetPasswordClient = "$server/client/forget";
  static String resetPasswordMember = "$server/membre/forget";

  static String getClientInfo = "$server/client";
  static String getMemberInfo = "$server/membre";


  static String editClient = "$server/client";
  static String editMember = "$server/membre";

  static String getAllCategories = "$server/annonce/categorie";

  static String createAD = "$server/annonce";
  static String editAd = "$server/annonce";
  static String getAllads = "$server/annonce";
  static String getVipads = "$server/annonce/vip";
  static String getMemberAds = "$server/annoncebymembre";
  static String getGoldads = "$server/annonce/gold";
  static String getadsBycityFilter = "$server/annonce?city";
  static String getMyAds = "$server/myannonce";
  static String deleteAd = "$server/annonce";

  static String getAdDetailswithVisite = "$server/annonce/visite";
  static String getAdDetails = "$server/annonce";
  static String myFavAds = "$server/annoncefav";
  static String likeAd = "$server/annonce/like";

  static String boostAd = "$server/boost";
  static String createFavoritead = "$server/favoris";
  static String deleteFavoritead = "$server/favoris";

  static String contact = "$server/contact";

  static String createReservation = "$server/resarvation";
  static String getmyreservations = "$server/myresarvation";
  static String deleteReservation = "$server/resarvation";
  static String updateReservation = "$server/resarvation";


  static String getMyplanning = "$server/resarvationPlan";

}
