import 'package:dio/dio.dart';
import 'package:visit_doctor/core/data/adapters/model/address_model.dart';

import 'home_data_source_remote.dart';

class HomeDataSourceRemoteImpl extends HomeDataSourceRemote {
  final Dio dio;

  HomeDataSourceRemoteImpl({required this.dio});

  @override
  Future<AddressModel> getAddressByCep(String cep) async {
    final response = await dio.get('$cep/json/');

    if (response.data['erro'] == 'true') {
      throw Exception('Cep inválido');
    }

    return AddressModel.fromJson(response.data);
  }
}
