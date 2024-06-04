class Client {
  final String firstName;
  final String lastName;
  final String id;
  final String email;
  final String imageUrl;

  Client({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.email,
    required this.imageUrl,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl'],
    );
  }
}