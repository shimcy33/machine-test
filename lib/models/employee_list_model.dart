class EmployeeListModel {
  int _id;
  String _name;
  String _username;
  String _email;
  String _profileImage;
  Address _address;
  String _phone;
  String _website;
  Company _company;

  EmployeeListModel(
      {int id,
        String name,
        String username,
        String email,
        String profileImage,
        Address address,
        String phone,
        String website,
        Company company}) {
    this._id = id;
    this._name = name;
    this._username = username;
    this._email = email;
    this._profileImage = profileImage;
    this._address = address;
    this._phone = phone;
    this._website = website;
    this._company = company;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get username => _username;
  set username(String username) => _username = username;
  String get email => _email;
  set email(String email) => _email = email;
  String get profileImage => _profileImage;
  set profileImage(String profileImage) => _profileImage = profileImage;
  Address get address => _address;
  set address(Address address) => _address = address;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get website => _website;
  set website(String website) => _website = website;
  Company get company => _company;
  set company(Company company) => _company = company;

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _profileImage = json['profile_image'];
    _address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    _phone = json['phone'];
    _website = json['website'];
    _company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['username'] = this._username;
    data['email'] = this._email;
    data['profile_image'] = this._profileImage;
    if (this._address != null) {
      data['address'] = this._address.toJson();
    }
    data['phone'] = this._phone;
    data['website'] = this._website;
    if (this._company != null) {
      data['company'] = this._company.toJson();
    }
    return data;
  }
}

class Address {
  String _street;
  String _suite;
  String _city;
  String _zipcode;
  Geo _geo;

  Address({String street, String suite, String city, String zipcode, Geo geo}) {
    this._street = street;
    this._suite = suite;
    this._city = city;
    this._zipcode = zipcode;
    this._geo = geo;
  }

  String get street => _street;
  set street(String street) => _street = street;
  String get suite => _suite;
  set suite(String suite) => _suite = suite;
  String get city => _city;
  set city(String city) => _city = city;
  String get zipcode => _zipcode;
  set zipcode(String zipcode) => _zipcode = zipcode;
  Geo get geo => _geo;
  set geo(Geo geo) => _geo = geo;

  Address.fromJson(Map<String, dynamic> json) {
    _street = json['street'];
    _suite = json['suite'];
    _city = json['city'];
    _zipcode = json['zipcode'];
    _geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this._street;
    data['suite'] = this._suite;
    data['city'] = this._city;
    data['zipcode'] = this._zipcode;
    if (this._geo != null) {
      data['geo'] = this._geo.toJson();
    }
    return data;
  }
}

class Geo {
  String _lat;
  String _lng;

  Geo({String lat, String lng}) {
    this._lat = lat;
    this._lng = lng;
  }

  String get lat => _lat;
  set lat(String lat) => _lat = lat;
  String get lng => _lng;
  set lng(String lng) => _lng = lng;

  Geo.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}

class Company {
  String _name;
  String _catchPhrase;
  String _bs;

  Company({String name, String catchPhrase, String bs}) {
    this._name = name;
    this._catchPhrase = catchPhrase;
    this._bs = bs;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get catchPhrase => _catchPhrase;
  set catchPhrase(String catchPhrase) => _catchPhrase = catchPhrase;
  String get bs => _bs;
  set bs(String bs) => _bs = bs;

  Company.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _catchPhrase = json['catchPhrase'];
    _bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['catchPhrase'] = this._catchPhrase;
    data['bs'] = this._bs;
    return data;
  }
}
