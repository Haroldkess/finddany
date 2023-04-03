
import 'package:flutter/material.dart';

import '../../widgets/empty_state.dart';


class NoFavorites extends StatelessWidget {
  const NoFavorites({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color:  Color(0xff5956E9)),
        ),
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Color(0xff5956E9),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: EmptyState(
        path: 'assets/images/no_favorites.png',
        title: 'No orders yet',
        description: 'Hit the blue button down below to Create an order',
        textButton: 'Start ordering',
        onClick: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
