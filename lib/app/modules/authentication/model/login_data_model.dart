class LoginDataModel {
  var id;
  String? fullName;
  String? email;
  dynamic dateOfBirth;
  var gender;
  String? age;
  String? contactNo;
  String? city;
  String? address;
  String? countryCode;
  var apartment;
  var floor;
  String? weight;
  String? height;
  String? language;
  String? profileFile;
  dynamic tos;
  var roleId;
  var stateId;
  var typeId;
  var profileCompleted;
  var planType;
  String? timezone;
  dynamic status;
  DateTime? createdOn;
  List<Image>? backImage;
  List<Image>? frontImage;
  List<Image>? sideImage;
  List<Image>? bloodTestImage;
  List<QuetionDetail>? quetionDetails;

  LoginDataModel({
    this.id,
    this.fullName,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.age,
    this.contactNo,
    this.apartment,
    this.floor,
    this.city,
    this.address,
    this.countryCode,
    this.weight,
    this.height,
    this.language,
    this.profileFile,
    this.tos,
    this.roleId,
    this.stateId,
    this.typeId,
    this.profileCompleted,
    this.planType,
    this.timezone,
    this.status,
    this.createdOn,
    this.backImage,
    this.frontImage,
    this.sideImage,
    this.bloodTestImage,
    this.quetionDetails,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        age: json["age"],
        contactNo: json["contact_no"],
        city: json["city"],
        address: json["address"],
        countryCode: json["country_code"],
        apartment: json["apartment_number"],
        floor: json["floor"],
        weight: json["weight"],
        height: json["height"],
        language: json["language"],
        profileFile: json["profile_file"],
        tos: json["tos"],
        roleId: json["role_id"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        profileCompleted: json["profile_completed"],
        planType: json["plan_type"],
        timezone: json["timezone"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        backImage: json["backImage"] == null
            ? []
            : List<Image>.from(
                json["backImage"]!.map((x) => Image.fromJson(x))),
        frontImage: json["frontImage"] == null
            ? []
            : List<Image>.from(
                json["frontImage"]!.map((x) => Image.fromJson(x))),
        sideImage: json["sideImage"] == null
            ? []
            : List<Image>.from(
                json["sideImage"]!.map((x) => Image.fromJson(x))),
        bloodTestImage: json["bloodTestImage"] == null
            ? []
            : List<Image>.from(
                json["bloodTestImage"]!.map((x) => Image.fromJson(x))),
        quetionDetails: json["Quetion_details"] == null
            ? []
            : List<QuetionDetail>.from(
                json["Quetion_details"]!.map((x) => QuetionDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "age": age,
        "contact_no": contactNo,
        "city": city,
        "address": address,
        "country_code": countryCode,
        "weight": weight,
        "apartment_number": apartment,
        "floor": floor,
        "height": height,
        "language": language,
        "profile_file": profileFile,
        "tos": tos,
        "role_id": roleId,
        "state_id": stateId,
        "type_id": typeId,
        "profile_completed": profileCompleted,
        "plan_type": planType,
        "timezone": timezone,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "backImage": backImage == null
            ? []
            : List<dynamic>.from(backImage!.map((x) => x.toJson())),
        "frontImage": frontImage == null
            ? []
            : List<dynamic>.from(frontImage!.map((x) => x.toJson())),
        "sideImage": sideImage == null
            ? []
            : List<dynamic>.from(sideImage!.map((x) => x.toJson())),
        "bloodTestImage": bloodTestImage == null
            ? []
            : List<dynamic>.from(bloodTestImage!.map((x) => x.toJson())),
        "Quetion_details": quetionDetails == null
            ? []
            : List<dynamic>.from(quetionDetails!.map((x) => x.toJson())),
      };
}

class Image {
  var id;
  String? name;
  var size;
  String? key;
  String? url;
  String? modelType;
  var modelId;
  dynamic projectId;
  var typeId;
  DateTime? createdOn;
  var createdById;

  Image({
    this.id,
    this.name,
    this.size,
    this.key,
    this.url,
    this.modelType,
    this.modelId,
    this.projectId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        key: json["key"],
        url: json["url"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        projectId: json["project_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "key": key,
        "url": url,
        "model_type": modelType,
        "model_id": modelId,
        "project_id": projectId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}

class QuetionDetail {
  var id;
  var questionId;
  String? title;
  String? question;
  var stateId;
  var typeId;
  DateTime? createdOn;
  var createdById;
  bool isSelected;
  bool groupValue = false;

  QuetionDetail({
    this.id,
    this.questionId,
    this.title,
    this.question,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    required this.isSelected,
    required this.groupValue,
  });

  factory QuetionDetail.fromJson(Map<String, dynamic> json) => QuetionDetail(
        id: json["id"],
        questionId: json["question_id"],
        title: json["title"],
        question: json["Question"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        isSelected: json["type_id"].toString() == "0" ? false : true,
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        groupValue: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "title": title,
        "Question": question,
        "state_id": stateId,
        "type_id": typeId,
        "isSelected": isSelected,
        "groupValue": groupValue,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
