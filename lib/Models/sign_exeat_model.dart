class SignExeatModel {
  final String name;
  final String to;
  final String reason;
  final String time;
  bool isBack;

  SignExeatModel({
    required this.name,
    required this.to,
    required this.reason,
    required this.time,
    required this.isBack,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'to': to,
    'reason': reason,
    'time': time,
    'isBack': isBack,
  };

  factory SignExeatModel.fromJson(Map<String, dynamic> json) => SignExeatModel(
    name: json['name'] ?? '',
    to: json['to'] ?? '',
    reason: json['reason'] ?? '',
    time: json['time'] ?? '',
    isBack: json['isBack'] ?? false,
  );

  void updateIsBack(bool status) {
    isBack = status;
  }
}