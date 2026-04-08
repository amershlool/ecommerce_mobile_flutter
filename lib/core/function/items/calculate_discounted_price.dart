double calculateDiscountedPrice(double originalPrice, int discountPercent) {
  double discountAmount = originalPrice * (discountPercent / 100);
  double finalPrice = originalPrice - discountAmount;
  return finalPrice;
}
