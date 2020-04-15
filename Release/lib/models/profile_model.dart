class Profile {
  String ceo;
  String companyName;
  String exchange;
  String image;
  double price;
  String sector;
  String website;

  Profile({
    this.ceo,
    this.companyName,
    this.exchange,
    this.image,
    this.price,
    this.sector,
    this.website,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        ceo: json["ceo"],
        companyName: json["companyName"],
        exchange: json["exchange"],
        image: json["image"],
        price: json["price"],
        sector: json["sector"],
        website: json["website"],
      );
}
