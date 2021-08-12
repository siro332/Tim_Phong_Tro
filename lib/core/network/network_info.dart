import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConneted;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConneted => internetConnectionChecker.hasConnection;
}
