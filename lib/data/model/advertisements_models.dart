class AdvertisementsModels {
  int? advertisementsId;
  String? advertisementsTitleAr;
  String? advertisementsTitleEn;
  String? advertisementsSubtitleAr;
  String? advertisementsSubtitleEn;
  String? advertisementsImage;

  AdvertisementsModels(
      {this.advertisementsId,
        this.advertisementsTitleAr,
        this.advertisementsTitleEn,
        this.advertisementsSubtitleAr,
        this.advertisementsSubtitleEn,
        this.advertisementsImage});

  AdvertisementsModels.fromJson(Map<String, dynamic> json) {
    advertisementsId = json['advertisements_id'];
    advertisementsTitleAr = json['advertisements_title_ar'];
    advertisementsTitleEn = json['advertisements_title_en'];
    advertisementsSubtitleAr = json['advertisements_subtitle_ar'];
    advertisementsSubtitleEn = json['advertisements_subtitle_en'];
    advertisementsImage = json['advertisements_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advertisements_id'] = this.advertisementsId;
    data['advertisements_title_ar'] = this.advertisementsTitleAr;
    data['advertisements_title_en'] = this.advertisementsTitleEn;
    data['advertisements_subtitle_ar'] = this.advertisementsSubtitleAr;
    data['advertisements_subtitle_en'] = this.advertisementsSubtitleEn;
    data['advertisements_image'] = this.advertisementsImage;
    return data;
  }
}
