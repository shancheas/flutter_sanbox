class WordsListModel {
  List<WordsModel> wordsModel;
  String messages;
  String nextPageUrl;
  int error;
  int currentPage;
  int nextPage;
  int lastPage;

  WordsListModel({this.wordsModel, this.messages, this.error});

  bool isLastPage() => currentPage == lastPage;

  WordsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      wordsModel = new List<WordsModel>();
      json['data']['data'].forEach((v) {
        wordsModel.add(new WordsModel.fromJson(v));
      });
    }
    messages = json['data']['messages'];
    error = json['data']['error'];
    nextPageUrl = json['data']['next_page_url'];
    currentPage = json['data']['current_page'];
    lastPage = json['data']['last_page'];
    nextPage = currentPage + 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wordsModel != null) {
      data['data'] = this.wordsModel.map((v) => v.toJson()).toList();
    }
    data['messages'] = this.messages;
    data['error'] = this.error;
    return data;
  }
}

class WordsModel {
  int id;
  String banner;
  String foto;
  String name;
  String jobPosition;
  Country country;
  City city;
  String location;
  String createdAt;
  String updatedAt;
  String status;
  List<DetailLanguage> detailLanguage;

  WordsModel(
      {this.id,
      this.banner,
      this.foto,
      this.name,
      this.jobPosition,
      this.country,
      this.city,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.detailLanguage});

  WordsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    foto = json['foto'];
    name = json['name'];
    jobPosition = json['job_position'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    if (json['detail_language'] != null) {
      detailLanguage = new List<DetailLanguage>();
      json['detail_language'].forEach((v) {
        detailLanguage.add(new DetailLanguage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['foto'] = this.foto;
    data['name'] = this.name;
    data['job_position'] = this.jobPosition;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.detailLanguage != null) {
      data['detail_language'] =
          this.detailLanguage.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String id;
  String name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class City {
  int id;
  String name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class DetailLanguage {
  int id;
  int wordsFromCpId;
  String openingSpeech;
  String description;
  Language language;
  String status;
  String createdAt;
  String updatedAt;

  DetailLanguage(
      {this.id,
      this.wordsFromCpId,
      this.openingSpeech,
      this.description,
      this.language,
      this.status,
      this.createdAt,
      this.updatedAt});

  DetailLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wordsFromCpId = json['words_from_cp_id'];
    openingSpeech = json['opening_speech'];
    description = json['description'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['words_from_cp_id'] = this.wordsFromCpId;
    data['opening_speech'] = this.openingSpeech;
    data['description'] = this.description;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Language {
  int id;
  String name;

  Language({this.id, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
