// Imports
import 'package:flutter/material.dart';

import '../../models/models.dart';

/// Requires email upfront.
class RequireEmailUpfront extends StatefulWidget {
  final Function setCustomer;
  final PapercupsProps props;
  final Color textColor;
  final bool showDivider;

  const RequireEmailUpfront(
    this.setCustomer,
    this.props,
    this.textColor,
    this.showDivider, {
    Key? key,
  }) : super(key: key);
  @override
  State<RequireEmailUpfront> createState() => _RequireEmailUpfrontState();
}

class _RequireEmailUpfrontState extends State<RequireEmailUpfront> {
  final c = TextEditingController();

  @override
  void initState() {
    c.addListener(() {
      setState(() {});
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
    // Email Regular Expression check.
    final hasMatch = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(c.value.text);
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 55,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: widget.showDivider
            ? Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              )
            : null,
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
                      keyboardAppearance: widget
                          .props.style.requireEmailUpfrontKeyboardAppearance,
                      decoration: widget
                              .props.style.requireEmailUpfrontInputDecoration ??
                          InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 0.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 0.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 0.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText:
                                widget.props.translations.enterEmailPlaceholder,
                            hintStyle: widget
                                .props.style.requireEmailUpfrontInputHintStyle,
                          ),
                      style:
                          widget.props.style.requireEmailUpfrontInputTextStyle,
                      onSubmitted: (val) {
                        if (hasMatch) {
                          widget.setCustomer(
                              PapercupsCustomer(
                                  createdAt: DateTime.now(), email: val),
                              rebuild: true);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  height: 36,
                  width: 36,
                  margin: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: hasMatch
                        ? () => widget.setCustomer(
                            PapercupsCustomer(
                                createdAt: DateTime.now(), email: c.value.text),
                            rebuild: true)
                        : null,
                    child: Icon(
                      Icons.navigate_next_rounded,
                      color: hasMatch
                          ? widget.props.style.primaryColor ??
                              widget.props.style.primaryGradient!.colors.first
                          : Theme.of(context).disabledColor,
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
                      hintText: widget.props.translations.newMessagePlaceholder,
                      hintStyle:
                          widget.props.style.sendMessagePlaceholderTextStyle,
                    ),
                  ),
                ),
                Container(
                  height: 36,
                  width: 36,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: null,
                    child: Icon(
                      Icons.send_rounded,
                      color: widget.textColor,
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
