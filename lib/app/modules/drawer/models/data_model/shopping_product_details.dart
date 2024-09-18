class ProductDetails {
  int? id;
  int? productId;
  String? productName;
  int? quantity;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;
  String? productImage;

  ProductDetails({
    this.id,
    this.productId,
    this.productName,
    this.quantity,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.productImage,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "product_image": productImage,
      };
}
