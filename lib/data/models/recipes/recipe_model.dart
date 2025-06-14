import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Result>? results;
  int? offset;
  int? number;
  int? totalResults;

  Welcome({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    offset: json["offset"],
    number: json["number"],
    totalResults: json["totalResults"],
  );

  Map<String, dynamic> toJson() => {
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "offset": offset,
    "number": number,
    "totalResults": totalResults,
  };
}

class Result {
  int? id;
  String? image;
  String? imageType;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  bool? lowFodmap;
  int? weightWatcherSmartPoints;
  String? gaps;
  int? preparationMinutes;
  int? cookingMinutes;
  int? aggregateLikes;
  int? healthScore;
  String? creditsText;
  dynamic license;
  String? sourceName;
  double? pricePerServing;
  List<EdIngredient>? extendedIngredients;
  String? summary;
  List<dynamic>? cuisines;
  List<String>? dishTypes;
  List<String>? diets;
  List<String>? occasions;
  double? spoonacularScore;
  String? spoonacularSourceUrl;
  int? usedIngredientCount;
  int? missedIngredientCount;
  List<EdIngredient>? missedIngredients;
  int? likes;
  List<dynamic>? usedIngredients;
  List<dynamic>? unusedIngredients;

  Result({
    this.id,
    this.image,
    this.imageType,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.lowFodmap,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.preparationMinutes,
    this.cookingMinutes,
    this.aggregateLikes,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.spoonacularScore,
    this.spoonacularSourceUrl,
    this.usedIngredientCount,
    this.missedIngredientCount,
    this.missedIngredients,
    this.likes,
    this.usedIngredients,
    this.unusedIngredients,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    image: json["image"],
    imageType: json["imageType"],
    title: json["title"],
    readyInMinutes: json["readyInMinutes"],
    servings: json["servings"],
    sourceUrl: json["sourceUrl"],
    vegetarian: json["vegetarian"],
    vegan: json["vegan"],
    glutenFree: json["glutenFree"],
    dairyFree: json["dairyFree"],
    veryHealthy: json["veryHealthy"],
    cheap: json["cheap"],
    veryPopular: json["veryPopular"],
    sustainable: json["sustainable"],
    lowFodmap: json["lowFodmap"],
    weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
    gaps: json["gaps"],
    preparationMinutes: json["preparationMinutes"],
    cookingMinutes: json["cookingMinutes"],
    aggregateLikes: json["aggregateLikes"],
    healthScore: json["healthScore"],
    creditsText: json["creditsText"],
    license: json["license"],
    sourceName: json["sourceName"],
    pricePerServing: json["pricePerServing"]?.toDouble(),
    extendedIngredients: json["extendedIngredients"] == null ? [] : List<EdIngredient>.from(json["extendedIngredients"]!.map((x) => EdIngredient.fromJson(x))),
    summary: json["summary"],
    cuisines: json["cuisines"] == null ? [] : List<dynamic>.from(json["cuisines"]!.map((x) => x)),
    dishTypes: json["dishTypes"] == null ? [] : List<String>.from(json["dishTypes"]!.map((x) => x)),
    diets: json["diets"] == null ? [] : List<String>.from(json["diets"]!.map((x) => x)),
    occasions: json["occasions"] == null ? [] : List<String>.from(json["occasions"]!.map((x) => x)),
    spoonacularScore: json["spoonacularScore"]?.toDouble(),
    spoonacularSourceUrl: json["spoonacularSourceUrl"],
    usedIngredientCount: json["usedIngredientCount"],
    missedIngredientCount: json["missedIngredientCount"],
    missedIngredients: json["missedIngredients"] == null ? [] : List<EdIngredient>.from(json["missedIngredients"]!.map((x) => EdIngredient.fromJson(x))),
    likes: json["likes"],
    usedIngredients: json["usedIngredients"] == null ? [] : List<dynamic>.from(json["usedIngredients"]!.map((x) => x)),
    unusedIngredients: json["unusedIngredients"] == null ? [] : List<dynamic>.from(json["unusedIngredients"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "imageType": imageType,
    "title": title,
    "readyInMinutes": readyInMinutes,
    "servings": servings,
    "sourceUrl": sourceUrl,
    "vegetarian": vegetarian,
    "vegan": vegan,
    "glutenFree": glutenFree,
    "dairyFree": dairyFree,
    "veryHealthy": veryHealthy,
    "cheap": cheap,
    "veryPopular": veryPopular,
    "sustainable": sustainable,
    "lowFodmap": lowFodmap,
    "weightWatcherSmartPoints": weightWatcherSmartPoints,
    "gaps": gaps,
    "preparationMinutes": preparationMinutes,
    "cookingMinutes": cookingMinutes,
    "aggregateLikes": aggregateLikes,
    "healthScore": healthScore,
    "creditsText": creditsText,
    "license": license,
    "sourceName": sourceName,
    "pricePerServing": pricePerServing,
    "extendedIngredients": extendedIngredients == null ? [] : List<dynamic>.from(extendedIngredients!.map((x) => x.toJson())),
    "summary": summary,
    "cuisines": cuisines == null ? [] : List<dynamic>.from(cuisines!.map((x) => x)),
    "dishTypes": dishTypes == null ? [] : List<dynamic>.from(dishTypes!.map((x) => x)),
    "diets": diets == null ? [] : List<dynamic>.from(diets!.map((x) => x)),
    "occasions": occasions == null ? [] : List<dynamic>.from(occasions!.map((x) => x)),
    "spoonacularScore": spoonacularScore,
    "spoonacularSourceUrl": spoonacularSourceUrl,
    "usedIngredientCount": usedIngredientCount,
    "missedIngredientCount": missedIngredientCount,
    "missedIngredients": missedIngredients == null ? [] : List<dynamic>.from(missedIngredients!.map((x) => x.toJson())),
    "likes": likes,
    "usedIngredients": usedIngredients == null ? [] : List<dynamic>.from(usedIngredients!.map((x) => x)),
    "unusedIngredients": unusedIngredients == null ? [] : List<dynamic>.from(unusedIngredients!.map((x) => x)),
  };
}

class EdIngredient {
  int? id;
  String? aisle;
  String? image;
  Consistency? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalName;
  double? amount;
  String? unit;
  List<String>? meta;
  Measures? measures;
  String? unitLong;
  String? unitShort;
  String? extendedName;

  EdIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
    this.unitLong,
    this.unitShort,
    this.extendedName,
  });

  factory EdIngredient.fromJson(Map<String, dynamic> json) => EdIngredient(
    id: json["id"],
    aisle: json["aisle"],
    image: json["image"],
    consistency: consistencyValues.map[json["consistency"]]!,
    name: json["name"],
    nameClean: json["nameClean"],
    original: json["original"],
    originalName: json["originalName"],
    amount: json["amount"]?.toDouble(),
    unit: json["unit"],
    meta: json["meta"] == null ? [] : List<String>.from(json["meta"]!.map((x) => x)),
    measures: json["measures"] == null ? null : Measures.fromJson(json["measures"]),
    unitLong: json["unitLong"],
    unitShort: json["unitShort"],
    extendedName: json["extendedName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "aisle": aisle,
    "image": image,
    "consistency": consistencyValues.reverse[consistency],
    "name": name,
    "nameClean": nameClean,
    "original": original,
    "originalName": originalName,
    "amount": amount,
    "unit": unit,
    "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
    "measures": measures?.toJson(),
    "unitLong": unitLong,
    "unitShort": unitShort,
    "extendedName": extendedName,
  };
}

enum Consistency {
  LIQUID,
  SOLID
}

final consistencyValues = EnumValues({
  "LIQUID": Consistency.LIQUID,
  "SOLID": Consistency.SOLID
});

class Measures {
  Metric? us;
  Metric? metric;

  Measures({
    this.us,
    this.metric,
  });

  factory Measures.fromJson(Map<String, dynamic> json) => Measures(
    us: json["us"] == null ? null : Metric.fromJson(json["us"]),
    metric: json["metric"] == null ? null : Metric.fromJson(json["metric"]),
  );

  Map<String, dynamic> toJson() => {
    "us": us?.toJson(),
    "metric": metric?.toJson(),
  };
}

class Metric {
  double? amount;
  String? unitShort;
  String? unitLong;

  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
    amount: json["amount"]?.toDouble(),
    unitShort: json["unitShort"],
    unitLong: json["unitLong"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "unitShort": unitShort,
    "unitLong": unitLong,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
