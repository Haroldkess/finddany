import 'package:flutter/material.dart';

class AdminDasboard {
  String title;
  IconData icon;
  int id;

  AdminDasboard({required this.icon, required this.title, required this.id});
}

List<AdminDasboard> dashboard = [
  AdminDasboard(icon: Icons.shopping_basket, title: "Orders", id: 0),
  AdminDasboard(icon: Icons.pie_chart, title: "sales", id: 1),
  AdminDasboard(icon: Icons.people, title: "users", id: 2),
  AdminDasboard(icon: Icons.shop, title: "shops", id: 3),
  AdminDasboard(icon: Icons.power_off_outlined, title: "switch", id: 4),
  AdminDasboard(icon: Icons.shopping_bag, title: "stock", id: 5),
  AdminDasboard(icon: Icons.add, title: "add", id: 6),
  AdminDasboard(
      icon: Icons.shopping_cart_checkout_outlined, title: "fuel-order", id: 7),
  AdminDasboard(icon: Icons.calculate_outlined, title: "meter", id: 8),
];
