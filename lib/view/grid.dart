import 'package:flutter/material.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({super.key});

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  static const itemCount = 8;
  List<bool> expandableState = List.generate(itemCount, (index) => false);
  Widget expandableGrid(double width, int index) {
    bool isExpanded = expandableState[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          expandableState[index] = !isExpanded;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: !isExpanded ? width * 0.4 : width * 0.8,
          height: !isExpanded ? width * 0.4 : width * 0.8,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(itemCount, (index) {
          return expandableGrid(width, index);
        }));
  }
}
