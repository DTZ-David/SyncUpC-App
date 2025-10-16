enum EventFormStep {
  basicInfo,
  locationAndType,
  details,
  dateTime;

  String get title {
    switch (this) {
      case EventFormStep.basicInfo:
        return 'Información Básica';
      case EventFormStep.locationAndType:
        return 'Ubicación y Tipo';
      case EventFormStep.details:
        return 'Detalles del Evento';
      case EventFormStep.dateTime:
        return 'Fecha y Hora';
    }
  }

  int get stepNumber {
    return index + 1;
  }

  static int get totalSteps => EventFormStep.values.length;
}
