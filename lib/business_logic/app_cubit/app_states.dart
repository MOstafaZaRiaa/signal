abstract class AppStates {}

class AppInitialState extends AppStates {}

// for navigation
class ShopChangeBottomNav extends AppStates {}

//for get user data
class AppGetUserDataLoadingState extends AppStates {}

class AppGetUserDataSuccessesState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {
  final error;

  AppGetUserDataErrorState(this.error);
}

//for theme
class AppThemeModeState extends AppStates {}

//user image
class SocialProfileImagePickedSuccessState extends AppStates {}

class SocialProfileImagePickedErrorState extends AppStates {}

//user cover
class SocialCoverImagePickedSuccessState extends AppStates {}

class SocialCoverImagePickedErrorState extends AppStates {}

//upload profile pic
class SocialUploadCoverImageErrorState extends AppStates {}

class SocialUploadProfileImageErrorState extends AppStates {}

//update user data
class SocialUserUpdateLoadingState extends AppStates {}

class SocialUserUpdateSuccessState extends AppStates {}

class SocialUserUpdateErrorState extends AppStates {}

//(create & get) post
class SocialPostImagePickedSuccessState extends AppStates {}

class SocialPostImagePickedErrorState extends AppStates {}

class SocialRemovePostImageState extends AppStates {}

class SocialCreatePostLoadingState extends AppStates {}

class SocialCreatePostErrorState extends AppStates {
  final error;

  SocialCreatePostErrorState(this.error);
}

class SocialCreatePostSuccessState extends AppStates {}

class SocialGetPostsLoadingState extends AppStates {}

class SocialGetPostsSuccessState extends AppStates {}

class SocialGetPostsErrorState extends AppStates {
  final error;

  SocialGetPostsErrorState(this.error);
}

// get app users
class SocialGetAllUsersLoadingState extends AppStates {}

class SocialGetAllUsersSuccessState extends AppStates {}

class SocialGetAllUsersErrorState extends AppStates {
  final error;

  SocialGetAllUsersErrorState(this.error);
}

//posts actions
class SocialLikePostSuccessState extends AppStates {}

class SocialLikePostErrorState extends AppStates {
  final error;

  SocialLikePostErrorState(this.error);
}

//chat messages

class SocialSendMessageSuccessState extends AppStates {}

class SocialSendMessageErrorState extends AppStates {}
class SocialGetMessagesSuccessState extends AppStates {}



class SignOutState extends AppStates {}
