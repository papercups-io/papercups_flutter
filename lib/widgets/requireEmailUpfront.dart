import 'package:flutter/material.dart';
import '../models/models.dart';

class RequireEmailUpfront extends StatefulWidget {
  final Function setCustomer;
  final Props props;

  RequireEmailUpfront(this.setCustomer, this.props);
  @override
  _RequireEmailUpfrontState createState() => _RequireEmailUpfrontState();
}

class _RequireEmailUpfrontState extends State<RequireEmailUpfront> {
  final c = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    c.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 55,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextField(
                controller: c,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 0.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 0.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 0.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: widget.props.enterEmailPlaceholer,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                onSubmitted: (val) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                      .hasMatch(val))
                    widget.setCustomer(
                        PapercupsCustomer(
                            createdAt: DateTime.now(), email: val),
                        rebuild: true);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      enabled: false,
                      border: InputBorder.none,
                      hintText: widget.props.newMessagePlaceholder,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 36,
                  width: 36,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: null,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
