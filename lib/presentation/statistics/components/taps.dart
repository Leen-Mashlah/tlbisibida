import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

import 'customitem.dart';

class Taps extends StatefulWidget {
  Taps({super.key, required this.choices, required this.type});

  final List<String> choices;
  ValueNotifier<String> type;
  @override
  State<Taps> createState() => _TapsState();
}

class _TapsState extends State<Taps> {
  void setSelectedValue(String value) {
    setState(() => widget.type.value = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: InlineChoice<String>.single(
        clearable: false,
        value: widget.type.value,
        onChanged: (value) {
          widget.type.value = value!;
          print(widget.type.toString());
        },
        itemCount: widget.choices.length,
        itemBuilder: (state, i) {
          return CustomChoiceItem(
            label: widget.choices[i],
            width: 80,
            height: 80,
            selected: state.selected(widget.choices[i]),
            onSelect: state.onSelected(widget.choices[i]),
          );
        },
        listBuilder: ChoiceList.createScrollable(
          direction: Axis.vertical,
          spacing: 30,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
