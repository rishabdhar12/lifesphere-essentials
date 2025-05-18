import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';

abstract class HiveService {
  Future<void> addUser({required String uid, required String email});

  Future<void> deleteUser();

  Future<UserModel> getUser();
}
