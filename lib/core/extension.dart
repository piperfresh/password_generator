import 'package:flutter/material.dart';
import 'package:password_generator/core/size_configs.dart';

extension ResponsiveSizeExtension on num {
  double get h => SizeConfig.getProportionateScreenHeight(toDouble());

  double get w => SizeConfig.getProportionateScreenWidth(toDouble());

  double get sp => SizeConfig.getProportionateScreenWidth(toDouble());

  SizedBox get sbW => SizedBox(width: w);

  SizedBox get sbH => SizedBox(height: h);
}

extension AssetsImage on String {
  String get png => 'assets/images/$this.png';

  String get svg => 'assets/icons/$this.svg';
}

extension BuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop(result);
  }

  Future<T?> push<T extends Object?>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }
}
