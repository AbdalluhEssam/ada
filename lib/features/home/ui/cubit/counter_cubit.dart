import 'package:ada/features/home/ui/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counter: 5));

  void increment() {
    emit(CounterState(counter: state.counter + 1));
  }
}
