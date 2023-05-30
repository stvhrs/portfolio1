import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
extension DateTimeExtension on DateTime? {
  String parseToString(String dateFormat) {
    if (this == null) return '';
    return DateFormat(dateFormat).format(this!);
  }
}



extension StringExtension on String {
  DateTime parseToDateTime(String dateFormat) {
    if (length > dateFormat.length) return DateTime.now();
    try {
      return DateFormat(dateFormat).parse(this);
    } on FormatException catch (_) {
      return DateTime.now();
    }
  }
}

/// Class [Picker] help display date picker on web
class Picker extends StatefulWidget {
  const Picker({
    Key? key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onChange,
    this.style,required this.fd,
    this.width = 200,
    this.height = 36,
    this.prefix,
    this.dateformat = 'yyyy/MM/dd',
  }) : super(key: key);

  /// The initial date first
  final DateTime? initialDate;
final FocusNode fd;
  /// The earliest date the user is permitted to pick or input.
  final DateTime? firstDate;

  /// The latest date the user is permitted to pick or input.
  final DateTime? lastDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime?> onChange;

  /// The text style of date form field
  final TextStyle? style;

  /// The width and height of date form field
  final double width;
  final double height;

  /// The prefix of date form field
  final Widget? prefix;

  /// The date format will be displayed in date form field
  final String dateformat;

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  late final FocusNode _focusNode ;

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  final _controller = TextEditingController();

  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  bool _isEnterDateField = false;

  @override
  void initState() {
    super.initState();
_focusNode=widget.fd;
    _selectedDate = widget.initialDate;
    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2100);

    if (_selectedDate != null) {
      _controller.text = _selectedDate?.parseToString(widget.dateformat) ?? '';
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry);
      } else {
        _controller.text = _selectedDate.parseToString(widget.dateformat);
        widget.onChange.call(_selectedDate);
        _overlayEntry.remove();
      }
    });
  }

  void onChange(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    _controller.text = _selectedDate.parseToString(widget.dateformat);

    _focusNode.unfocus();
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox!.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 5,
            child: SizedBox(
              height: 250,
              child: CalendarDatePicker(
                firstDate: _firstDate,
                lastDate: _lastDate,
                initialDate: _selectedDate ?? DateTime.now(),
                onDateChanged: onChange,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isEnterDateField = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isEnterDateField = false;
          });
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(keyboardType: TextInputType.none,
            focusNode: _focusNode,
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: const OutlineInputBorder(),
              suffixIcon: _buildPrefixIcon(),
            ),
            onChanged: (dateString) {
              final date = dateString.parseToDateTime(widget.dateformat);
              if (date.isBefore(_firstDate)) {
                _selectedDate = _firstDate;
              } else if (date.isAfter(_lastDate)) {
                _selectedDate = _lastDate;
              } else {
                _selectedDate = date;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    if (_controller.text.isNotEmpty && _isEnterDateField) {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _controller.clear();
          _selectedDate = null;
        },
        splashRadius: 16,
      );
    } else {
      return widget.prefix ?? const Icon(Icons.date_range);
    }
  }
}
