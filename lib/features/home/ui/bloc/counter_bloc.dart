import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterBlocState> {
  CounterBloc() : super(CounterBlocState(counter: 0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterBlocState(counter: state.counter + 1));
    });
  }
}
