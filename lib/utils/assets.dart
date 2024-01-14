import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcons {
  add('add'),
  help('help'),
  instagram('instagram'),
  logOut('log-out'),
  policies('policies'),
  tikTok('tik-tok'),
  flag('flag'),
  logo('yolloLogo'),
  chevronDown('chevronDown'),
  arrowRight('arrowRight'),
  arrowLeft('arrow-left'),
  truck('truck'),
  person('person'),
  home('home'),
  box('box'),
  news('news'),
  profile('profile');

  final String path;

  const AppIcons(this.path);

  String get _svg => 'assets/icons/$path.svg';

  String get _png => 'assets/icons/$path.png';

  String get _jpg => 'assets/icons/$path.jpg';

  Widget svgPicture({
    double? height,
    double? width,
    Color? color,
  }) =>
      SvgPicture.asset(
        _svg,
        height: height,
        width: width,
        color: color,
      );

  Widget get pngPicture => Image.asset(_png);

  Widget get jpgPicture => Image.asset(_jpg);
}
