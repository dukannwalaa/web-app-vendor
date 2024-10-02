import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vendor/common/widgets/utility.dart';
import 'package:vendor/model/vendor.dart';
import 'package:vendor/utils/utility.dart';

class FireStoreDB {
  static String vendorCollectionRef = dotenv.env['VENDOR_COLLECTION_REF'] ?? '';

  final _firebase = FirebaseFirestore.instance;


  late final CollectionReference _vendorRef;

  FireStoreDB() {
    _vendorRef = _firebase
        .collection(vendorCollectionRef)
        .withConverter<Vendor>(
            fromFirestore: (snapshots, _) => Vendor.fromJson(snapshots.data()!),
            toFirestore: (vendor, _) => vendor.toJson());
  }

  //Vendor=============================================
  Future<Vendor?> fetchVendor(String mobile) async {
    try {
      final QuerySnapshot querySnapshot =
          await _vendorRef.where('mobile', isEqualTo: mobile).get();
      var result = await FireStoreDB().getVendorById(querySnapshot.docs[0].id);
      return result;
    } catch (e) {
      kPrint('Error checking phone number: $e');
      return null; // Assume phone number doesn't exist in case of error
    }
  }

  Future<List<Vendor>?> fetchAllVendor() async {
    try {
      final QuerySnapshot querySnapshot = await _vendorRef.get();
      List<Vendor> vendors = [];
      for (var element in querySnapshot.docs) {
        Vendor vendor = element.data() as Vendor;
        //Show Only Active Vendors
        if (vendor.active == true) {
          vendors.add(element.data() as Vendor);
        }
      }
      return vendors;
    } catch (e) {
      kPrint('Error checking phone number: $e');
      return null; // Assume phone number doesn't exist in case of error
    }
  }

  Future<Vendor?> getVendorById(String docId) async {
    try {
      final QuerySnapshot querySnapshot = await _vendorRef
          .where(FieldPath.documentId, isEqualTo: docId)
          .limit(1) // Limit to one result since document IDs are unique
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Vendor;
      } else {
        showSnackBar(
            'Something went wrong with this account please contact to customer support');
        logout();
        return null; // User with the given docId doesn't exist
      }
    } catch (e) {
      return null;
    }
  }
}
