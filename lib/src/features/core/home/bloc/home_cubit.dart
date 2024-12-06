import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app/src/repositories/data_source/firebase_database_service.dart';

import '../../../../models/sensor.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<double> listHumi = [];
  List<double> listTemp = [];

  Future<void> getDataDHT() async {
    var dht = await FirebaseDatabaseService().getDataDHT();
    listHumi.add(dht!.humi);
    listTemp.add(dht.temp);
    print('$listHumi, $listTemp');
    emit(HomeUpdate());
  }
}
