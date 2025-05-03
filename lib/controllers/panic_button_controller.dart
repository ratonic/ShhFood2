import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import '../data/repositories/panic_button_repository.dart';
import '../models/panic_button_model.dart';

class PanicButtonController extends GetxController {
  final PanicButtonRepository _repo;
  final Account _account;

  PanicButtonController({
    required PanicButtonRepository repo,
    required Account account,
  })  : _repo = repo,
        _account = account;

  var buttons   = <PanicButtonModel>[].obs;
  var isLoading = false.obs;
  var error     = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadButtons();
  }

  Future<void> loadButtons() async {
    isLoading.value = true;
    try {
      final me = await _account.get();
      buttons.value = await _repo.fetchButtons(me.$id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addButton(PanicButtonModel btn) async {
    isLoading.value = true;
    try {
      final me      = await _account.get();
      final toSave  = btn.copyWith(userId: me.$id);
      final newBtn  = await _repo.createButton(toSave);
      buttons.add(newBtn);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateButton(PanicButtonModel btn) async {
    isLoading.value = true;
    try {
      final updated = await _repo.updateButton(btn);
      final idx     = buttons.indexWhere((b) => b.id == updated.id);
      if (idx != -1) buttons[idx] = updated;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteButton(String id) async {
    try {
      await _repo.deleteButton(id);
      buttons.removeWhere((b) => b.id == id);
    } catch (e) {
      error.value = e.toString();
    }
  }
}
