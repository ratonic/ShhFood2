// lib/controllers/auth_controller.dart

import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

import '../data/repositories/auth_repository.dart';
import '../presentation/pages/splash_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/home_page.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  AuthController(this._authRepository);

  Future<bool> checkAuth() async {
    isLoading.value = true;
    try {
      return await _authRepository.isLoggedIn();
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _authRepository.login(email: email, password: password);
      Get.offAll(() => HomePage());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password, String name) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _authRepository.createAccount(
        email: email, password: password, name: name);
      await login(email, password); // inmediatamente hace login
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAll(() => LoginPage());
  }
}
