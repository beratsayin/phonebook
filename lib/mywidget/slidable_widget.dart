import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction { call, message }

class SlidableWidget<T> extends StatelessWidget {
  final Widget? child;
  final Function(SlidableAction action)? onDismissed;

  const SlidableWidget({
    @required this.child,
    @required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
    actionPane: SlidableDrawerActionPane(),
    child: child!,

    /// right side
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Call',
        color: Colors.lightBlue,
        icon: Icons.call,
        onTap: () => onDismissed!(SlidableAction.call),
      ),
      IconSlideAction(
        caption: 'Whatsapp',
        color: Colors.green,
        icon: Icons.chat,
        onTap: () => onDismissed!(SlidableAction.message),
      ),
    ],
  );
}