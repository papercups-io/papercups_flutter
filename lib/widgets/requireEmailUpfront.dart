import 'package:flutter/material.dart';
import '../models/models.dart';

class RequireEmailUpfront extends StatefulWidget {
  final Function setCustomer;
  final Props props;
  final bool textBlack;
  final bool showDivider;

  RequireEmailUpfront(this.setCustomer, this.props, this.textBlack, this.showDivider);
  @override
  _RequireEmailUpfrontState createState() => _RequireEmailUpfrontState();
}

class _RequireEmailUpfrontState extends State<RequireEmailUpfront> {
  final c = TextEditingController();

  @override
  void initState() {
    c.addListener(() {
      setState(() {
        print("Rebuild");
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hasMatch = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(c.value.text);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 55,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: widget.showDivider ? Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
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
                        if (hasMatch)
                          widget.setCustomer(
                              PapercupsCustomer(
                                  createdAt: DateTime.now(), email: val),
                              rebuild: true);
                      },
                    ),
                  ),
                ),
                Container(
                  height: 36,
                  width: 36,
                  margin: EdgeInsets.only(right: 8),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: hasMatch
                        ? () => widget.setCustomer(
                            PapercupsCustomer(
                                createdAt: DateTime.now(), email: c.value.text),
                            rebuild: true)
                        : null,
                    child: Icon(
                      Icons.navigate_next_rounded,
                      color: hasMatch ? widget.props.primaryColor == null ? widget.props.primaryGradient.colors.first : widget.props.primaryColor : Theme.of(context).disabledColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
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
                    customBorder: CircleBorder(),
                    onTap: null,
                    child: Icon(
                      Icons.send_rounded,
                      color: widget.textBlack ? Colors.black : Colors.white,
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
