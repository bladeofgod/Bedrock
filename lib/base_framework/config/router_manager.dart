


import 'package:flutter/cupertino.dart';
import 'package:tripalink/base_framework/ui/anim/page_route_anim/no_animation.dart';
import 'package:tripalink/base_framework/ui/widget/detail_image_widget.dart';
import 'package:tripalink/base_framework/ui/widget/image/image_editor.dart';
import 'package:tripalink/page/bill/bill_page.dart';
import 'package:tripalink/page/collect/collect_page.dart';
import 'package:tripalink/page/community/detial/event_detail_page.dart';
import 'package:tripalink/page/community/detial/news_detail_page.dart';
import 'package:tripalink/page/community/newsletter/news_letter_page.dart';
import 'package:tripalink/page/community/partner/partner_view_page.dart';
import 'package:tripalink/page/detail/amenities_list_page.dart';
import 'package:tripalink/page/detail/property_detail_page.dart';
import 'package:tripalink/page/detail/studio_list_page.dart';
import 'package:tripalink/page/detail/unit_detail/unit_amenities_list_page.dart';
import 'package:tripalink/page/detail/unit_detail/unity_detail_page.dart';
import 'package:tripalink/page/detail/unit_list_page.dart';
import 'package:tripalink/page/form/property_form_page.dart';
import 'package:tripalink/page/guide/guide_page.dart';
import 'package:tripalink/page/home/activities/form_activities_page.dart';
import 'package:tripalink/page/login/login_page.dart';
import 'package:tripalink/page/login/select_country.dart';

import 'package:tripalink/page/main_page.dart';
import 'package:tripalink/page/map/amap_driver_demo/dirver_page.dart';
import 'package:tripalink/page/map/amap_net_demo/amap_net_page.dart';
import 'package:tripalink/page/map/shuttle_in_google/client_shuttle_page.dart';
import 'package:tripalink/page/mine/collection/mine_collection_page.dart';
import 'package:tripalink/page/mine/help_center/about_us_page.dart';
import 'package:tripalink/page/mine/help_center/faq_page.dart';
import 'package:tripalink/page/mine/help_center/join_us_page.dart';
import 'package:tripalink/page/mine/help_center/suggestion_page.dart';
import 'package:tripalink/page/mine/mine_bill/mine_bill_view_page.dart';
import 'package:tripalink/page/mine/mine_home/mine_home_page.dart';
import 'package:tripalink/page/mine/personal_center/bound_phone_email_page.dart';
import 'package:tripalink/page/mine/personal_center/offical_name_view_page.dart';
import 'package:tripalink/page/mine/personal_center/personal_center_page.dart';
import 'package:tripalink/page/mine/personal_center/third_party_login_page.dart';
import 'package:tripalink/page/mine/setting/Choose_language_view_page.dart';
import 'package:tripalink/page/mine/setting/choose_default_city_page.dart';
import 'package:tripalink/page/mine/setting/setting_page.dart';
import 'package:tripalink/page/policy/privacy_policy.dart';
import 'package:tripalink/page/splash_page.dart';
import 'package:tripalink/page/splash_screen_page.dart';
import 'package:tripalink/page/web/html_page.dart';
import 'package:tripalink/page/web/web_for_3d_page.dart';
import 'package:tripalink/page/community/detial/link_two_page.dart';

class RouteName{
  static const String splash_page = "splash_page";
  static const String splash_screen_page = "splash_screen_page";
  static const String guide_page = "guide_page";
  static const String main_page = "main_page";
  static const String property_detail_page = "property_page";
  static const String unit_list_page = "unit_list_page";
  static const String studio_list_page = "studio_list_page";
  static const String amenities_list_page = "amenities_list_page";
  static const String unit_amenities_list_page = "unit_amenities_list_page";
  static const String privacy_policy_page = "privacy_policy_page";
  static const String unit_detail_page = "unit_detail_page";
  static const String bill_page = "bill_page";
  static const String news_detail_page = "news_detail_page";
  static const String event_detail_page = "event_detail_page";
  static const String show_big_image = "show_big_image";
  static const String news_letter_list = "news_letter_list";
  static const String web_for_3d = "web_for_3d";
  static const String property_form_page = "property_form_page";
  static const String form_activities_page = "form_activities_page";
  static const String login_page = "login_page";
  static const String select_country_page = "select_country_page";
  static const String link_two_page = "link_two_page";
  static const String collect_page = "collect_page";
  static const String partner_view_page = "partner_view_page";
  static const String shuttle_page = "shuttle_page";
  ///mine other route
  static const String about_us_page = "about_us_page";
  static const String faq_page = "faq_page";
  static const String setting_page = "setting_page";
  static const String join_us_page = "join_us_page";
  static const String choose_default_city_page = "choose_default_city_page";
  static const String choose_languge_page = "choose_languge_page";
  static const String suggestion_page = "suggestion_page";
  static const String mine_collection_page = "mine_collection_page";
  static const String mine_home_page = "mine_home_page";//
  static const String personal_center = "personal_center";
  static const String third_party_login_page = "third_party_login_page";
  static const String offical_name_view_page = "offical_name_view_page";
  static const String bound_phone_email_page = "bound_phone_email_page";
  static const String mine_bill_view_page = "mine_bill_view_page";


  ///util
  static const String image_editor = "image_editor";
  static const String html_page = "html_page";

  ///test route
  static const String map_page = "map_page";
  static const String driver_page = "driver_page";


}


class Router{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splash_page:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.splash_screen_page:
        return NoAnimRouteBuilder(SplashScreenPage());
      case RouteName.guide_page:
        return NoAnimRouteBuilder(GuidePage());
      case RouteName.main_page:
        return NoAnimRouteBuilder(MainPage());
      case RouteName.property_detail_page:
        return NoAnimRouteBuilder(PropertyDetailPage(settings.arguments));
      case RouteName.link_two_page:
        return NoAnimRouteBuilder(LinkTwoPage(settings.arguments));
      case RouteName.unit_list_page:
        return NoAnimRouteBuilder(UnitListPage(settings.arguments));
      case RouteName.studio_list_page:
        return NoAnimRouteBuilder(StudioListPage(settings.arguments));
      case RouteName.amenities_list_page:
        return NoAnimRouteBuilder(AmenitiesListPage(settings.arguments));
      case RouteName.privacy_policy_page:
        return NoAnimRouteBuilder(PrivacyPolicyPage());
      case RouteName.unit_detail_page:
        return NoAnimRouteBuilder(UnitDetailPage(settings.arguments));
      case RouteName.unit_amenities_list_page:
        return NoAnimRouteBuilder(UnitAmenitiesListPage(settings.arguments));
      case RouteName.bill_page:
        return NoAnimRouteBuilder(BillPage(settings.arguments));
      case RouteName.news_detail_page:
        return NoAnimRouteBuilder(NewsDetailPage(settings.arguments));
      case RouteName.event_detail_page:
        return NoAnimRouteBuilder(EventDetailPage(settings.arguments));
      case RouteName.news_letter_list:
        return NoAnimRouteBuilder(NewsLetterPage());
      case RouteName.web_for_3d:
        return NoAnimRouteBuilder(WebFor3dPage(settings.arguments));
      case RouteName.property_form_page:
        return NoAnimRouteBuilder(PropertyFormPage(settings.arguments));
      case RouteName.form_activities_page:
        return NoAnimRouteBuilder(FromActivitiesPage(settings.arguments));
      case RouteName.login_page:
        return NoAnimRouteBuilder(LoginPage());
      case RouteName.select_country_page:
        return NoAnimRouteBuilder(SelectCountryPage());
      // mine other page
      case RouteName.about_us_page:
        return NoAnimRouteBuilder(AboutUsPage());
      case RouteName.setting_page:
        return NoAnimRouteBuilder(SettingPage());
      case RouteName.choose_default_city_page:
        return NoAnimRouteBuilder(ChooseDefaultCityPage());
      case RouteName.choose_languge_page:
        return NoAnimRouteBuilder(ChooseLangugePage());

      case RouteName.faq_page:
        return NoAnimRouteBuilder(FaqPage());
      case RouteName.suggestion_page:
        return NoAnimRouteBuilder(SuggestionPage());
      case RouteName.join_us_page:
        return NoAnimRouteBuilder(JoinUsPage());
      case RouteName.collect_page:
        return NoAnimRouteBuilder(CollectPage());
      case RouteName.partner_view_page:
        return NoAnimRouteBuilder(PartnerViewPage());
      case RouteName.mine_collection_page:
        return NoAnimRouteBuilder(MineCollectionPage());
      case RouteName.shuttle_page:
        return NoAnimRouteBuilder(ClientShuttlePage());
      case RouteName.mine_home_page:
        return NoAnimRouteBuilder(MineHomePage());
      case RouteName.personal_center:
        return NoAnimRouteBuilder(PersonalCenterPage());
      case RouteName.third_party_login_page:
        return NoAnimRouteBuilder(ThirdPartyLoginPage());
      case RouteName.offical_name_view_page:
        return NoAnimRouteBuilder(OfficalNameViewPage());
      case RouteName.bound_phone_email_page:
        return NoAnimRouteBuilder(BoundPhoneOrEmailPage(settings.arguments));
      case RouteName.mine_bill_view_page:
        return NoAnimRouteBuilder(MineBillViewPage());

      case RouteName.html_page:
        return NoAnimRouteBuilder(HtmlPage(settings.arguments));
      case RouteName.image_editor:
        return NoAnimRouteBuilder(ImageEditor(settings.arguments));
      case RouteName.show_big_image:
        return NoAnimRouteBuilder(DetailImageWidget(settings.arguments));
//      case RouteName.map_page:
//        return NoAnimRouteBuilder(AmapNetPage());
      case RouteName.driver_page:
        return NoAnimRouteBuilder(DriverPage());
      default:
        //TODO 设置一个默认页
        return null;

    }
  }

}