import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_input_text.dart';
import '../../../styles/app_color_scheme.dart';
import '../../../utils/constants.dart';
import '../pages/create_visit/create_visit_controller.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<CustomDatePicker> createState() => _CreateVisitPageState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('restorationId', restorationId));
  }
}

class _CreateVisitPageState extends State<CustomDatePicker> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (navigator, arguments) => navigator.restorablePush(
      _datePickerRoute,
      arguments: _selectedDate.value.millisecondsSinceEpoch,
    ),
  );

  final controller = Get.find<CreateVisitController>();

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) =>
      DialogRoute<DateTime>(
        context: context,
        builder: (context) => Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColorScheme.background,
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(AppColorScheme.appBarColor),
                textStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: AppColorScheme.appBarColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: Constants.fontFamilyPoppins,
                  ),
                ),
              ),
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(AppColorScheme.appBarColor),
                textStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: AppColorScheme.appBarColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: Constants.fontFamilyPoppins,
                  ),
                ),
              ),
            ),
          ),
          child: DatePickerDialog(
            restorationId: 'date_picker_dialog',
            firstDate: DateTime.now().subtract(const Duration(days: 180)),
            lastDate: DateTime.now(),
            initialDate: DateTime.now(),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            confirmText: 'Confirmar',
          ),
        ),
      );

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    final controller = Get.find<CreateVisitController>();
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        final dateVisit =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
        controller.onChangedDateVisit(dateVisit);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Obx(
        () => AppInputText(
          titleInput: 'Data da visita',
          hintInput: 'Insira a data da visita',
          textController: controller.dateVisitTextController.value,
          onChanged: (_) {},
          readOnly: true,
          onTap: () => _restorableDatePickerRouteFuture.present(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _restorableDatePickerRouteFuture.present(),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CreateVisitController>('controller', controller));
  }
}
