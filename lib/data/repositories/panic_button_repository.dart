import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../../core/constants/appwrite_constants.dart';
import '../../models/panic_button_model.dart';

class PanicButtonRepository {
  final Databases _databases;

  PanicButtonRepository(this._databases);

  Future<List<PanicButtonModel>> fetchButtons(String userId) async {
    final res = await _databases.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdPB,
      queries: [Query.equal('userId', userId)],
    );
    return res.documents
        .map((d) => PanicButtonModel.fromJson(d.data))
        .toList();
  }

  Future<PanicButtonModel> createButton(PanicButtonModel btn) async {
    final currentUser = btn.userId;
    final doc = await _databases.createDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdPB,
      documentId: ID.unique(),
      data: btn.toJson(),
      permissions: [
        Permission.read(Role.user(currentUser)),
        Permission.update(Role.user(currentUser)),
        Permission.delete(Role.user(currentUser)),
      ],
    );
    return PanicButtonModel.fromJson(doc.data);
  }

  Future<PanicButtonModel> updateButton(PanicButtonModel btn) async {
    final doc = await _databases.updateDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdPB,
      documentId: btn.id,
      data: btn.toJson(),
    );
    return PanicButtonModel.fromJson(doc.data);
  }

  Future<void> deleteButton(String buttonId) async {
    await _databases.deleteDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdPB,
      documentId: buttonId,
    );
  }
}
