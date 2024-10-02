
import 'package:get/get.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/model/vendor.dart';
import 'package:vendor/provider/firestore_db.dart';
import 'package:vendor/utils/cache_manager.dart';
import 'package:vendor/utils/utility.dart';

class AccountController extends GetxController {
  var fireStoreDB = FireStoreDB();
  Vendor? vendor;
  var vendorId = '';

  @override
  void onInit() async {
    super.onInit();
    vendorId = CacheManager().readString(key: CacheManager.vendorId) ?? '';
    vendor = await FireStoreDB().getVendorById(vendorId);
    if (vendor == null) {
      showSnackBar(
          'Something went wrong with this account please contact to customer support');
      logout();
    }
    update();
  }
}
