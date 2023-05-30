// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class LaporanDropDownField extends FormField<String> {
  final dynamic value;
  final Widget? icon;
  final String? hintText;
  final TextStyle hintStyle;
  final String? labelText;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final bool required;
  final int? height;
  // ignore: annotate_overrides
  final bool enabled;
  final List<dynamic>? items;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<dynamic>? setter;
  final ValueChanged<dynamic>? onValueChanged;
  final bool strict;
  final int itemsVisibleInDropdown;
  TextEditingController? controller;

  LaporanDropDownField(
      {Key? key,
      this.controller,
      this.height=36,
      this.value,
      this.required = false,
      this.icon,
      this.hintText,
      this.hintStyle = const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.labelText,
      this.labelStyle = const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.inputFormatters,
      this.items,
      this.textStyle = const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14.0),
      this.setter,
      this.onValueChanged,
      this.itemsVisibleInDropdown = 2,
      this.enabled = true,
      this.strict = true})
      : super(
          key: key,
          initialValue: controller != null ? controller.text : (value ?? ''),
          onSaved: setter,
          builder: (FormFieldState<String> field) {
            final LaporanDropDownFieldState state = field as LaporanDropDownFieldState;
            final ScrollController scrollController = ScrollController();
            final InputDecoration effectiveDecoration = InputDecoration(
                border: InputBorder.none,
                filled: true,
                icon: icon,
                suffixIcon: IconButton(
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      // ignore: invalid_use_of_protected_member
                      state.setState(() {
                        state._showdropdown = !state._showdropdown;
                      });
                    }),
                hintStyle: hintStyle,
                labelStyle: labelStyle,
                hintText: hintText,
                labelText: labelText);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height:height!=null ?height.toDouble(): 36,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          // autovalidate: true,
                          controller: state._effectiveController,
                          decoration: effectiveDecoration.copyWith(
                              errorText: field.errorText),
                          style: textStyle,
                          textAlign: TextAlign.start,
                          autofocus: false,
                          obscureText: false,
                          //     maxLengthEnforced: true,
                          maxLines: 1,
                          validator: (String? newValue) {
                            if (required) {
                              if (newValue == null || newValue.isEmpty) {
                                return 'This field cannot be empty!';
                              }
                            }

                            //Items null check added since there could be an initial brief period of time
                            //when the dropdown items will not have been loaded
                            if (items != null) {
                              if (strict &&
                                  newValue!.isNotEmpty &&
                                  !items.contains(newValue)) {
                                return 'Invalid value in this field!';
                              }
                            }

                            return null;
                          },
                          onSaved: setter,
                          readOnly: !enabled,
                          inputFormatters: inputFormatters,
                        ),
                      ),
                    ),
                  ],
                ),
                !state._showdropdown
                    ? Container()
                    : Container(
                        alignment: Alignment.topCenter,
                        height:  state._getChildren(state._items!).length*
                            30, //limit to default 3 items in dropdownlist view and then remaining scrolls
                        width: MediaQuery.of(field.context).size.width,
                        child: Scrollbar(controller: scrollController,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            cacheExtent: 0.0,
                            scrollDirection: Axis.vertical,
                            controller: scrollController,
                            children: items!.isNotEmpty
                                ? ListTile.divideTiles(
                                        color: const Color.fromARGB(255, 0, 0, 0),
                                        context: field.context,
                                        tiles: state._getChildren(state._items!))
                                    .toList()
                                : [],
                          ),
                        ),
                      ),
              ],
            );
          },
        );

  @override
  LaporanDropDownFieldState createState() => LaporanDropDownFieldState();
}

class LaporanDropDownFieldState extends FormFieldState<String> {
  TextEditingController? _controller;
  bool _showdropdown = false;
  bool _isSearching = true;
  String _searchText = "";

  @override
  LaporanDropDownField get widget => super.widget as LaporanDropDownField;
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  List<String>? get _items => widget.items as List<String>?;

  void toggleDropDownVisibility() {}

  void clearValue() {
    setState(() {
      _effectiveController!.text = '';
    });
  }

  @override
  void didUpdateWidget(LaporanDropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.items!.sort();
    _isSearching = false;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }

    _effectiveController!.addListener(_handleControllerChanged);

    _searchText = _effectiveController!.text;
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text = widget.initialValue!;
    });
  }

  List<Widget> _getChildren(List<String> items) {
    List<Widget> childItems = [];
    for (var item in items) {
      if (_searchText.isNotEmpty) {
        if (item.toUpperCase().startsWith(_searchText.toUpperCase())) {
          childItems.add(_getListTile(item, items));
        }
      } else {
        childItems.add(_getListTile(item, items));
      }
    }
    _isSearching ? childItems : [];
    return childItems;
  }

  Widget _getListTile(String text, List<String> index) {
    return InkWell( hoverColor: Colors.grey.shade200,
      child: Container( padding: EdgeInsets.all(5), decoration: BoxDecoration(
    color: Colors.white,
   
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
       child: Text(
          text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),
        
        onTap: () {
          setState(() {
            _effectiveController!.text = text;
            _handleControllerChanged();
            _showdropdown = false;
            _isSearching = false;
            if (widget.onValueChanged != null) widget.onValueChanged!(text);
          });
        },
      );
    
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }

    if (_effectiveController!.text.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchText = "";
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchText = _effectiveController!.text;
        _showdropdown = true;
      });
    }
  }
}
