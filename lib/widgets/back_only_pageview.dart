import 'dart:math' as math;
import 'package:flutter/material.dart';

/// PageView wrapper that:
/// - blocks forward (left) swipes,
/// - allows natural-looking backward (right) swipes (but only to the previous page),
/// - forward navigation must be done programmatically (Next button).
class BackOnlyPageView extends StatefulWidget {
  final PageController controller;
  final List<Widget> children;
  final Duration pageAnimationDuration;
  final Curve pageAnimationCurve;

  const BackOnlyPageView({
    Key? key,
    required this.controller,
    required this.children,
    this.pageAnimationDuration = const Duration(milliseconds: 300),
    this.pageAnimationCurve = Curves.decelerate,
  }) : super(key: key);

  @override
  _BackOnlyPageViewState createState() => _BackOnlyPageViewState();
}

class _BackOnlyPageViewState extends State<BackOnlyPageView> {
  late double _startDragOffset;
  late double _pageWidth;
  late int _startPage; // page at drag start
  int _currentPage = 0;

  static const double _velocityThreshold = 500.0; // px/s
  static const double _dragToChangePageFraction =
      0.33; // fraction of page width to change page

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_pageListener);
    _currentPage = widget.controller.hasClients
        ? (widget.controller.page?.round() ?? 0)
        : 0;
  }

  void _pageListener() {
    final p = widget.controller.hasClients ? widget.controller.page : null;
    if (p != null && p.round() != _currentPage) {
      setState(() => _currentPage = p.round());
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_pageListener);
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    _startDragOffset = widget.controller.offset;
    _startPage = widget.controller.hasClients
        ? (widget.controller.page?.round() ?? _currentPage)
        : _currentPage;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final dx = details.delta.dx;

    // Define the minimum offset thats allow to reveal (don't reveal more than one page)
    final minOffset =
        ((_startPage - 1) * _pageWidth).clamp(0.0, double.infinity);

    if (dx > 0) {
      // Rightward drag -> reveal previous page, but clamp to previous page only
      final target =
          (widget.controller.offset - dx).clamp(minOffset, _maxScrollExtent);
      widget.controller.jumpTo(target);
    } else {
      // Leftward drag -> resist and don't allow forward movement beyond current start page
      final resistance = dx * 0.25; // gentle resistance
      final target = (widget.controller.offset - resistance)
          .clamp(minOffset, _maxScrollExtent);
      widget.controller.jumpTo(target);
    }
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0; // positive -> right
    final movedPixels = _startDragOffset -
        widget.controller.offset; // how many px we moved right
    final movedFraction = movedPixels / (_pageWidth == 0 ? 1 : _pageWidth);

    final shouldGoBack = (velocity > _velocityThreshold) ||
        (movedFraction > _dragToChangePageFraction);

    // Decide target based on the page at drag START (so we never skip > 1 page)
    final int targetPage = (shouldGoBack && _startPage > 0)
        ? math.max(0, _startPage - 1)
        : _startPage;

    widget.controller.animateToPage(
      targetPage,
      duration: widget.pageAnimationDuration,
      curve: widget.pageAnimationCurve,
    );
  }

  double get _maxScrollExtent {
    // total width = (pages - 1) * pageWidth
    return (_pageWidth * (widget.children.length - 1))
        .clamp(0.0, double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _pageWidth = constraints.maxWidth;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: PageView(
          controller: widget.controller,
          physics: const NeverScrollableScrollPhysics(), // block native swipes
          children: widget.children,
          onPageChanged: (idx) => setState(() => _currentPage = idx),
        ),
      );
    });
  }
}
