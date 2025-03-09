class GroupMember {
  final int id;
  final String name;
  final String email;

  GroupMember({required this.id, required this.name, required this.email});

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
