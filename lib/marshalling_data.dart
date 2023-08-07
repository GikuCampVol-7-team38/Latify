class Action {
  Map<String, Object?>? toMap() {
    return null;
  }

  static Action? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return Action();
  }

  static Action? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return Action();
  }
}

class AudioAttributes {
  Map<String, Object?>? toMap() {
    return null;
  }

  static AudioAttributes? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return AudioAttributes();
  }

  static AudioAttributes? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return AudioAttributes();
  }
}

class RemoteViews {
  Map<String, Object?>? toMap() {
    return null;
  }

  static RemoteViews? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return RemoteViews();
  }

  static RemoteViews? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return RemoteViews();
  }
}

class PendingIntent {
  Map<String, Object?>? toMap() {
    return null;
  }

  static PendingIntent? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return PendingIntent();
  }

  static PendingIntent? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return PendingIntent();
  }
}

class Bundle {
  Map<String, Object?>? toMap() {
    return null;
  }

  static Bundle? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return Bundle();
  }

  static Bundle? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return Bundle();
  }
}

class Bitmap {
  Map<String, Object?>? toMap() {
    return null;
  }

  static Bitmap? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return Bitmap();
  }

  static Bitmap? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return Bitmap();
  }
}

class CharSequence {
  String? value;

  CharSequence(this.value);

  Map<String, Object?>? toMap() {
    return {
      'value': value,
    };
  }

  static CharSequence? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic> || map['value'] is! String) {
      return null;
    }
    return CharSequence(map['value']);
  }

  static CharSequence? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return map['value'] is String ? CharSequence(map['value'] as String) : null;
  }
}

class Icon {
  Map<String, Object?>? toMap() {
    return null;
  }

  static Icon? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return Icon();
  }

  static Icon? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return Icon();
  }
}

class LocusId {
  Map<String, Object?>? toMap() {
    return null;
  }

  static LocusId? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return LocusId();
  }

  static LocusId? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return LocusId();
  }
}

// TODO:
// class Uri?

class Notification {
  // Array of all Action structures attached to this notification by Builder#addAction(int, CharSequence, PendingIntent).
  List<Action>? actions;

  // This field was deprecated in API level 26. use NotificationChannel#getAudioAttributes() instead.
  AudioAttributes? audioAttributes;

  // This field was deprecated in API level 21. Use audioAttributes instead.
  int? audioStreamType;

  // A large-format version of contentView, giving the Notification an opportunity to show more detail.
  RemoteViews? bigContentView;

  // One of the predefined notification categories (see the CATEGORY_* constants) that best describes this Notification.
  String? category;

  // Accent color (an ARGB integer like the constants in Color) to be applied by the standard Style templates when presenting this notification.
  int? color;

  // The intent to execute when the expanded status entry is clicked.
  PendingIntent? contentIntent;

  // The view that will represent this notification in the notification list (which is pulled down from the status bar).
  RemoteViews? contentView;

  // This field was deprecated in API level 26. use NotificationChannel#getSound() and NotificationChannel#shouldShowLights() and NotificationChannel#shouldVibrate().
  int? defaults;

  // The intent to execute when the notification is explicitly dismissed by the user, either with the "Clear All" button or by swiping it away individually.
  PendingIntent? deleteIntent;

  // Additional semantic data to be carried around with this Notification.
  Bundle? extras;

  int? flags;

  // An intent to launch instead of posting the notification to the status bar.
  PendingIntent? fullScreenIntent;

  // A medium-format version of contentView, providing the Notification an opportunity to add action buttons to contentView.
  RemoteViews? headsUpContentView;

  // This field was deprecated in API level 23. Use Builder#setSmallIcon(Icon) instead.
  int? icon;

  // If the icon in the status bar is to have more than one level, you can set this.
  int? iconLevel;

  // This field was deprecated in API level 23. Use Builder#setLargeIcon(Icon) instead.
  Bitmap? largeIcon;

  // This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
  int? ledARGB;

  // This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
  int? ledOffMS;

  // This field was deprecated in API level 26. use NotificationChannel#shouldShowLights().
  int? ledOnMS;

  // The number of events that this notification represents.
  int? number;

  // This field was deprecated in API level 26. use NotificationChannel#getImportance() instead.
  int? priority;

  // Replacement version of this notification whose content will be shown in an insecure context such as atop a secure keyguard.
  Notification? publicVersion;

  // This field was deprecated in API level 26. use NotificationChannel#getSound().
  Uri? sound;

  // Text that summarizes this notification for accessibility services.
  CharSequence? tickerText;

  // Formerly, a view showing the tickerText.
  RemoteViews? tickerView;

  // This field was deprecated in API level 26. use NotificationChannel#getVibrationPattern().
  List<int>? vibrate;

  // Sphere of visibility of this notification, which affects how and when the SystemUI reveals the notification's presence and contents in untrusted situations (namely, on the secure lockscreen).
  int? visibility;

  // A timestamp related to this notification, in milliseconds since the epoch.
  int? when;

  // Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
  int? describeContents;

  // Finds and returns a remote input and its corresponding action.


  // Returns whether the platform is allowed (by the app developer) to generate contextual actions for this notification.
  bool? getAllowSystemGeneratedContextualActions;

  // Returns what icon should be shown for this notification if it is being displayed in a Launcher that supports badging.
  int? getBadgeIconType;

  // Returns the bubble metadata that will be used to display app content in a floating window over the existing foreground activity.
  //Notification.BubbleMetadata? bubbleMetadata;

  // Returns the id of the channel this notification posts to.
  String? getChannelId;

  // Returns the actions that are contextual (that is, suggested because of the content of the notification) out of the actions in this notification.
  // List<Notification.Action>? contextualActions;

  // Get the key used to group this notification into a cluster or stack with other notifications on devices which support such rendering.
  String? getGroup;

  // Returns which type of notifications in a group are responsible for audibly alerting the user.
  int? getGroupAlertBehavior;

  // The large icon shown in this notification's content view.
  Icon? getLargeIcon;

  // Gets the LocusId associated with this notification.
  LocusId? getLocusId;

  // Returns the settings text provided to Builder#setSettingsText(CharSequence).
  CharSequence? getSettingsText;

  // Returns the id that this notification supersedes, if any.
  int? getShortcutId;

  // Get a sort key that orders this notification among other notifications from the same package.
  String? getSortKey;

  // Returns the duration from posting after which this notification should be canceled by the system, if it's not canceled already.
  int? getTimeoutAfter;

  bool? hasImage;

  // Returns a string representation of the object.
  String? notificationToString;

  Map<String, Object?> toMap() {
    return {
      'actions': actions?.map((action) => action.toMap()).toList(),
      'audioAttributes': audioAttributes?.toMap(),
      'audioStreamType': audioStreamType,
      'bigContentView': bigContentView?.toMap(),
      'category': category,
      'color': color,
      'contentIntent': contentIntent?.toMap(),
      'contentView': contentView?.toMap(),
      'defaults': defaults,
      'deleteIntent': deleteIntent?.toMap(),
      'extras': extras?.toMap(),
      'flags': flags,
      'fullScreenIntent': fullScreenIntent?.toMap(),
      'headsUpContentView': headsUpContentView?.toMap(),
      'icon': icon,
      'iconLevel': iconLevel,
      'largeIcon': largeIcon?.toMap(),
      'ledARGB': ledARGB,
      'ledOffMS': ledOffMS,
      'ledOnMS': ledOnMS,
      'number': number,
      'priority': priority,
      'publicVersion': publicVersion?.toMap(),
      'sound': sound?.toString(),
      'tickerText': tickerText?.toMap(),
      'tickerView': tickerView?.toMap(),
      'vibrate': vibrate,
      'visibility': visibility,
      'when': when,
      'describeContents': describeContents,
      'getAllowSystemGeneratedContextualActions': getAllowSystemGeneratedContextualActions,
      'getBadgeIconType': getBadgeIconType,
      // 'bubbleMetadata': bubbleMetadata?.toMap(),
      'getChannelId': getChannelId,
      // 'contextualActions': contextualActions?.map((action) => action.toMap())?.toList(),
      'getGroup': getGroup,
      'getGroupAlertBehavior': getGroupAlertBehavior,
      'getLargeIcon': getLargeIcon?.toMap(),
      'getLocusId': getLocusId?.toMap(),
      'getSettingsText': getSettingsText?.toMap(),
      'getShortcutId': getShortcutId,
      'getSortKey': getSortKey,
      'getTimeoutAfter': getTimeoutAfter,
      'hasImage': hasImage,
      'notificationToString': notificationToString,
    };
  }

  static Notification? fromDynamic(dynamic map){
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return Notification()
      ..actions = map['actions'] != null
          ? List<Action>.from((map['actions'] as List).map((e) => Action.fromDynamic(e)))
          : null
      ..audioAttributes = AudioAttributes.fromDynamic(map['audioAttributes'])
      ..audioStreamType = map['audioStreamType']
      ..bigContentView = RemoteViews.fromDynamic(map['bigContentView'])
      ..category = map['category']
      ..color = map['color']
      ..contentIntent = PendingIntent.fromDynamic(map['contentIntent'])
      ..contentView = RemoteViews.fromDynamic(map['contentView'])
      ..defaults = map['defaults']
      ..deleteIntent = PendingIntent.fromDynamic(map['deleteIntent'])
      ..extras = Bundle.fromDynamic(map['extras'])
      ..flags = map['flags']
      ..fullScreenIntent = PendingIntent.fromDynamic(map['fullScreenIntent'])
      ..headsUpContentView = RemoteViews.fromDynamic(map['headsUpContentView'])
      ..icon = map['icon']
      ..iconLevel = map['iconLevel']
      ..largeIcon = Bitmap.fromDynamic(map['largeIcon'])
      ..ledARGB = map['ledARGB']
      ..ledOffMS = map['ledOffMS']
      ..ledOnMS = map['ledOnMS']
      ..number = map['number']
      ..priority = map['priority']
      ..publicVersion = Notification.fromDynamic(map['publicVersion'])
      ..sound = map['sound']
      ..tickerText = CharSequence.fromDynamic(map['tickerText'])
      ..tickerView = RemoteViews.fromDynamic(map['tickerView'])
      ..vibrate = map['vibrate'] != null ? List<int>.from(map['vibrate'] as List) : null
      ..visibility = map['visibility']
      ..when = map['when']
      ..describeContents = map['describeContents']
      ..getAllowSystemGeneratedContextualActions = map['getAllowSystemGeneratedContextualActions']
      ..getBadgeIconType = map['getBadgeIconType']
      // ..bubbleMetadata = Notification.BubbleMetadata.fromDynamic(map['bubbleMetadata'])
      ..getChannelId = map['getChannelId']
      // ..contextualActions = map['contextualActions'] != null
      //     ? List<Notification.Action>.from((map['contextualActions'] as List).map((e) => Notification.Action.fromDynamic(e)))
      //     : null
      ..getGroup = map['getGroup']
      ..getGroupAlertBehavior = map['getGroupAlertBehavior']
      ..getLargeIcon = Icon.fromDynamic(map['getLargeIcon'])
      ..getLocusId = LocusId.fromDynamic(map['getLocusId'])
      ..getSettingsText = CharSequence.fromDynamic(map['getSettingsText'])
      ..getShortcutId = map['getShortcutId']
      ..getSortKey = map['getSortKey']
      ..getTimeoutAfter = map['getTimeoutAfter']
      ..hasImage = map['hasImage']
      ..notificationToString = map['notificationToString'];
  }

  static Notification? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return Notification()
      ..actions = map['actions'] is List
          ? List<Action>.from((map['actions'] as List).map((e) => Action.fromMap(e is Map<Object?, Object?> ? e : null)))
          : null
      ..audioAttributes = AudioAttributes.fromMap(map['audioAttributes'] is Map<Object?, Object?> ? map['audioAttributes'] as Map<Object?, Object?> : null)
      ..audioStreamType = map['audioStreamType'] is int ? map['audioStreamType'] as int : null
      ..bigContentView = RemoteViews.fromMap(map['bigContentView'] is Map<Object?, Object?> ? map['bigContentView'] as Map<Object?, Object?> : null)
      ..category = map['category'] is String ? map['category'] as String : null
      ..color = map['color'] is int ? map['color'] as int : null
      ..contentIntent = PendingIntent.fromMap(map['contentIntent'] is Map<Object?, Object?> ? map['contentIntent'] as Map<Object?, Object?> : null)
      ..contentView = RemoteViews.fromMap(map['contentView'] is Map<Object?, Object?> ? map['contentView'] as Map<Object?, Object?> : null)
      ..defaults = map['defaults'] is int ? map['defaults'] as int : null
      ..deleteIntent = PendingIntent.fromMap(map['deleteIntent'] is Map<Object?, Object?> ? map['deleteIntent'] as Map<Object?, Object?> : null)
      ..extras = Bundle.fromMap(map['extras'] is Map<Object?, Object?> ? map['extras'] as Map<Object?, Object?> : null)
      ..flags = map['flags'] is int ? map['flags'] as int : null
      ..fullScreenIntent = PendingIntent.fromMap(map['fullScreenIntent'] is Map<Object?, Object?> ? map['fullScreenIntent'] as Map<Object?, Object?> : null)
      ..headsUpContentView = RemoteViews.fromMap(map['headsUpContentView'] is Map<Object?, Object?> ? map['headsUpContentView'] as Map<Object?, Object?> : null)
      ..icon = map['icon'] is int ? map['icon'] as int : null
      ..iconLevel = map['iconLevel'] is int ? map['iconLevel'] as int : null
      ..largeIcon = Bitmap.fromMap(map['largeIcon'] is Map<Object?, Object?> ? map['largeIcon'] as Map<Object?, Object?> : null)
      ..ledARGB = map['ledARGB'] is int ? map['ledARGB'] as int : null
      ..ledOffMS = map['ledOffMS'] is int ? map['ledOffMS'] as int : null
      ..ledOnMS = map['ledOnMS'] is int ? map['ledOnMS'] as int : null
      ..number = map['number'] is int ? map['number'] as int : null
      ..priority = map['priority'] is int ? map['priority'] as int : null
      ..publicVersion = Notification.fromMap(map['publicVersion'] is Map<Object?, Object?> ? map['publicVersion'] as Map<Object?, Object?> : null)
      ..sound = map['sound'] is Uri ? map['sound'] as Uri : null
      ..tickerText = CharSequence.fromMap(map['tickerText'] is Map<Object?, Object?> ? map['tickerText'] as Map<Object?, Object?> : null)
      ..tickerView = RemoteViews.fromMap(map['tickerView'] is Map<Object?, Object?> ? map['tickerView'] as Map<Object?, Object?> : null)
      ..vibrate = map['vibrate'] is List ? List<int>.from(map['vibrate'] as List) : null
      ..visibility = map['visibility'] is int ? map['visibility'] as int : null
      ..when = map['when'] is int ? map['when'] as int : null
      ..describeContents = map['describeContents'] is int ? map['describeContents'] as int : null
      ..getAllowSystemGeneratedContextualActions = map['getAllowSystemGeneratedContextualActions'] is bool ? map['getAllowSystemGeneratedContextualActions'] as bool : null
      ..getBadgeIconType = map['getBadgeIconType'] is int ? map['getBadgeIconType'] as int : null
      // ..bubbleMetadata = Notification.BubbleMetadata.fromMap(map['bubbleMetadata'] is Map<Object?, Object?> ? map['bubbleMetadata'] as Map<Object?, Object?> : null)
      ..getChannelId = map['getChannelId'] is String ? map['getChannelId'] as String : null
      // ..contextualActions = map['contextualActions'] is List
      //     ? List<Notification.Action>.from((map['contextualActions'] as List).map((e) => Notification.Action.fromMap(e is Map<Object?, Object?> ? e : null)))
      //     : null
      ..getGroup = map['getGroup'] is String ? map['getGroup'] as String : null
      ..getGroupAlertBehavior = map['getGroupAlertBehavior'] is int ? map['getGroupAlertBehavior'] as int : null
      ..getLargeIcon = Icon.fromMap(map['getLargeIcon'] is Map<Object?, Object?> ? map['getLargeIcon'] as Map<Object?, Object?> : null)
      ..getLocusId = LocusId.fromMap(map['getLocusId'] is Map<Object?, Object?> ? map['getLocusId'] as Map<Object?, Object?> : null)
      ..getSettingsText = CharSequence.fromMap(map['getSettingsText'] is Map<Object?, Object?> ? map['getSettingsText'] as Map<Object?, Object?> : null)
      ..getShortcutId = map['getShortcutId'] is int ? map['getShortcutId'] as int : null
      ..getSortKey = map['getSortKey'] is String ? map['getSortKey'] as String : null
      ..getTimeoutAfter = map['getTimeoutAfter'] is int ? map['getTimeoutAfter'] as int : null
      ..hasImage = map['hasImage'] is bool ? map['hasImage'] as bool : null
      ..notificationToString = map['notificationToString'] is String ? map['notificationToString'] as String : null;
  }
}

class UserHandle  {
  // Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
  int? describeContents;

  // Returns a hash code value for the object.
  int? userHandleHashCode;

  // Returns a string representation of the object.
  String? userHandleToString;

  Map<String, Object?> toMap() {
    return {
      'describeContents': describeContents,
      'userHandleHashCode': userHandleHashCode,
      'userHandleToString': userHandleToString,
    };
  }

  static UserHandle? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return UserHandle()
      ..describeContents = map['describeContents']
      ..userHandleHashCode = map['userHandleHashCode']
      ..userHandleToString = map['userHandleToString'];
  }

  static UserHandle? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return UserHandle()
      ..describeContents = map['describeContents'] is int ? map['describeContents'] as int : null
      ..userHandleHashCode = map['userHandleHashCode'] is int ? map['userHandleHashCode'] as int : null
      ..userHandleToString = map['userHandleToString'] is String ? map['userHandleToString'] as String : null;
  }
}

class StatusBarNotification {
  // Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
  int? describeContents;

  // A key that indicates the group with which this message ranks.
  String? getGroupKey;

  // The id supplied to NotificationManager.notify(int, Notification).
  int? getId;

  // A unique instance key for this notification record.
  String? getKey;

  // The Notification supplied to NotificationManager.notify(int, Notification).
  Notification? getNotification;

  // The package that posted the notification.
  String? getOpPkg;

  // The package that posted the notification.
  String? getOverrideGroupKey;

  // The package that the notification belongs to.
  String? getPackageName;

  // The time (in System#currentTimeMillis time) the notification was posted, which may be different than Notification.when.
  int? getPostTime;

  // The tag supplied to NotificationManager.notify(int, Notification), or null if no tag was specified.
  String? getTag;

  // The notifying app's (getPackageName()'s) uid.
  int? getUid;

  // The UserHandle for whom this notification is intended.
  UserHandle? getUser;

  // This method was deprecated in API level 21. Use getUser() instead.
  int? getUserId;

  // Returns true if application asked that this notification be part of a group.
  bool? isAppGroup;

  // Returns true if application asked that this notification be part of a group.
  bool? isClearable;

  // Returns true if this notification is part of a group.
  bool? isGroup;

  // Convenience method to check the notification's flags for Notification#FLAG_ONGOING_EVENT.
  bool? isOngoing;

  // Returns a string representation of the object.
  String? statusBarNotificationToString;

  Map<String, Object?> toMap() {
    return {
      'describeContents': describeContents,
      'getGroupKey': getGroupKey,
      'getId': getId,
      'getKey': getKey,
      'getNotification': getNotification?.toMap(),
      'getOpPkg': getOpPkg,
      'getOverrideGroupKey': getOverrideGroupKey,
      'getPackageName': getPackageName,
      'getPostTime': getPostTime,
      'getTag': getTag,
      'getUid': getUid,
      'getUser': getUser?.toMap(),
      'getUserId': getUserId,
      'isAppGroup': isAppGroup,
      'isClearable': isClearable,
      'isGroup': isGroup,
      'isOngoing': isOngoing,
      'statusBarNotificationToString': statusBarNotificationToString,
    };
  }

  static StatusBarNotification? fromDynamic(dynamic map) {
    if (map is! Map<dynamic, dynamic>) {
      return null;
    }
    return StatusBarNotification()
      ..describeContents = map['describeContents']
      ..getGroupKey = map['getGroupKey']
      ..getId = map['getId']
      ..getKey = map['getKey']
      ..getNotification = Notification.fromDynamic(map['getNotification'])
      ..getOpPkg = map['getOpPkg']
      ..getOverrideGroupKey = map['getOverrideGroupKey']
      ..getPackageName = map['getPackageName']
      ..getPostTime = map['getPostTime']
      ..getTag = map['getTag']
      ..getUid = map['getUid']
      ..getUser = UserHandle.fromDynamic(map['getUser'])
      ..getUserId = map['getUserId']
      ..isAppGroup = map['isAppGroup']
      ..isClearable = map['isClearable']
      ..isGroup = map['isGroup']
      ..isOngoing = map['isOngoing']
      ..statusBarNotificationToString = map['statusBarNotificationToString'];
  }

  static StatusBarNotification? fromMap(Map<Object?, Object?>? map) {
    if (map == null) {
      return null;
    }
    return StatusBarNotification()
      ..describeContents = map['describeContents'] is int ? map['describeContents'] as int : null
      ..getGroupKey = map['getGroupKey'] is String ? map['getGroupKey'] as String : null
      ..getId = map['getId'] is int ? map['getId'] as int : null
      ..getKey = map['getKey'] is String ? map['getKey'] as String : null
      ..getNotification = Notification.fromMap(map['getNotification'] is Map<Object?, Object?> ? map['getNotification'] as Map<Object?, Object?> : null)
      ..getOpPkg = map['getOpPkg'] is String ? map['getOpPkg'] as String : null
      ..getOverrideGroupKey = map['getOverrideGroupKey'] is String ? map['getOverrideGroupKey'] as String : null
      ..getPackageName = map['getPackageName'] is String ? map['getPackageName'] as String : null
      ..getPostTime = map['getPostTime'] is int ? map['getPostTime'] as int : null
      ..getTag = map['getTag'] is String ? map['getTag'] as String : null
      ..getUid = map['getUid'] is int ? map['getUid'] as int : null
      ..getUser = UserHandle.fromMap(map['getUser'] is Map<Object?, Object?> ? map['getUser'] as Map<Object?, Object?> : null)
      ..getUserId = map['getUserId'] is int ? map['getUserId'] as int : null
      ..isAppGroup = map['isAppGroup'] is bool ? map['isAppGroup'] as bool : null
      ..isClearable = map['isClearable'] is bool ? map['isClearable'] as bool : null
      ..isGroup = map['isGroup'] is bool ? map['isGroup'] as bool : null
      ..isOngoing = map['isOngoing'] is bool ? map['isOngoing'] as bool : null
      ..statusBarNotificationToString = map['statusBarNotificationToString'] is String ? map['statusBarNotificationToString'] as String : null;
  }
}
