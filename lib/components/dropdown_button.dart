import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T value;
  final ValueChanged<T> onChanged;
  final Widget Function(T) itemBuilder;
  final double? width;
  final double? height;

  const CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
    this.width,
    this.height,
    super.key,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _isOpen = !_isOpen),
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.itemBuilder(widget.value),
                Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
        if (_isOpen)
          Container(
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              children: widget.items.map((item) => InkWell(
                onTap: () {
                  widget.onChanged(item);
                  setState(() => _isOpen = false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: widget.itemBuilder(item),
                ),
              )).toList(),
            ),
          ),
      ],
    );
  }
}