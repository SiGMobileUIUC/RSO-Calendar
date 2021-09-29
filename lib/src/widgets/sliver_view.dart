import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SliverView extends StatelessWidget {
  const SliverView({
    Key? key,
    required this.title,
    required this.children,
    required this.actions,
    required this.leading,
    this.drawer,
    this.titleStyle,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final TextStyle? titleStyle;
  final List<Widget> actions;
  final Widget? leading;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      body: CustomScrollView(
        slivers: [
          PlatformWidget(
            material: (context, _) => SliverAppBar(
              pinned: true,
              forceElevated: true,
              expandedHeight: 80.0,
              // backgroundColor: AppColors.primaryUofI,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  title,
                  style: titleStyle ?? const TextStyle(),
                ),
              ),
              actions: actions,
              leading: leading,
            ),
            cupertino: (context, _) => CupertinoSliverNavigationBar(
              // backgroundColor: AppColors.secondaryUofIDark,
              border: const Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey,
                  width: 0.5,
                ),
              ),
              largeTitle: Text(
                title,
                style: titleStyle ?? const TextStyle(),
              ),
              trailing: actions[0],
            ),
          ),
          SliverSafeArea(
            top: false, // Top safe area is consumed by the navigation bar.
            sliver: SliverList(
              delegate: SliverChildListDelegate(children),
            ),
          ),
        ],
      ),
    );
  }
}
