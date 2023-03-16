import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kRichBlack,
      ),
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: kPrussianBlue,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('dawamuciil@gmail.com'),
          ),
          const ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Series'),
            onTap: () {
              Navigator.pushNamed(context, HOME_TV_ROUTE);
              _animationController.reverse();
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WATCHLIST_ROUTE);
              _animationController.reverse();
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
              _animationController.reverse();
            },
          ),
        ],
      ),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggle(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (ctx, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(children: [
            _buildDrawer(context),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: widget.content,
            ),
          ]);
        },
      ),
    );
  }
}
