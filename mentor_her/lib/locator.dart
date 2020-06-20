import 'package:get_it/get_it.dart';

import 'CRUDModel.dart';
import 'api.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('mentors'));
  locator.registerLazySingleton(() => CRUDModel()) ;
}
