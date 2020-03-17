import './profile_model.dart';
import './historical_model.dart';

class Prices {
  Profile profile;
  List<Historical> data;

  Prices({this.data, this.profile});

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      profile: Profile.fromJson(json["companyData"]["profile"]),
      data: List<Historical>.from(json["data"].map((jsonObject) {
        return Historical.fromJson(jsonObject);
      })),
    );
  }
}
