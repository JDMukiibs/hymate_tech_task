import 'package:reactive_forms/reactive_forms.dart';

class RequiredAtleastOneValidator extends Validator<dynamic> {
  const RequiredAtleastOneValidator(): super();

  @override
  Map<String, Object>? validate(AbstractControl<dynamic> control) {
    if (control is! FormGroup) return null;

    final formGroup = control;
    final datapointsArray = formGroup.control('selectedDatapoints') as FormArray?;
    final categoriesArray = formGroup.control('selectedCategories') as FormArray?;

    final hasDatapoints = datapointsArray?.value?.isNotEmpty ?? false;
    final hasCategories = categoriesArray?.value?.isNotEmpty ?? false;

    if (!hasDatapoints && !hasCategories) {
      return {'atLeastOneRequired': true};
    }
    return null;
  }
}
