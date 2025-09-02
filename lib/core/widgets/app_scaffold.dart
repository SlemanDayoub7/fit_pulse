import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/widgets/unfoucs_on_tap.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  const AppScaffold(
      {super.key, required this.body, this.drawer, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: UnfocusOnTap(child: body),
      drawer: drawer,
    );
  }
}
