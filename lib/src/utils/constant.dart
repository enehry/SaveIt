import 'package:save_it/src/models/notification_interval.dart';

const kThemeModeBox = 'save_it_box';
const kAuthBox = 'auth_box';
const kThemeModeData = 'theme';
const kNotificationBox = 'save_it_notification_box';
const kNotificationData = 'notification';
const kChallengeBox = 'save_it_challenge_box';

const kBorderRadius = 30.0;
const kPaddingNormal = 25.0;

const List<Map> kAllocationModes = [
  {
    'name': 'Mode 0',
    'needs': '0',
    'wants': '0',
    'savings': '0',
    'others': '0',
  },
  {
    'name': 'Mode 1',
    'needs': '25',
    'wants': '25',
    'savings': '25',
    'others': '25',
  },
  {
    'name': 'Mode 2',
    'needs': '40',
    'wants': '20',
    'savings': '20',
    'others': '20',
  },
  {
    'name': 'Mode 3',
    'needs': '50',
    'wants': '25',
    'savings': '20',
    'others': '5',
  }
];

const List<NotificationInterval> kNotificationIntervals = [
  NotificationInterval(
    title: 'Off',
    interval: 0,
  ),
  NotificationInterval(
    title: '1m',
    interval: 60,
  ),
  NotificationInterval(
    title: '3h',
    interval: 10800,
  ),
  NotificationInterval(
    title: '6h',
    interval: 21600,
  ),
  NotificationInterval(
    title: '12h',
    interval: 43200,
  ),
  NotificationInterval(
    title: 'Daily',
    interval: 86400,
  ),
  NotificationInterval(
    title: 'Weekly',
    interval: 604800,
  ),
];
