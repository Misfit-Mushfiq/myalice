import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myalice/controllers/apiControllers/baseApiController.dart';
import 'package:myalice/models/responseModels/customerOrder/customer_order_history.dart';
import 'package:myalice/utils/shared_pref.dart';

class CustomerProfileController extends BaseApiController {
  var _token;
  SharedPref _sharedPref = SharedPref();

  @override
  Future<void> onInit() async {
    _token = await _sharedPref.readString("apiToken");
    super.onInit();
  }

  Future<dynamic> getAttributeMap({String? customerID}) async {
    return getDio()!
        .get("crm/customers/$customerID/attributes",
            options: Options(headers: {"Authorization": "Token $_token"}))
        .then((response) async {
      if (response.statusCode == 200) {
        var meta =
            await jsonDecode(jsonEncode(response.data["dataSource"])) as Map;
        return meta;
      } else {
        return new Map();
      }
    });
  }

  Future<dynamic> editUserInfo(
      {required String customerID, required Map info}) async {
    return getDio()!
        .post("crm/customers/$customerID/attributes",
            data: info,
            options: Options(headers: {"Authorization": "Token $_token"}))
        .then((response) async {
      if (response.statusCode == 200) {
        return response.data["success"];
      } else {
        return new Map();
      }
    });
  }

  Future<dynamic> getOrderHistory({String? customerID}) async {
    return getDio()!
        .get("ecommerce/customers/$customerID/order-list",
            options: Options(headers: {"Authorization": "Token $_token"}))
        .then((response) async {
      if (response.statusCode == 200) {
        var _order = CustomerOrderHistory.fromJson(response.data);
        return _order;
      } else {
        return CustomerOrderHistory() ;
      }
    });
  }
}
