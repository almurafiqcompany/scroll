import 'package:flutter/widgets.dart';

import 'extensions.dart';

extension TextX on Text {
  //if u call translate, data will used to be a key for translation
  Text translate(BuildContext context) {
    return Text(
      context.translate(data!),
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      key: key,
      locale: locale,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
