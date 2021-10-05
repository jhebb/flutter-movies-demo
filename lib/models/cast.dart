class Cast {
  Cast({
    this.id,
    required this.name,
    required this.character,
  });

  final num? id;
  final String name;
  final String character;

  // Cast copyWith({
  //   num? id,
  //   String? name,
  // }) {
  //   return Cast(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //   };
  // }

  factory Cast.fromJson(Map<String, dynamic> map) {
    return Cast(
      id: map['id'],
      name: map['name'],
      character: map['character'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Cast.fromJson(String source) => Cast.fromMap(json.decode(source));

  // @override
  // String toString() => 'Cast(id: $id, name: $name)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Cast &&
  //     other.id == id &&
  //     other.name == name;
  // }

  // @override
  // int get hashCode => id.hashCode ^ name.hashCode;
}
