class ShippingAddress {
  String? addressOne;
  String? addressTwo;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? firstName;
  String? lastName;
  String? company;
  String? email;
  String? phone;

  ShippingAddress({
    this.addressOne,
    this.addressTwo,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.firstName,
    this.lastName,
    this.company,
    this.email,
    this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        addressOne: json['address_one'] as String?,
        addressTwo: json['address_two'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        postcode: json['postcode'] as String?,
        country: json['country'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        company: json['company'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address_one': addressOne,
        'address_two': addressTwo,
        'city': city,
        'state': state,
        'postcode': postcode,
        'country': country,
        'first_name': firstName,
        'last_name': lastName,
        'company': company,
        'email': email,
        'phone': phone,
      };
}
