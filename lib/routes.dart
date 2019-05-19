import 'package:whatsapp_clone/pages/chatScreen.dart';
import 'package:whatsapp_clone/pages/homeScreen.dart';

enum routeNames { HOME, CHAT, SETTING }

const routeNamePath = <routeNames, String>{
  routeNames.HOME: '/home',
  routeNames.SETTING: '/setting',
  routeNames.CHAT: '/chat',
};

final goToPageByRoute = {
  routeNames.HOME: (context) => new HomeScreen(title: 'WhatsApp'),
  routeNames.CHAT: (context) => new ChatScreen(),
//  routeNames.SEARCH_JOBS: (context) => new SearchJobsPage(title: 'Search Job'),
};
