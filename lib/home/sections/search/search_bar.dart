import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function()? onTap;
  final TextEditingController? controller;
  const SearchBar({this.onTap, this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search...',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.white, width: 3.0)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          isDense: true),
      style: const TextStyle(fontSize: 15),
      onTap: onTap,
      readOnly: onTap != null,
      autofocus: controller != null,
    );
  }
}
