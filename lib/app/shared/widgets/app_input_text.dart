import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_color_scheme.dart';
import '../../styles/app_spacing.dart';
import '../../utils/constants.dart';

class AppInputText extends StatelessWidget {
  final String titleInput;
  final String hintInput;
  final TextEditingController textController;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool? isOptional;
  final Function()? onTap;
  final Widget? suffixIcon;
  final bool isDropdownOpen;
  final bool readOnly;

  const AppInputText({
    required this.titleInput,
    required this.hintInput,
    required this.textController,
    required this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization,
    this.isOptional = false,
    this.onTap,
    this.suffixIcon,
    this.isDropdownOpen = false,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: titleInput,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: AppColorScheme.bodyText,
                fontFamily: Constants.fontFamilyPoppins,
              ),
              children: [
                if (isOptional == false) ...[
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: AppColorScheme.error,
                      fontFamily: Constants.fontFamilyPoppins,
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          TextFormField(
            keyboardType: keyboardType,
            controller: textController,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintInput,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onTap: onTap,
            readOnly: readOnly,
          ),
          if (isDropdownOpen) ...[
            Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 2,
                  ),
                ),
                height: reasonVisitList.length * 60,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: reasonVisitList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        reasonVisitList[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColorScheme.bodyText,
                          fontFamily: Constants.fontFamilyPoppins,
                        ),
                      ),
                      onTap: () => onChanged(reasonVisitList[index]),
                    ),
                  ),
                ))
          ]
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<TextInputFormatter>('inputFormatters', inputFormatters));
    properties.add(ObjectFlagProperty<Function(String onChanged)>.has('onChanged', onChanged));
    properties.add(DiagnosticsProperty<TextEditingController>('textController', textController));
    properties.add(StringProperty('hintInput', hintInput));
    properties.add(StringProperty('titleInput', titleInput));
    properties.add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType));
    properties.add(EnumProperty<TextCapitalization?>('textCapitalization', textCapitalization));
    properties.add(DiagnosticsProperty<bool?>('isOptional', isOptional));
    properties.add(ObjectFlagProperty<Function()?>.has('onTap', onTap));
    properties.add(DiagnosticsProperty<bool>('isDropdownOpen', isDropdownOpen));
    properties.add(DiagnosticsProperty<bool>('readOnly', readOnly));
  }
}

final reasonVisitList = [
  'Pedido de insumos',
  'Vacinação',
  'Consulta veterinária',
];
