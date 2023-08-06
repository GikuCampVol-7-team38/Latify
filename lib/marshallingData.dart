class Action{

}

class AudioAttributes{

}

class RemoteViews{

}

class PendingIntent{

}

class Bundle{

}

class Bitmap{

}

class CharSequence{
  String? value;
}

class Icon{

}

class LocusId{

}

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
  //List<Notification.Action>? contextualActions;

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
}

class UserHandle{
  // Describe the kinds of special objects contained in this Parcelable instance's marshaled representation.
  int? describeContents;

  // Returns a hash code value for the object.
  int? userHandleHashCode;

  // Returns a string representation of the object.
  String? userHandleToString;
}

class StatusBarNotification{
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
}
