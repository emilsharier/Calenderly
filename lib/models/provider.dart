class ProviderModel {
  String providerId, name, phone, email;

  ProviderModel.fromJson(Map<String, dynamic> json) {
    providerId = json['user_id'].toString();
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}
