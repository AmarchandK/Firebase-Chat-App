import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.iconData,
    required this.tittle,
    this.onTap,
    this.trainling,
  });
  final IconData iconData;
  final String tittle;
  final Widget? trainling;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(iconData),
        title: Text(tittle),
        trailing: trainling,
        onTap: onTap);
  }
}
