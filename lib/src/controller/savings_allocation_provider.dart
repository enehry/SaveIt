import 'package:flutter/material.dart';
import 'package:save_it/src/components/app_snack_bar.dart';
import 'package:save_it/src/pages/layout/transparent_app_bar.dart';
import 'package:save_it/src/utils/constant.dart';

class SavingsAllocationProvider with ChangeNotifier {
  Map _selectedAllocation = kAllocationModes[0];

  Map get selectedAllocation => _selectedAllocation;

  set selectedAllocation(Map value) {
    _selectedAllocation = value;
    _needs = _monthlyIncome * (convertToDouble(value['needs']) / 100);
    _wants = _monthlyIncome * (convertToDouble(value['wants']) / 100);
    _savings = _monthlyIncome * (convertToDouble(value['savings']) / 100);
    _others = _monthlyIncome * (convertToDouble(value['others']) / 100);
    _needsPercentage = convertToDouble(value['needs']);
    _wantsPercentage = convertToDouble(value['wants']);
    _savingsPercentage = convertToDouble(value['savings']);
    _othersPercentage = convertToDouble(value['others']);
    notifyListeners();
  }

  // default values of categories
  double _monthlyIncome = 0.0;
  double _needs = 0.0;
  double _wants = 0.0;
  double _savings = 0.0;
  double _others = 0.0;

  // default percentage of categories
  double _needsPercentage = 0.0;
  double _wantsPercentage = 0.0;
  double _savingsPercentage = 0.0;
  double _othersPercentage = 0.0;

  // value of categories
  double get monthlyIncome => _monthlyIncome;
  double get needs => _needs;
  double get wants => _wants;
  double get savings => _savings;
  double get others => _others;

  double get totality => _needs + _wants + _savings + _others;
  double get totalPercentage =>
      _needsPercentage +
      _wantsPercentage +
      _savingsPercentage +
      _othersPercentage;

  // percentage of categories
  double get needsPercentage => _needsPercentage;
  double get wantsPercentage => _wantsPercentage;
  double get savingsPercentage => _savingsPercentage;
  double get othersPercentage => _othersPercentage;

  void setMonthlyIncome(String? value) {
    _monthlyIncome = convertToDouble(value);
    // recalculate percentages of categories
    _needs = _monthlyIncome * _needsPercentage / 100;
    _wants = _monthlyIncome * _wantsPercentage / 100;
    _savings = _monthlyIncome * _savingsPercentage / 100;
    _others = _monthlyIncome * _othersPercentage / 100;

    notifyListeners();
  }

  // ** PERCENTAGES  SETTER ** //
  void setNeedsPercentage(String? value) {
    // check if the total percentage is greater than 100
    _needsPercentage = convertToDouble(value);
    if (totalPercentage > 100) {
      AppSnackBar(
        message: 'Total percentage should be less than or equal 100',
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Colors.red,
        ),
      ).showSnackBar();
    } else {
      _needs = _monthlyIncome * _needsPercentage / 100;
      notifyListeners();
    }
  }

  void setSavingsPercentage(String? value) {
    _savingsPercentage = convertToDouble(value);
    if (totalPercentage > 100) {
      showSnackBar();
    } else {
      _savings = _monthlyIncome * _savingsPercentage / 100;
      notifyListeners();
    }
  }

  void setWantsPercentage(String? value) {
    _wantsPercentage = convertToDouble(value);
    if (totalPercentage > 100) {
      if (globalScaffoldKey.currentContext != null) {
        showSnackBar();
      }
    } else {
      _wants = _monthlyIncome * _wantsPercentage / 100;
      notifyListeners();
    }
  }

  void setOthersPercentage(String? value) {
    _othersPercentage = convertToDouble(value);
    if (totalPercentage > 100) {
      showSnackBar();
    } else {
      _others = _monthlyIncome * _othersPercentage / 100;
      notifyListeners();
    }
  }

  // ** Percentage VALIDATOR
  String? needsPercentageValidator(String? value) {
    if (totalPercentage > 100) {
      return '';
    }
    return null;
  }

  String? wantsPercentageValidator(String? value) {
    if (totalPercentage > 100) {
      return '';
    }
    return null;
  }

  String? savingsPercentageValidator(String? value) {
    if (totalPercentage > 100) {
      return '';
    }
    return null;
  }

  String? othersPercentageValidator(String? value) {
    if (totalPercentage > 100) {
      return '';
    }
    return null;
  }

  // validator for the fields
  // check if the value get can be subtract from the monthly income
  // if the value is less than the monthly income, then return null
  // if the value is greater than the monthly income, then return error message
  String? validateInput(String label) {
    // validate the input if is can be subtract from the monthly income
    if (totality > _monthlyIncome) {
      return '$label cannot be greater than monthly income';
    }
    return null;
  }

  double convertToDouble(String? value) {
    if (value != null && value.isNotEmpty) {
      // remove the comma from the value
      return double.parse(value.replaceAll(',', ''));
    }

    return 0.0;
  }

  void showSnackBar() {
    if (globalScaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(globalScaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[400],
          content: const Text(
            'Total percentage is greater than 100',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
