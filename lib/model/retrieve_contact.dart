class ContactModel {
  final int id;
  final String name;
  final String phone;

  ContactModel({required this.id, required this.name, required this.phone});

  // Factory method to create a ContactModel from JSON
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  // Convert ContactModel to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
