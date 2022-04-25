import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter/material.dart';

class DropButton extends StatelessWidget {
  const DropButton({Key? key, this.values, this.value, this.onChanged})
      : super(key: key);

  final List<String>? values;
  final String? value;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E7FF),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(width: 1, color: context.accentColor),
        ),
        child: DropdownButton<String>(
          iconSize: 30,
          isExpanded: true,
          value: value,
          dropdownColor: const Color(0xFFE0E7FF),
          items: values!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value),
              ),
            );
          }).toList(),
         onChanged: (val){
           //onChanged(val);

          print(val);
          },
        ).addPaddingOnly(right: 15));
  }
}
