class PinInfo {
  int? id;
  String imageUrl;
  double x;
  double y;

  PinInfo({this.id, required this.imageUrl, required this.x, required this.y});

  Map<String, dynamic> toJson() => {
        'imagePath': imageUrl,
        'X': x,
        'Y': y,
      };

  factory PinInfo.fromJson(Map<String, dynamic> json) => PinInfo(
        id: json['id'],
        imageUrl: (json['imagePath'] ?? '').toString(),
        x: (json['x'] as num).toDouble(),
        y: (json['y'] as num).toDouble(),
      );
}