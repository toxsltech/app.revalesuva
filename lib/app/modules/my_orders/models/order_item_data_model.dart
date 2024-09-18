class OrderItemDetails {
  var id;
  var uniqueId;
  var billingAddressId;
  var itemCount;
  var totalPrice;
  var price;
  var stateId;
  var typeId;
  DateTime? createdOn;
  var createdById;
  Address? address;

  OrderItemDetails({
    this.id,
    this.uniqueId,
    this.billingAddressId,
    this.itemCount,
    this.totalPrice,
    this.price,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.address,
  });

  factory OrderItemDetails.fromJson(Map<String, dynamic> json) =>
      OrderItemDetails(
        id: json["id"],
        uniqueId: json["unique_id"],
        billingAddressId: json["billing_address_id"],
        itemCount: json["item_count"],
        totalPrice: json["total_price"],
        price: json["price"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "billing_address_id": billingAddressId,
        "item_count": itemCount,
        "total_price": totalPrice,
        "price": price,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "address": address?.toJson(),
      };
}

class Address {
  var id;
  var fullName;
  var email;
  var counrtyCode;
  var contactNo;
  var address;
  var latitude;
  var longitude;
  var city;
  var state;
  var country;
  var zipCode;
  var stateId;
  var typeId;
  DateTime? createdOn;
  var createdById;

  Address({
    this.id,
    this.fullName,
    this.email,
    this.counrtyCode,
    this.contactNo,
    this.address,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        counrtyCode: json["counrty_code"],
        contactNo: json["contact_no"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "counrty_code": counrtyCode,
        "contact_no": contactNo,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
