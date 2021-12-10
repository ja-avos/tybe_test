part of "user_cubit.dart";

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class UserState extends Equatable {
  final RequestStatus status;
  final AuthStatus authStatus;
  final String? message;
  final User? user;

  const UserState({
    this.status = RequestStatus.noSubmitted,
    this.authStatus = AuthStatus.unknown,
    this.message,
    this.user,
  });

  factory UserState.initial() => const UserState();

  factory UserState.loading() =>
      const UserState(status: RequestStatus.inProgress);

  factory UserState.authenticated(User user) => UserState(
        status: RequestStatus.success,
        authStatus: AuthStatus.authenticated,
        user: user,
      );

  factory UserState.unauthenticated({String? message}) => UserState(
        status: RequestStatus.success,
        authStatus: AuthStatus.unauthenticated,
        message: message,
      );

  factory UserState.error(String message) => UserState(
        status: RequestStatus.failed,
        authStatus: AuthStatus.unknown,
        message: message,
      );

  UserState copyWith({
    RequestStatus? status,
    AuthStatus? authStatus,
    String? message,
    User? user,
  }) {
    return UserState(
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, message, user];
}
