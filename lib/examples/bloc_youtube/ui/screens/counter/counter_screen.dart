import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/bloc/bloc.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/bloc/events.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/bloc/states.dart';

class CounterScreenE extends StatelessWidget {
  const CounterScreenE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: BlocConsumer<CounterBloc, CounterStatesE>(
        listener: (context, state) {
          if(state is SuccessCounterStateE){
            print('success counter bloc');
          }
        },
        builder: (context, state) {
          int count = CounterBloc.get(context).count;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Counter Screen'),
              backgroundColor: Colors.teal,
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      CounterBloc.get(context).add(IncrementCounterValue());
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                   Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      CounterBloc.get(context).add(DecrementCounterValue());
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
