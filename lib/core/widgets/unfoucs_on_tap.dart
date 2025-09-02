import 'package:gym_app/core/packages.dart';

class UnfocusOnTap extends StatelessWidget {
  final Widget child;

  const UnfocusOnTap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
