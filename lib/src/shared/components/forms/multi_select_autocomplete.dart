import 'package:flutter/material.dart';

class MultiSelectAutocomplete extends StatefulWidget {
  final List<String> allItems;
  final Function(List<String>) onSelectionChanged;
  final String hintText;
  final InputDecoration? decoration;

  const MultiSelectAutocomplete({
    super.key,
    required this.allItems,
    required this.onSelectionChanged,
    this.hintText = '',
    this.decoration,
  });

  @override
  State<MultiSelectAutocomplete> createState() => _MultiSelectAutocompleteState();
}

class _MultiSelectAutocompleteState extends State<MultiSelectAutocomplete> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();

  final List<String> _selectedItems = [];
  List<String> _filteredItems = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.allItems;
      } else {
        _filteredItems = widget.allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      if (_overlayEntry != null) {
        _overlayEntry!.markNeedsBuild();
      }
    });
  }

  void _toggleItem(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
      widget.onSelectionChanged(_selectedItems);
      if (_overlayEntry != null) {
        _overlayEntry!.markNeedsBuild();
      }
    });
  }

  void _showOverlay() {
    _filteredItems = widget.allItems;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return CheckboxListTile(
                    title: Text(item),
                    value: _selectedItems.contains(item),
                    onChanged: (_) => _toggleItem(item),
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: (widget.decoration ?? const InputDecoration())
                .copyWith(
              hintText: widget.hintText,
              /*ssuffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _textController.clear();
                  _filterItems('');
                },
              ),*/
            ),
            onChanged: _filterItems,
          ),
        ),
        if (_selectedItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _selectedItems.map((item) {
                return Chip(
                  label: Text(item),
                  onDeleted: () => _toggleItem(item),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}