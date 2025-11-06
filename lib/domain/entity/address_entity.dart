class AddressEntity {
  final String city;
  final String state;
  final String country;
  final String road;
  final int houseNumber;

  AddressEntity({
    required this.city,
    required this.country,
    required this.road,
    required this.state,
    required this.houseNumber,
  });

  factory AddressEntity.empty() {
    return AddressEntity(
      city: '',
      country: '',
      road: '',
      state: '',
      houseNumber: 0,
    );
  }
}
