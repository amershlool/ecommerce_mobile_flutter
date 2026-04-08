class ViewPaymentMethods {
  int? id;
  int? userId;
  String? name;
  String? stripeCustomerId;
  String? paymentMethodId;
  String? brand;
  String? last4;
  int? expMonth;
  int? expYear;
  int? isDefault;
  String? createdAt;

  ViewPaymentMethods(
      {this.id,
        this.userId,
        this.name,
        this.stripeCustomerId,
        this.paymentMethodId,
        this.brand,
        this.last4,
        this.expMonth,
        this.expYear,
        this.isDefault,
        this.createdAt});

  ViewPaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    stripeCustomerId = json['stripe_customer_id'];
    paymentMethodId = json['payment_method_id'];
    brand = json['brand'];
    last4 = json['last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['payment_method_id'] = this.paymentMethodId;
    data['brand'] = this.brand;
    data['last4'] = this.last4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    return data;
  }
}