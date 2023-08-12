import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotionTemplateSettingWidget extends StatefulWidget {
  const NotionTemplateSettingWidget({super.key});

  @override
  State<NotionTemplateSettingWidget> createState() => _NotionTemplateSettingWidget();
}

class _NotionTemplateSettingWidget extends State<NotionTemplateSettingWidget> {
  static const _notionTemplate = MethodChannel('com.github.GeekCampVol7team38.latify/notionTemplate');

  static Future<String> _getReceivedTemplate() {
    try {
      return _notionTemplate.invokeMethod('getReceived').then((value) {
        if (value is String) {
          return value;
        }
        return '';
      });
    } on PlatformException catch (_) {
      return Future.value('');
    }
  }

  static Future<String> _getLeftButtonTemplate() {
    try {
      return _notionTemplate.invokeMethod('getLeftButton').then((value) {
        if (value is String) {
          return value;
        }
        return '';
      });
    } on PlatformException catch (_) {
      return Future.value('');
    }
  }

  static Future<String> _getMiddleButtonTemplate() {
    try {
      return _notionTemplate.invokeMethod('getMiddleButton').then((value) {
        if (value is String) {
          return value;
        }
        return '';
      });
    } on PlatformException catch (_) {
      return Future.value('');
    }
  }

  static Future<String> _getRightButtonTemplate() {
    try {
      return _notionTemplate.invokeMethod('getRightButton').then((value) {
        if (value is String) {
          return value;
        }
        return '';
      });
    } on PlatformException catch (_) {
      return Future.value('');
    }
  }

  static Future<bool> _setReceivedTemplate(String template) {
    try {
      return _notionTemplate.invokeMethod('setReceived' ,{'template': template}).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static Future<bool> _setLeftButtonTemplate(String template) {
    try {
      return _notionTemplate.invokeMethod('setLeftButton' ,{'template': template}).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static Future<bool> _setMiddleButtonTemplate(String template) {
    try {
      return _notionTemplate.invokeMethod('setMiddleButton' ,{'template': template}).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  static Future<bool> _setRightButtonTemplate(String template) {
    try {
      return _notionTemplate.invokeMethod('setRightButton' ,{'template': template}).then((value) {
        if (value is bool) {
          return value;
        }
        return false;
      });
    } on PlatformException catch (_) {
      return Future.value(false);
    }
  }

  final TextEditingController _receivedTemplateController = TextEditingController();
  final TextEditingController _leftButtonTemplateController = TextEditingController();
  final TextEditingController _middleButtonTemplateController = TextEditingController();
  final TextEditingController _rightButtonTemplateController = TextEditingController();

  @override
  void dispose(){
    _receivedTemplateController.dispose();
    _leftButtonTemplateController.dispose();
    _middleButtonTemplateController.dispose();
    _rightButtonTemplateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 16, 0, 0),
          child: Text(
            'Notion Template',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 0),
          child: Text(
            'Set a template for the message to be sent to Notion when it receives a notification.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child:
          Wrap(
              children: [
                FutureBuilder<String>(
                  future: _getReceivedTemplate(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _receivedTemplateController.text = snapshot.data ?? '';
                      return TextField(
                        maxLines: null,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[\n\r]')),
                        ],
                        controller: _receivedTemplateController,
                        onChanged: (value) {
                          _setReceivedTemplate(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your API key',
                        ),
                      );
                    }  else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ]
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 0),
          child: Text(
            'Set a template for the message to be sent to Notion when the Send 5 Minutes button is pressed.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child:
          Wrap(
              children: [
                FutureBuilder<String>(
                  future: _getLeftButtonTemplate(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _leftButtonTemplateController.text = snapshot.data ?? '';
                      return TextField(
                        maxLines: null,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[\n\r]')),
                        ],
                        controller: _leftButtonTemplateController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Database ID or URL',
                        ),
                        onChanged: (value) {
                          _setLeftButtonTemplate(value);
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ]
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 0),
          child: Text(
            'Set a template for the message to be sent to Notion when the Send 10 Minutes button is pressed.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child:
          Wrap(
              children: [
                FutureBuilder<String>(
                  future: _getMiddleButtonTemplate(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _middleButtonTemplateController.text = snapshot.data ?? '';
                      return TextField(
                        maxLines: null,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[\n\r]')),
                        ],
                        controller: _middleButtonTemplateController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Database ID or URL',
                        ),
                        onChanged: (value) {
                          _setMiddleButtonTemplate(value);
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ]
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 0),
          child: Text(
            'Set a template for the message to be sent to Notion when the Send an Hour button is pressed.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child:
          Wrap(
              children: [
                FutureBuilder<String>(
                  future: _getRightButtonTemplate(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _rightButtonTemplateController.text = snapshot.data ?? '';
                      return TextField(
                        maxLines: null,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[\n\r]')),
                        ],
                        controller: _rightButtonTemplateController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Database ID or URL',
                        ),
                        onChanged: (value) {
                          _setRightButtonTemplate(value);
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ]
          ),
        ),
      ],
    );
  }
}
