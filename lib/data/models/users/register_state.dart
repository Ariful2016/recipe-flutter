class RegisterState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  RegisterState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return RegisterState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        isSuccess: isSuccess ?? this.isSuccess
    );
  }
}
