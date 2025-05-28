import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panic_button/presentation/pages/client_home_page.dart';
import 'package:panic_button/presentation/pages/home_page.dart';
import 'package:panic_button/presentation/pages/restaurant_home_page.dart';
import 'package:panic_button/presentation/pages/login_page.dart';

import '../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString userType = ''.obs;

  final storage = GetStorage();

  AuthController(this._authRepository) {
    // Leer el tipo de usuario almacenado al iniciar
    userType.value = storage.read('userType') ?? '';

    // Guardar automáticamente el userType cuando cambie
    ever(userType, (String value) {
      storage.write('userType', value);
    });
  }

  Future<bool> checkAuth() async {
    isLoading.value = true;
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        if (userType.value == 'client') {
          Get.offAll(() => ClientHomePage());
        } else if (userType.value == 'restaurant') {
          Get.offAll(() => RestaurantHomePage());
        } else {
          Get.offAll(() => HomePage());
        }
      } else {
        Get.offAll(() => LoginPage());
      }

      return isLoggedIn;
    } catch (e) {
      error.value = e.toString();
      Get.offAll(() => LoginPage());
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
      
      // Obtener el usuario actual
      final user = await _authRepository.getCurrentUser();
      
      // Verificar si existe en la colección de clientes
      try {
        final clientDoc = await _authRepository.getClientProfile(user['email']);
        if (clientDoc != null) {
          userType.value = 'client';
          Get.offAll(() => ClientHomePage());
          return;
        }
      } catch (_) {}
      
      // Verificar si existe en la colección de restaurantes
      try {
        final restaurantDoc = await _authRepository.getRestaurantProfile(user['email']);
        if (restaurantDoc != null) {
          userType.value = 'restaurant';
          Get.offAll(() => RestaurantHomePage());
          return;
        }
      } catch (_) {}
      
      // Si no existe en ninguna colección, mostrar la página de selección
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
      await login(email, password);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    userType.value = '';
    storage.remove('userType');
    Get.offAll(() => LoginPage());
  }

  Future<void> registerClient({
    required String name,
    required String address,
    required String phone,
  }) async {
    isLoading.value = true;
    error.value = '';
    try {
      if (name.isEmpty || address.isEmpty || phone.isEmpty) {
        throw Exception('Todos los campos son requeridos');
      }

      await _authRepository.createClientProfile(
        name: name,
        address: address,
        phone: phone,
      );
      userType.value = 'client';
      Get.offAll(() => ClientHomePage());
    } catch (e) {
      error.value = 'Error al crear el perfil: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerRestaurant({
    required String name,
    required String address,
    required String phone,
    required String description,
    required String serviceHours,
    required String imageUrl,
  }) async {
    isLoading.value = true;
    error.value = '';
    try {
      if (name.isEmpty || address.isEmpty || phone.isEmpty ||
          description.isEmpty || serviceHours.isEmpty) {
        throw Exception('Todos los campos son requeridos excepto la URL de la imagen');
      }

      await _authRepository.createRestaurantProfile(
        name: name,
        address: address,
        phone: phone,
        description: description,
        serviceHours: serviceHours,
        imageUrl: imageUrl,
      );
      userType.value = 'restaurant';
      Get.offAll(() => RestaurantHomePage());
    } catch (e) {
      error.value = 'Error al crear el perfil: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Agregar este getter
  AuthRepository get authRepository => _authRepository;
}
