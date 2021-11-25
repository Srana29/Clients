class ClientClass {
  ClientClass({
    required this.id,
    required this.name,
    required this.company,
    required this.orderId,
    required this.invoicepaid,
    required this.invoicePending,
  });

  String id;
  String name;
  String company;
  String orderId;
  String invoicepaid;
  String invoicePending;



  factory ClientClass.fromJson(Map<String, dynamic> json) {
    return ClientClass(
      id: json['id'],
      name: json['name'],
      orderId: json["orderId"],
      invoicepaid: json["invoicepaid"],
      invoicePending: json["invoicePending"],
      company: json["company"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "orderId": orderId,
    "invoicepaid": invoicepaid,
    "invoicePending": invoicePending,
    "company": company,
  };
}


