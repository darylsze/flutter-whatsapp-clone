import 'package:whatsapp_clone/pages/chatScreen.dart';
import 'package:whatsapp_clone/pages/homeScreen.dart';
import 'package:whatsapp_clone/pages/settingScreen.dart';
import 'package:whatsapp_clone/pages/takeImageScreen.dart';

enum routeNames { HOME, CHAT, SETTING, TAKE_IMAGE }

const routeNamePath = <routeNames, String>{
  routeNames.HOME: '/home',
  routeNames.SETTING: '/setting',
  routeNames.CHAT: '/chat',
  routeNames.TAKE_IMAGE: '/chat',
};

final goToPageByRoute = {
  routeNames.HOME: (context) => new HomeScreen(title: 'WhatsApp'),
  routeNames.CHAT: (context) => new ChatScreen(),
  routeNames.SETTING: (context) => new SettingScreen(),
  routeNames.TAKE_IMAGE: (context) => new TakeImageScreen(),
//  routeNames.SEARCH_JOBS: (context) => new SearchJobsPage(title: 'Search Job'),
};
