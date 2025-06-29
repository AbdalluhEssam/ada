import 'package:ada/features/test/ui/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(isLoading: false, count: 0));

  void start() {
    emit(CounterState(isLoading: false, count: 5));
  }

  void increment() {
    emit(CounterState(count: state.count + 1, isLoading: false));
  }

  void loading() {
    emit(CounterState(isLoading: !state.isLoading, count: state.count));
  }

}