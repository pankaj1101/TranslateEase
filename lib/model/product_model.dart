/// Represents a product response from the API
class ProductResponse {
  /// The message from the API
  final String? message;

  /// A map of products, keyed by category ID
  final Map<String, List<Product>>? products;

  ProductResponse({this.message, this.products});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      message: json['message'],
      products: (json['products'] as Map<String, dynamic>?)?.map((key, value) {
        return MapEntry(
            key,
            (value as List<dynamic>)
                .map((product) => Product.fromJson(product))
                .toList());
      }),
    );
  }
}

/// Represents a product
class Product {
  /// The category ID of the product
  final int? categoryId;

  /// The category name of the product
  final String? categoryName;

  /// The product ID
  final int? productId;

  /// The name of the product
  final String? name;

  /// The description of the product
  final String? description;

  /// The cost of the product
  final double? cost;

  /// The tag of the product
  final String? tag;

  /// The image path of the product
  final String? imagePath;

  /// A list of image paths for the product
  final List<String>? images;

  /// Whether the product is taxable
  final bool? isTaxable;

  /// The type of the product
  final String? type;

  /// The quantity of the product
  final int? quantity;

  /// Whether the product is active
  final bool? active;

  Product({
    this.categoryId,
    this.categoryName,
    this.productId,
    this.name,
    this.description,
    this.cost,
    this.tag,
    this.imagePath,
    this.images,
    this.isTaxable,
    this.type,
    this.quantity,
    this.active,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      cost: json['cost'],
      tag: json['tag'],
      imagePath: json['imagePath'],
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => image as String)
          .toList(),
      isTaxable: json['isTaxable'],
      type: json['type'],
      quantity: json['quantity'],
      active: json['active'],
    );
  }
}
