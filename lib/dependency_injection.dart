import 'package:acm_app/controller/network_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  // calls in network controller. DependencyInjection is created on main()
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
