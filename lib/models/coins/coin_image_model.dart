class CoinImage {
  final String? thumb;
  final String? small;
  final String? large;

  CoinImage({this.thumb, this.small, this.large});

  factory CoinImage.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CoinImage();
    return CoinImage(
      thumb: json['thumb'],
      small: json['small'],
      large: json['large'],
    );
  }
}
