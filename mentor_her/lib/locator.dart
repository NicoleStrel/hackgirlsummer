import 'package:get_it/get_it.dart';

import 'models/CRUDModel.dart';
import 'api.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => CRUDModel()) ;
}
