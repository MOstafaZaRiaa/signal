
abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{
  // final UserModel? userModel;
  //
  // SignUpSuccessState(this.userModel);
}
class SignUpChangePasswordVisibilityState extends SignUpStates{}
class SignUpErrorState extends SignUpStates{
  final String error;
  SignUpErrorState(this.error);
}


class SaveUserDataSuccessState extends SignUpStates{}
class SaveUserDataErrorState extends SignUpStates{}