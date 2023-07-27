abstract class OrderState{
  const OrderState();
}

class OrderInitial extends OrderState{
  const OrderInitial();
}

class OrderLoading extends OrderState{
  const OrderLoading();
}

class OrderError extends OrderState{
  const OrderError();
}

class OrderDone extends OrderState{
  const OrderDone();
}