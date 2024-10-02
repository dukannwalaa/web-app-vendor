class Vendor {
  String? id;
  String? mobile;
  String? email;
  String? name;
  bool? active;
  String? address;
  String? businessName;
  int? fssai;
  String? gstin;
  String? latLong;
  String? logo;
  String? aadhaar;
  String? pan;
  int? createAt;
  int? updateAt;
  int? pinCode;

  Vendor(
      {this.id,
        this.mobile,
        this.email,
        this.name,
        this.active,
        this.address,
        this.businessName,
        this.fssai,
        this.gstin,
        this.latLong,
        this.logo,
        this.aadhaar,
        this.pan,
        this.createAt,
        this.updateAt,
        this.pinCode});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    email = json['email'];
    name = json['name'];
    active = json['active'];
    address = json['address'];
    businessName = json['businessName'];
    fssai = json['fssai'];
    gstin = json['gstin'];
    latLong = json['latLong'];
    logo = json['logo'];
    aadhaar = json['aadhaar'];
    pan = json['pan'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile'] = mobile;
    data['email'] = email;
    data['name'] = name;
    data['active'] = active;
    data['address'] = address;
    data['businessName'] = businessName;
    data['fssai'] = fssai;
    data['gstin'] = gstin;
    data['latLong'] = latLong;
    data['logo'] = logo;
    data['aadhaar'] = aadhaar;
    data['pan'] = pan;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    data['pinCode'] = pinCode;
    return data;
  }
}
