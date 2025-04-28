import 'package:appwrite/appwrite.dart';
import '../constants/appwrite_constants.dart';

class AppwriteConfig {
  static Client initClient() {
    return Client()
      .setEndpoint(AppwriteConstants.endpoint)
      .setProject(AppwriteConstants.projectId);
  }
}
