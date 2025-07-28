class UserProfile {
  final String uid;
  final String email;
  final String name;
  final String address;
  final String contactNumber;
  final DateTime createdAt;
  final bool isAdmin;

  UserProfile({
    required this.uid,
    required this.email,
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.createdAt,
    this.isAdmin = false,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
      'createdAt': createdAt.toIso8601String(),
      'isAdmin': isAdmin,
    };
  }

  // Create from Firestore Map
  factory UserProfile.fromMap(Map<String, dynamic> map, String documentId) {
    return UserProfile(
      uid: map['uid'] ?? documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      createdAt:
          DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      isAdmin: map['isAdmin'] ?? false,
    );
  }

  // Create a copy with updated fields
  UserProfile copyWith({
    String? uid,
    String? email,
    String? name,
    String? address,
    String? contactNumber,
    DateTime? createdAt,
    bool? isAdmin,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      createdAt: createdAt ?? this.createdAt,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
