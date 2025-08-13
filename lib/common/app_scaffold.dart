import 'package:nudge/core/extension/extensions.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.backgroundColor,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButtonLocation,
    this.endDrawer,
    this.extendBody = false, // Added parameter with default false
  });

  const AppScaffold.white({
    required this.body,
    super.key,
    this.appBar,
    this.backgroundColor = AppColors.colorWhite,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButtonLocation,
    this.endDrawer,
    this.extendBody = false, // Added parameter with default false
  });

  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? endDrawer;
  final bool extendBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      key: key,
      drawer: drawer,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBody: extendBody, // use the passed value here
    );
  }
}
