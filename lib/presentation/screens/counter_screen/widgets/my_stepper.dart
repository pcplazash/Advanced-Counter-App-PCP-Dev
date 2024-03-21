import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/counter_cubit/counter_cubit.dart';

class MyStepper extends StatefulWidget {
  MyStepper({
    Key? key,
    required this.initialValue,
    @Deprecated('use minValue:0 instead') this.withNaturalNumbers = false,
    this.withBackground = true,
    required this.onChanged,
    this.direction = Axis.horizontal,
    this.withSpring = true,
    this.counterTextColor = Colors.white,
    this.dragButtonColor = const Color(0xFF9874f8),
    this.iconsColor = Colors.white,
    this.withPlusMinus = false,
    this.firstIncrementDuration = const Duration(milliseconds: 250),
    this.secondIncrementDuration = const Duration(milliseconds: 100),
    this.speedTransitionLimitCount = 3,
    this.maxValue = 150,
    this.minValue = -150,
    this.withFastCount = false,
    required this.stepperValue,
  }) : super(key: key);
  final Axis direction;

  final int initialValue;
  final bool withNaturalNumbers;
  final bool withBackground;
  int stepperValue;

  final Duration firstIncrementDuration;
  final Duration secondIncrementDuration;
  final int speedTransitionLimitCount;

  final ValueChanged<int> onChanged;

  final bool withSpring;
  final bool withPlusMinus;
  final bool withFastCount;
  final int maxValue;
  int minValue;

  final Color counterTextColor;
  final Color dragButtonColor;
  final Color iconsColor;

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late int _value;
  double _startAnimationPosX = 0.0;
  double _startAnimationPosY = 0.0;
  bool isTimerEnable = true;
  bool isReadyToFastAnim = true;

  @override
  void initState() {
    super.initState();

    _value = widget.initialValue;

    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
    //print("widget.stepperValue ${widget.stepperValue}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) => FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: widget.direction == Axis.horizontal ? 210.0 : 90.0,
            height: widget.direction == Axis.horizontal ? 90.0 : 210.0,
            child: Material(
              type: MaterialType.canvas,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(60.0),
              color: widget.withBackground == true
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: widget.direction == Axis.horizontal ? 10.0 : null,
                      bottom: widget.direction == Axis.horizontal ? null : 10.0,
                      child: widget.direction == Axis.horizontal
                          ? Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_left
                                  : Icons.remove,
                              size: 40.0,
                              color: widget.iconsColor)
                          : Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_down
                                  : Icons.remove,
                              size: 40.0,
                              color: widget.iconsColor),
                    ),
                    Positioned(
                      right: widget.direction == Axis.horizontal ? 10.0 : null,
                      top: widget.direction == Axis.horizontal ? null : 10.0,
                      child: widget.direction == Axis.horizontal
                          ? Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_right
                                  : Icons.add,
                              size: 40.0,
                              color: widget.iconsColor)
                          : Icon(
                              widget.withPlusMinus == false
                                  ? Icons.keyboard_arrow_up
                                  : Icons.add,
                              size: 40.0,
                              color: widget.iconsColor),
                    ),
                    GestureDetector(
                      onHorizontalDragStart: _onPanStart,
                      onHorizontalDragUpdate: _onPanUpdate,
                      onHorizontalDragEnd: _onPanEnd,
                      child: SlideTransition(
                        position: _animation,
                        child: Material(
                          color: Color(0xff85C9FF),
                          shape: const CircleBorder(),
                          elevation: 5.0,
                          child: Center(
                            child: Image.asset(
                              'assets/dash_flutter.svg',
                              fit: BoxFit.fill,
                            ),
                            // child: Text(
                            //   '${widget.stepperValue}',
                            //   key: ValueKey<int>(widget.stepperValue),
                            //   style: TextStyle(
                            //       color: widget.counterTextColor, fontSize: 36.0),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;
    _startAnimationPosY = ((local.dy * 0.75) / box.size.height) - 0.4;
    //print(_controller.value);
    if (widget.direction == Axis.horizontal) {
      return ((local.dx * 0.75) / box.size.width) - 0.4;
    } else {
      return ((local.dy * 0.75) / box.size.height) - 0.4;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double value = offsetFromGlobalPos(details.globalPosition);
    isReadyToFastAnim = true;
    if (value <= -0.1923) {
      _controller.value = -0.1923;
      _startAnimationPosX = -0.1923;
      _startAnimationPosY = -0.1923;
      if (widget.withFastCount) fastCount();
    } else if (value >= 0.1923) {
      _controller.value = 0.1923;
      _startAnimationPosX = 0.1923;
      _startAnimationPosY = 0.1923;
      if (widget.withFastCount) fastCount();
    } else {
      isReadyToFastAnim = false;
      _controller.value = offsetFromGlobalPos(details.globalPosition);
    }
  }

  fastCount() {
    if (isTimerEnable) {
      isTimerEnable = false;
      bool isHor = widget.direction == Axis.horizontal;
      Timer(Duration(milliseconds: 100), () {
        if (isReadyToFastAnim) {
          int velocitLimit = 0;
          Timer.periodic(widget.firstIncrementDuration, (timer) {
            if (isReadyToFastAnim == false) {
              timer.cancel();
              isReadyToFastAnim = true;
            }
            if (velocitLimit > widget.speedTransitionLimitCount) {
              timer.cancel();
            }
            velocitLimit++;
            if (_controller.value <= -0.1923) {
              setState(() => isHor
                  ? widget.stepperValue > widget.minValue
                      ? widget.stepperValue--
                      : widget.stepperValue
                  : widget.stepperValue < widget.maxValue
                      ? widget.stepperValue++
                      : widget.stepperValue);
            } else if (_controller.value >= 0.1923) {
              setState(() => isHor
                  ? widget.stepperValue < widget.maxValue
                      ? widget.stepperValue++
                      : widget.stepperValue
                  : widget.stepperValue > widget.minValue
                      ? widget.stepperValue--
                      : widget.stepperValue);
            }
          });
          Timer.periodic(widget.secondIncrementDuration, (timer) {
            if (isReadyToFastAnim == false) {
              timer.cancel();
              isReadyToFastAnim = true;
            }
            if (velocitLimit > widget.speedTransitionLimitCount) {
              if (_controller.value <= -0.1923) {
                setState(() => isHor
                    ? widget.stepperValue > widget.minValue
                        ? widget.stepperValue--
                        : widget.stepperValue
                    : widget.stepperValue < widget.maxValue
                        ? widget.stepperValue++
                        : widget.stepperValue);
              } else if (_controller.value >= 0.1923) {
                setState(() => isHor
                    ? widget.stepperValue < widget.maxValue
                        ? widget.stepperValue++
                        : widget.stepperValue
                    : widget.stepperValue > widget.minValue
                        ? widget.stepperValue--
                        : widget.stepperValue);
              }
            }
          });
        }
      });
    }

    /*if(isfastCount == true){
      bool isHor = widget.direction == Axis.horizontal;
      bool changed = false;
      Future.
      setState(() => isHor ? widget.stepperValue-- : widget.stepperValue++);
      changed = true;
      }
    }*/
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.stop();
    isReadyToFastAnim = false;
    isTimerEnable = true;
    bool isHor = widget.direction == Axis.horizontal;
    bool isChanged = false;
    if (_controller.value <= -0.1923) {
      _controller.value = -0.1923;
      // setState(() => isHor ? widget.stepperValue>widget.minValue?widget.stepperValue--:widget.stepperValue : widget.stepperValue<widget.maxValue?widget.stepperValue++:widget.stepperValue);

      isChanged = true;
      context.read<CounterCubit>().decrementCounter();
    } else if (_controller.value >= 0.1923) {
      _controller.value = 0.1923;
      //  setState(() => isHor ? widget.stepperValue<widget.maxValue?widget.stepperValue++:widget.stepperValue : widget.stepperValue>widget.minValue?widget.stepperValue--:widget.stepperValue);
      context.read<CounterCubit>().incrementCounter();
      isChanged = true;
    }
    if (widget.withSpring) {
      final SpringDescription _kDefaultSpring =
          new SpringDescription.withDampingRatio(
        mass: 0.9,
        stiffness: 250.0,
        ratio: 0.6,
      );
      if (widget.direction == Axis.horizontal) {
        _controller.animateWith(
            SpringSimulation(_kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
      } else {
        _controller.animateWith(
            SpringSimulation(_kDefaultSpring, _startAnimationPosY, 0.0, 0.0));
      }
    } else {
      _controller.animateTo(0.0,
          curve: Curves.bounceOut, duration: Duration(milliseconds: 500));
    }

    if (isChanged && widget.onChanged != null) {
      widget.onChanged(widget.stepperValue);
    }
  }
}
