import 'package:dartz/dartz.dart';
import 'package:flowy_sdk/dispatch/dispatch.dart';
import 'package:flowy_sdk/protobuf/flowy-user-infra/protobuf.dart' show SignInRequest, SignUpRequest, UserProfile;
import 'package:flowy_sdk/protobuf/flowy-user/errors.pb.dart';

class AuthRepository {
  Future<Either<UserProfile, UserError>> signIn({required String? email, required String? password}) {
    //
    final request = SignInRequest.create()
      ..email = email ?? ''
      ..password = password ?? '';

    return UserEventSignIn(request).send();
  }

  Future<Either<UserProfile, UserError>> signUp(
      {required String? name, required String? password, required String? email}) {
    final request = SignUpRequest.create()
      ..email = email ?? ''
      ..name = name ?? ''
      ..password = password ?? '';

    return UserEventSignUp(request).send();

    // return UserEventSignUp(request).send().then((result) {
    //   return result.fold((userProfile) async {
    //     return await WorkspaceEventCreateDefaultWorkspace().send().then((result) {
    //       return result.fold((workspaceIdentifier) {
    //         return left(Tuple2(userProfile, workspaceIdentifier.workspaceId));
    //       }, (error) {
    //         throw UnimplementedError;
    //       });
    //     });
    //   }, (error) => right(error));
    // });
  }

  Future<Either<Unit, UserError>> signOut() {
    return UserEventSignOut().send();
  }
}
