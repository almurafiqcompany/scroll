import 'package:al_murafiq/theme.dart';
import 'package:flutter/material.dart';

class GradientAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GradientAppbar({
    Key? key,
    this.title,
    this.color1,
    this.color2,
    this.actions,
  }) : super(key: key);
  final String? title;

  final Color? color1;
  final Color? color2;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 6);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: (title != null)
          ? Text(
              title!,
              style: appbarTitleStyle,
            )
          : null,
      iconTheme: const IconThemeData(
        color: Color(0xFFFFFFFF),
      ),
      actions: <Widget>[if (actions != null) ...actions!],
      flexibleSpace: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    color1 ?? const Color(0xFF03317C),
                    color2 ?? const Color(0xFF05B3D6),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 6,
            color: Colors.lime,
          ),
        ],
      ),
    );
  }
}
