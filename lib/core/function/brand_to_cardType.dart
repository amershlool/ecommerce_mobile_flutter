import 'package:flutter_credit_card/flutter_credit_card.dart';

CardType brandToCardTypeSwitch(String? brand) {
  if (brand == null) return CardType.otherBrand;

  final b = brand.toLowerCase().trim();

  switch (b) {
    case 'visa':
      return CardType.visa;

    case 'mastercard':
    case 'master card':
    case 'master':
      return CardType.mastercard;

    case 'amex':
    case 'american express':
    case 'americanexpress':
      return CardType.americanExpress;

    case 'discover':
      return CardType.discover;

    case 'unionpay':
    case 'union pay':
      return CardType.unionpay;

    case 'elo':
      return CardType.elo;

    case 'hipercard':
    case 'hiper':
      return CardType.hipercard;

    case 'mir':
      return CardType.mir;

    case 'rupay':
      return CardType.rupay;

    case 'maestro':
    case 'maestro card':
    case 'jcb':
    case 'diners':
    case 'diners_club':
    case 'dinersclub':
    case 'interac':
    case 'elo-like':
      return CardType.otherBrand;

    default:
      return CardType.otherBrand;
  }
}
