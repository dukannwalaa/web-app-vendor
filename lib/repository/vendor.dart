
import 'package:vendor/model/vendor.dart';
import 'package:vendor/provider/firestore_db.dart';

class VendorRepository {
  Future<Vendor?> fetchVendor(String mobile) async {
    return await FireStoreDB().fetchVendor(mobile);
  }

  Future<List<Vendor>?> fetchAllVendor() async {
    return await FireStoreDB().fetchAllVendor();
  }
}