abstract class CounterStatesE{}

class InitialCounterStateE extends CounterStatesE{}
class SuccessCounterStateE extends CounterStatesE{}
class ErrorCounterStateE extends CounterStatesE{
  final String error;

  ErrorCounterStateE(this.error);
}