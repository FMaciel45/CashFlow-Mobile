import 'package:cashflow/app/features/authentication/register/presentation/notifiers/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'data/datasources/register_remote_data_source.dart';
import 'data/repositories/register_repository_impl.dart';
import 'domain/repositories/register_repository.dart';
import 'domain/usecases/register_usecase.dart';
import 'presentation/notifiers/register_notifier.dart';

// Data sources (API)
final registerRemoteDataSourceProvider = Provider<RegisterRemoteDataSource>((ref) {
  return RegisterRemoteDataSourceImpl(dio: ref.read(dioProvider)); // Injeta o Dio configurado
});

// Repositories
final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  return RegisterRepositoryImpl(remoteDataSource: ref.read(registerRemoteDataSourceProvider)); // Injeta a fonte de dados
});

// Use cases
final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(repository: ref.read(registerRepositoryProvider)); // Encapsula a lógica de negócios p/ registrar usuários
});

// Notifiers
final registerNotifierProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(registerUseCase: ref.read(registerUseCaseProvider)); // Controla o estado da tela de registro (carregando, sucesso ou erro)
});

// Provider de Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'http://localhost:5291',
    headers: {
      'Content-Type': 'application/json', 
    }
  ))
  ..interceptors.add(
    LogInterceptor( // Adiciona interceptor p/ logs (debug)
      requestBody: true, // Log p/ o corpo das requisições
      responseBody: true // Loga p/ o corpo das respostas
    )
  );
});