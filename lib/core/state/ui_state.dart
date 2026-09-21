enum UiStateStatus { initial, loading, success, empty, error }

class UiState<T> {
  final UiStateStatus status;
  final T? data;
  final String? errorMessage;

  const UiState({required this.status, this.data, this.errorMessage});

  const UiState.initial()
    : status = UiStateStatus.initial,
      data = null,
      errorMessage = null;

  const UiState.loading()
    : status = UiStateStatus.loading,
      data = null,
      errorMessage = null;

  const UiState.success(T data)
    : status = UiStateStatus.success,
      data = data,
      errorMessage = null;

  const UiState.empty()
    : status = UiStateStatus.empty,
      data = null,
      errorMessage = null;

  const UiState.error(String message)
    : status = UiStateStatus.error,
      data = null,
      errorMessage = message;
}
