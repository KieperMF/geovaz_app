class AddressEntity {
  final String city;
  final String state;
  final String country;
  final String road;
  final String houseNumber;
  final String zipCode;

  AddressEntity({
    required this.city,
    required this.country,
    required this.road,
    required this.state,
    required this.houseNumber,
    required this.zipCode,
  });

  factory AddressEntity.empty() {
    return AddressEntity(
      city: '',
      country: '',
      road: '',
      state: '',
      houseNumber: '',
      zipCode: '',
    );
  }
}
