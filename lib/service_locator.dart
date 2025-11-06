import 'package:dio/dio.dart';
import 'package:geovaz_app/data/repositories/geo_vaz_impl.dart';
import 'package:geovaz_app/data/service/geo_vaz_service.dart';
import 'package:geovaz_app/domain/repositories/geo_vaz_repository.dart';
import 'package:geovaz_app/geo_vaz_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  //Services
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<GeoVazClient>(GeoVazClient());
  sl.registerSingleton<GeoVazService>(GeoVazService());

  //Repositorys
  sl.registerSingleton<GeoVazRepository>(GeoVazImpl());
}
