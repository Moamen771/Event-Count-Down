// To parse this JSON data, do
//
//     final onlineEvent = onlineEventFromJson(jsonString);

import 'dart:convert';

OnlineEvent onlineEventFromJson(String str) =>
    OnlineEvent.fromJson(json.decode(str));

String onlineEventToJson(OnlineEvent data) => json.encode(data.toJson());

class OnlineEvent {
  final int position;
  final String title;
  final String link;
  final String favicon;
  final String snippet;

  OnlineEvent({
    required this.position,
    required this.title,
    required this.link,
    required this.favicon,
    required this.snippet,
  });

  OnlineEvent copyWith({
    int? position,
    String? title,
    String? link,
    String? favicon,
    String? snippet,
  }) =>
      OnlineEvent(
        position: position ?? this.position,
        title: title ?? this.title,
        link: link ?? this.link,
        favicon: favicon ?? this.favicon,
        snippet: snippet ?? this.snippet,
      );

  factory OnlineEvent.fromJson(Map<String, dynamic> json) => OnlineEvent(
        position: json["position"],
        title: json["title"],
        link: json["link"],
        favicon: json["favicon"],
        snippet: json["snippet"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "title": title,
        "link": link,
        "favicon": favicon,
        "snippet": snippet,
      };
}
