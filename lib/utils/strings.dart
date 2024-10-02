class Strings {
  String appName = 'DukanWalaa';

  get welcome => 'Welcome';

  get enterNumber => 'Enter your number';

  get searchHint => 'Search Groceries';

  get enterOtp => 'Enter Otp';

  get changeNumber => 'Change Number';

  get loginOrSignup => 'Login/Signup';

  get customer => 'Customer';

  get vendor => 'Vendor';

  String otpSentDes(number) => 'An Otp is sent on +91 $number';

  String somethingWentWrongPlTryAgain =
      'Something went wrong, Please try again later.';

  //Order
  String orderPlacedDescription(customerName, orderId) =>
      "Woohoo! $customerName, your order ($orderId) has been placed successfully! 🎉 We're just waiting for the seller to give us the thumbs up, and then your goodies will be on their way. We'll keep you updated on the status of your order.";

  get orderAwaitingConfirmationTitle => 'Awaiting Confirmation From Seller';

  String orderAwaitingConfirmationDescription(customerName, orderId) =>
      "Woohoo! $customerName, your order ($orderId) has been placed successfully! 🎉 We're just waiting for the seller to give us the thumbs up, and then your goodies will be on their way. We'll keep you updated on the status of your order.";

  var orderProcessTitle = 'Login/Signup';
  var orderProcessDescription = 'Login/Signup';

  //Order Status
  get orderActive => 'Active';

  get orderAwaitingConfirmation => 'Awaiting Confirmation';

  get orderPending => 'Pending';

  get orderInProcess => 'In Process';

  get orderOutForDelivery => 'Out For Delivery';

  get orderCompleted => 'Complete';

  get orderAccept => 'Accept';

  get orderReject => 'Reject';

  get orderCancelled => 'Cancelled';

  get orderDelayed => 'Delayed';

  get orderPacked => 'Packed';

  get custom => 'Custom';

  get success => 'Success';

  get newOrder => 'New Orders';

  get inProcessOrder => 'In Process Orders';

  get completedOrder => 'Completed Orders';

  get otherOrder => 'Other Orders';

  //Exception Messages
String noInternetConnection = 'Could not load data. Please check your internet connection.';
String requestTimeOut = 'Request timed out. Please try again';
}
