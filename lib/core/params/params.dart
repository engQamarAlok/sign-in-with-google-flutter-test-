class HomePageParams {
  final String id;
  HomePageParams({required this.id});
}

class TasksParams {
  final String id;

  TasksParams({required this.id});
}

class UserParams {
  final String id;
  UserParams({required this.id});
}

class PostParams {
  final String id;
  PostParams({required this.id});
}

class SignUpParams {
  final String id;
  SignUpParams({required this.id});
}

class LoginParams {
  final String id;

  final String email;
  final String password;

  LoginParams({required this.email, required this.password, required this.id});
}
