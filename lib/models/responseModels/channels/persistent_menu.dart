class PersistentMenu {
  int? id;
  String? type;
  String? extra;
  String? title;
  String? value;
  String? payload;
  String? verbose;
  int? formSequence;
  dynamic formSequenceTitle;
  bool? messengerExtensions;
  String? webviewHeightRatio;

  PersistentMenu({
    this.id,
    this.type,
    this.extra,
    this.title,
    this.value,
    this.payload,
    this.verbose,
    this.formSequence,
    this.formSequenceTitle,
    this.messengerExtensions,
    this.webviewHeightRatio,
  });

  factory PersistentMenu.fromJson(Map<String, dynamic> json) => PersistentMenu(
        id: json['id'] as int?,
        type: json['type'] as String?,
        extra: json['extra'] as String?,
        title: json['title'] as String?,
        value: json['value'] ,
        payload: json['payload'] as String?,
        verbose: json['verbose'] as String?,
        formSequence: json['form_sequence'] as int?,
        formSequenceTitle: json['form_sequence_title'],
        messengerExtensions: json['messenger_extensions'] as bool?,
        webviewHeightRatio: json['webview_height_ratio'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'extra': extra,
        'title': title,
        'value': value,
        'payload': payload,
        'verbose': verbose,
        'form_sequence': formSequence,
        'form_sequence_title': formSequenceTitle,
        'messenger_extensions': messengerExtensions,
        'webview_height_ratio': webviewHeightRatio,
      };
}
