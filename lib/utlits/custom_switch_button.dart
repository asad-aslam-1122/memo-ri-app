import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color color;

  CustomSwitchButton(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.color})
      : super(key: key);

  @override
  _CustomSwitchButtonState createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;
  bool isFirstCircleVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        widget.onChanged(!widget.value);
        setState(() {
          isFirstCircleVisible = !isFirstCircleVisible;
        });
      },
      child: SizedBox(
        width: 43,
        height: 25,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: 43,
                height: 22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                        widget.value ? widget.color : R.appColors.borderColor)),
            Align(
              alignment: _circleAnimation.value,
              child: Container(
                  alignment: widget.value
                      ? ((Directionality.of(context) == TextDirection.rtl)
                          ? Alignment.centerLeft
                          : Alignment.centerRight)
                      : ((Directionality.of(context) == TextDirection.rtl)
                          ? Alignment.centerRight
                          : Alignment.centerLeft),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
                    decoration: BoxDecoration(
                      color: R.appColors.white,
                      shape: BoxShape.circle,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
