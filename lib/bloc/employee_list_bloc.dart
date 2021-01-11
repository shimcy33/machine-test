import 'dart:async';

import 'package:machine_test/constants/common_methods.dart';
import 'package:machine_test/models/employee_list_model.dart';
import 'package:machine_test/repository/EmployeeListRepo.dart';
import 'package:machine_test/service_manager/ApiResponse.dart';
import 'package:machine_test/utilities/login_model.dart';

class EmployeeListBloc {
  EmployeeListRepo employeeListRepo;

  List<EmployeeListModel> employeeList = List();

  EmployeeListBloc() {
    employeeListRepo = EmployeeListRepo();
  }

  Future<List<EmployeeListModel>> getAllEmployees() async {
    try {
      employeeList = await employeeListRepo.getEmployees();
      LoginModel().offlineList = employeeList;
      return employeeList;
    } catch (error) {
      throw CommonMethods().getNetworkError(error);
    }
  }
}
