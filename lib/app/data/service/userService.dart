import 'package:users/app/data/models/user.dart';
import 'package:users/app/data/provider/userApi.dart';

class UserService {
  final _api = UsersApi();
  Future<List<User>> getAllUsers() async => _api.getUsers();
  Future<bool> updateUser(User data ) async => _api.updateUser(data);
}
