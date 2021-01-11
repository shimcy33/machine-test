import 'package:machine_test/DBProvider/DBProvider.dart';
import 'package:machine_test/models/employee_list_model.dart';
import 'package:machine_test/service_manager/ApiProvider.dart';
import 'package:machine_test/service_manager/RemoteConfig.dart';

class EmployeeListRepo {
  ApiProvider apiProvider;

  EmployeeListRepo() {
    apiProvider = new ApiProvider();
  }

  Future<List<EmployeeListModel>> getEmployees() async {
    try {
      final response = await apiProvider.getInstance().get(
          RemoteConfig.config["BASE_URL"] +
              RemoteConfig.config["GET_EMPLOYEES"]);

      // return (response.data as List).map((employee) {
      //   print('Inserting $employee');
      //   DBProvider.db.createEmployee(EmployeeListModel.fromJson(employee));
      // }).toList();

      return (response.data as List)
          .map((x) => EmployeeListModel.fromJson(x))
          .toList();
    } catch (error) {
      print("Repo error--->$error");
    }
  }
}
