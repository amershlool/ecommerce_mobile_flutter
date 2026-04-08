class AddressModel {
  int? addressId;
  int? addressUsersid;
  String? addressName;
  String? addressStreet;
  String? addressCity;
  String? addressPhone;
  String? addressDescription;

  AddressModel(
      {this.addressId,
        this.addressUsersid,
        this.addressName,
        this.addressStreet,
        this.addressCity,
        this.addressPhone,
        this.addressDescription});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressUsersid = json['address_usersid'];
    addressName = json['address_name'];
    addressStreet = json['address_street'];
    addressCity = json['address_city'];
    addressPhone = json['address_phone'];
    addressDescription = json['address_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_usersid'] = this.addressUsersid;
    data['address_name'] = this.addressName;
    data['address_street'] = this.addressStreet;
    data['address_city'] = this.addressCity;
    data['address_phone'] = this.addressPhone;
    data['address_description'] = this.addressDescription;
    return data;
  }
}
