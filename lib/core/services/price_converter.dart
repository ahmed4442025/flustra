import 'dart:math';

class PriceConverter {
  static bool isRightSide = true;
  static String currencySymbol = "\$";
  static int digitAfterDecimalPoint = 2;

  static String convertPrice(num? price, {double? discount, String? discountType, bool forDM = false, bool isVariation = false}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount' && !isVariation) {
        price = price! - discount;
      } else if (discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }

    return '${isRightSide ? '' : '$currencySymbol '}'
        '${(toFixed(price!.toDouble())).toStringAsFixed(forDM ? 0 : digitAfterDecimalPoint).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${isRightSide ? ' $currencySymbol' : ''}';
  }

  // static Widget convertAnimationPrice(double? price, {double? discount, String? discountType, bool forDM = false, TextStyle? textStyle}) {
  //   if (discount != null && discountType != null) {
  //     if (discountType == 'amount') {
  //       price = price! - discount;
  //     } else if (discountType == 'percent') {
  //       price = price! - ((discount / 100) * price);
  //     }
  //   }
  //   return Directionality(
  //     textDirection: TextDirection.ltr,
  //     child: AnimatedFlipCounter(
  //       duration: Duration(milliseconds: kDebugMode ? 5000 : 500),
  //       value: toFixed(price!),
  //       textStyle: textStyle,
  //       fractionDigits: forDM ? 0 : digitAfterDecimalPoint,
  //       prefix: isRightSide ? '' : currencySymbol,
  //       suffix: isRightSide ? currencySymbol : '',
  //     ),
  //   );
  // }

  static double toFixed(double val) {
    num mod = power(10, digitAfterDecimalPoint);
    return (((val * mod).toPrecision(digitAfterDecimalPoint)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    var mod = pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }
}
