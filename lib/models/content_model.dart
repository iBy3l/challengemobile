class ContentModel {
  String video;
  String audio;
  String pdf;

  ContentModel(this.video, this.audio, this.pdf);

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      map['video'],
      map['audio'],
      map['pdf'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video'] = video;
    data['audio'] = audio;
    data['pdf'] = pdf;
    return data;
  }
}
