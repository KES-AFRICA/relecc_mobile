import 'package:hive/hive.dart';
import 'package:sopaki_app/src/shared/model/user/user.model.dart';

part 'login_local_storage.model.g.dart';

@HiveType(typeId: 0)
class LoginLocalStorage extends HiveObject{
  @HiveField(0)
  final User? user;

  LoginLocalStorage({this.user});
}
