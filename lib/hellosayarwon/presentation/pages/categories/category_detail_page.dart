import 'package:flutter/material.dart';

class CategoryDetailPage extends StatefulWidget {
  static const String routeName = "/CategoryDetailPage";
  const CategoryDetailPage({super.key});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Detail Page"),
      ),
      body: _mainWidget(),
    );
  }

  Widget _mainWidget(){
    return Column(
      children: [
        // headers

        // category photo

        // category title

        // category description

        // category articles

        // go to listing page button or link
      ],
    );
  }
}
