


import '../../../export.dart';

class GetInkWell extends StatelessWidget {
  final Widget child;
  final onTap;

  GetInkWell({Key? key, required this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap ?? () {},
      child: child,
    );
  }
}
