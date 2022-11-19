import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/bloc/events.dart';
import 'package:udemy/examples/bloc_youtube/ui/screens/counter/bloc/states.dart';

class CounterBloc extends Bloc<CounterEvents,CounterStatesE>{
  CounterBloc(): super(InitialCounterStateE()){
    on<IncrementCounterValue>(_incrementValue);
    on<DecrementCounterValue>(_decrementValue);
  }

  static CounterBloc get(context) =>BlocProvider.of(context);
  int count = 0;
  void _incrementValue(
      CounterEvents event,
      Emitter<CounterStatesE> emit
      ){
    count++;
    emit(SuccessCounterStateE());
  }
  void _decrementValue(
      CounterEvents event,
      Emitter<CounterStatesE> emit
      ){
    if(count!= 0){
      count--;
    }

    emit(SuccessCounterStateE());
  }
}