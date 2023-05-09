import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobilefirst_flutter/api/api.dart';
import 'package:mobilefirst_flutter/models/response/users_response.dart';
import 'package:mobilefirst_flutter/modules/home/home.dart';
import 'package:mobilefirst_flutter/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/news_api_model.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});
  var prefs = Get.find<SharedPreferences>();
  var currentTab = MainTabs.home.obs;
  var newsList = Rxn<NewsApiModel>();
  var news = Rxn<Articles>();
  String userName = "";
  String email = "";

  late MainTab mainTab;
  late DiscoverTab discoverTab;
  late ResourceTab resourceTab;
  late InboxTab inboxTab;
  late MeTab meTab;

  @override
  void onInit() async {
    super.onInit();
    userName = prefs.getString("name")!;
    email = prefs.getString("email")!;
    mainTab = MainTab();
    loadUsers();

    discoverTab = DiscoverTab();
    resourceTab = ResourceTab();
    inboxTab = InboxTab();
    meTab = MeTab();
  }


  Future<void> loadUsers() async {
    var _users = await apiRepository.getUsers();
    if (_users!.articles!.length > 0) {
      newsList.value = _users;
      newsList.refresh();
      _saveNewsInfo(_users);
    }
  }

  void signout() {

    prefs.clear();

    // Get.back();
    NavigatorHelper.popLastScreens(popCount: 2);
  }

  void _saveNewsInfo(NewsApiModel newslist) {
    var random = new Random();
    var index = random.nextInt(newslist.articles!.length);
    news.value = newslist.articles![index];
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.userInfo, newslist.articles![index].toRawJson());

    // var userInfo = prefs.getString(StorageConstants.userInfo);
    // var userInfoObj = Datum.fromRawJson(xx!);
    // print(userInfoObj);
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.discover:
        return 1;
      case MainTabs.resource:
        return 2;
      case MainTabs.inbox:
        return 3;
      case MainTabs.me:
        return 4;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.discover;
      case 2:
        return MainTabs.resource;
      case 3:
        return MainTabs.inbox;
      case 4:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }
}
