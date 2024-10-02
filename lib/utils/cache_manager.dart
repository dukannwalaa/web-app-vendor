import 'package:get_storage/get_storage.dart';
import 'package:vendor/model/vendor.dart';

class CacheManager {
  final getStorage = GetStorage();

  static const vendorId = 'vendorId';
  static const vendorModel = 'vendorModel';
  static const selectedVendorId = 'selectedVendor';

  writeString({required String key, required String? value}) async =>
      await getStorage.write(key, value);

  String? readString({required String key}) => getStorage.read<String>(key);

  bool hasData(String value) => getStorage.hasData(value);

  removeData(key) async => await getStorage.remove(key);

  writeVendor(Vendor user) async {
    await getStorage.write(vendorModel, user.toJson());
  }

  Vendor? readVendor() {
    var res = getStorage.read(vendorModel);
    if (res != null) {
      return Vendor.fromJson(res);
    } else {
      return null;
    }
  }
}
