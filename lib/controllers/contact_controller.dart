// lib/controllers/contact_controller.dart
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import '../data/repositories/contact_repository.dart';
import '../models/contact_model.dart';

class ContactController extends GetxController {
  final ContactRepository _repo;
  final Account _account;

  ContactController({ required ContactRepository repo, required Account account })
    : _repo = repo, _account = account;

  var contacts  = <ContactModel>[].obs;
  var isLoading = false.obs;
  var error     = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  Future<void> loadContacts() async {
    isLoading.value = true;
    try {
      final me = await _account.get();
      contacts.value = await _repo.fetchContacts(me.$id);
    } catch (e) {
      error.value = e.toString();
    } finally { isLoading.value = false; }
  }

  Future<void> addContact(ContactModel c) async {
    isLoading.value = true;
    try {
      final me = await _account.get();
      final toSave = c.copyWith(userId: me.$id);
      final added = await _repo.createContact(toSave);
      contacts.add(added);
    } catch (e) {
      error.value = e.toString();
    } finally { isLoading.value = false; }
  }

  Future<void> updateContact(ContactModel c) async {
    isLoading.value = true;
    try {
      final updated = await _repo.updateContact(c);
      final idx = contacts.indexWhere((x) => x.id == updated.id);
      if (idx != -1) contacts[idx] = updated;
    } catch (e) {
      error.value = e.toString();
    } finally { isLoading.value = false; }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _repo.deleteContact(id);
      contacts.removeWhere((x) => x.id == id);
    } catch (e) {
      error.value = e.toString();
    }
  }
}
