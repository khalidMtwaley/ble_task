import 'package:flutter/material.dart';

class CustomSearchFieldWidget extends StatefulWidget {
  const CustomSearchFieldWidget({super.key, this.hintText, this.onChanged});

  final String? hintText;
  final ValueChanged<String>? onChanged;

  @override
  _CustomSearchFieldState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchFieldWidget> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });

    searchController.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(searchController.text);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.transparent, // Border is always transparent
            ),
          ),
          child: TextField(
            controller: searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0, // Reduced vertical padding
              ),
              prefixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, end: 5), // Reduced padding for prefix
                child: const Icon(Icons.search, size: 20),
              ),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  searchController.clear();
                  setState(() {});
                },
              )
                  : null,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              isDense: true, // Ensures a more compact layout
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
