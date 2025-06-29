import 'package:ada/features/test/ui/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_state.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit()..start(),

      child: Scaffold(
        appBar: AppBar(title: const Text('Test Screen')),
        body: Center(
          child: BlocSelector<CounterCubit, CounterState, int>(
            selector: (state) => state.count,
            builder: (context, state) {
              return Text(
                'Counter: $state',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
