abstract class ImcStateMine { }

class ImcStateModelMine implements ImcStateMine {
  
  final double imc;

  ImcStateModelMine({
    required this.imc,
  });
}

class ImcStateLoadingMine implements ImcStateMine {
  ImcStateLoadingMine();
}

class ImcStateErrorMine implements ImcStateMine {

  final String message;

  ImcStateErrorMine({
    required this.message,
  });
}
