import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/constants/hive_constants.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/models/user_model.dart';
import 'package:lifesphere_essentials/service/hive_service/hive_service.dart';

@Injectable(as: HiveService)
class HiveServiceImpl extends HiveService {
  @override
  Future<void> addUser({required String uid, required String email}) {
    return Hive.box(
      HiveConstants.userBox,
    ).put('user', {'uid': uid, 'email': email});
  }

  @override
  Future<void> deleteUser() {
    return Hive.box(HiveConstants.userBox).clear();
  }

  @override
  Future<UserModel> getUser() async {
    return Hive.box(HiveConstants.userBox).get('user') != null
        ? UserModel.fromJson(Hive.box(HiveConstants.userBox).get('user'))
        : throw Exception('User not found');
  }
}
