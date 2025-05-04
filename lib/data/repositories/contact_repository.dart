// lib/data/repositories/contact_repository.dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../../core/constants/appwrite_constants.dart';
import '../../models/contact_model.dart';

class ContactRepository {
  final Databases _db;
  ContactRepository(this._db);

  Future<List<ContactModel>> fetchContacts(String userId) async {
    final res = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdContacts,
      queries: [Query.equal('userId', userId)],
    );
    return res.documents.map((d) => ContactModel.fromJson(d.data)).toList();
  }

  Future<ContactModel> createContact(ContactModel c) async {
    final me = c.userId;
    final doc = await _db.createDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdContacts,
      documentId: ID.unique(),
      data: c.toJson(),
      permissions: [
        Permission.read(Role.user(me)),
        Permission.update(Role.user(me)),
        Permission.delete(Role.user(me)),
      ],
    );
    return ContactModel.fromJson(doc.data);
  }

  Future<ContactModel> updateContact(ContactModel c) async {
    final doc = await _db.updateDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdContacts,
      documentId: c.id,
      data: c.toJson(),
    );
    return ContactModel.fromJson(doc.data);
  }

  Future<void> deleteContact(String id) async {
    await _db.deleteDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionIdContacts,
      documentId: id,
    );
  }
}
