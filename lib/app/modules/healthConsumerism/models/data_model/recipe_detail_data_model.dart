class RecipeList {
  int? id;
  String? title;
  String? image;
  String? description;
  String? density;
  String? method;
  int? stateId;
  int? typeId;
  int? recipeSchedule;
  DateTime? createdOn;
  int? createdById;
  List<Ingredient>? ingredient;

  RecipeList({
    this.id,
    this.title,
    this.image,
    this.description,
    this.density,
    this.method,
    this.stateId,
    this.typeId,
    this.recipeSchedule,
    this.createdOn,
    this.createdById,
    this.ingredient,
  });

  factory RecipeList.fromJson(Map<String, dynamic> json) => RecipeList(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        density: json["density"],
        method: json["method"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        recipeSchedule: json["recipe_schedule"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        ingredient: json["ingredient"] == null
            ? []
            : List<Ingredient>.from(
                json["ingredient"]!.map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "density": density,
        "method": method,
        "state_id": stateId,
        "type_id": typeId,
        "recipe_schedule": recipeSchedule,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "ingredient": ingredient == null
            ? []
            : List<dynamic>.from(ingredient!.map((x) => x.toJson())),
      };
}

class Ingredient {
  int? id;
  int? recipeId;
  int? ingredientsId;
  String? ingredientName;
  int? quantity;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  Ingredient({
    this.id,
    this.recipeId,
    this.ingredientsId,
    this.ingredientName,
    this.quantity,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        recipeId: json["recipe_id"],
        ingredientsId: json["ingredients_id"],
        ingredientName: json["ingredient_name"],
        quantity: json["quantity"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recipe_id": recipeId,
        "ingredients_id": ingredientsId,
        "ingredient_name": ingredientName,
        "quantity": quantity,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
