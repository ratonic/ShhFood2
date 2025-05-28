// lib/data/repositories/auth_repository.dart

import 'package:appwrite/appwrite.dart';
import 'package:panic_button/core/constants/appwrite_constants.dart';

class AuthRepository {
  final Account account;
  final Databases databases;
  final String databaseId; // Agregar el ID de tu base de datos de Appwrite

  AuthRepository(this.account, this.databases, this.databaseId);

  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    // Registra el usuario en Appwrite
    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final user = await account.get();
    return {
      'id': user.$id,
      'email': user.email,
      'name': user.name
    };
  }

  Future<void> createClientProfile({
    required String name,
    required String address,
    required String phone,
  }) async {
    final user = await account.get();
    await databases.createDocument(
      databaseId: databaseId,
      collectionId: AppwriteConstants.collectionIdUsers,
      documentId: ID.unique(),
      data: {
        'email': user.email,
        'name': name,
        'address': address,
        'phone': phone,
      },
    );
  }

  Future<void> createRestaurantProfile({
    required String name,
    required String address,
    required String phone,
    required String description,
    required String serviceHours,
    required String imageUrl,
  }) async {
    final user = await account.get();
    await databases.createDocument(
      databaseId: databaseId,
      collectionId: AppwriteConstants.collectionIdRestaurants,
      documentId: ID.unique(),
      data: {
        'email': user.email,
        'name': name,
        'address': address,
        'phone': phone,
        'description': description,
        'serviceHours': serviceHours,
        'imageUrl': imageUrl,
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await account.createEmailPasswordSession(
      email: email,
      password: password,
    );
  }

  Future<bool> isLoggedIn() async {
    try {
      await account.get();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    await account.deleteSession(sessionId: 'current');
  }

  Future<String> getCurrentUserId() async {
    final user = await account.get();
    return user.$id;
  }

  Future<Map<String, dynamic>?> getClientProfile(String email) async {
    try {
      final documents = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: AppwriteConstants.collectionIdUsers,
        queries: [Query.equal('email', email)]
      );
      
      if (documents.documents.isNotEmpty) {
        return documents.documents.first.data;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getRestaurantProfile(String email) async {
    try {
      final documents = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: AppwriteConstants.collectionIdRestaurants,
        queries: [Query.equal('email', email)]
      );
      
      if (documents.documents.isNotEmpty) {
        return documents.documents.first.data;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurants() async {
    try {
      final response = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: AppwriteConstants.collectionIdRestaurants,
      );
      return response.documents.map((doc) => doc.data).toList();
    } catch (e) {
      throw Exception('Error al obtener restaurantes: $e');
    }
  }

  updateRestaurantProfile(user, Map<String, String> map) {}
}
