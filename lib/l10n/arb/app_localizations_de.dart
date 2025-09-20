// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get homeAppBarTitle => 'Startseite';

  @override
  String get homeAppBarMessage => 'Willkommen auf der Startseite';

  @override
  String get settingsAppBarTitle => 'Einstellungen';

  @override
  String get languageAppBarTitle => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get taskOnePageAppBarTitle => 'Aufgabe Eins';

  @override
  String get taskOnePagePlaceholderMessage =>
      'Hier wird Aufgabe Eins implementiert.';

  @override
  String get taskTwoPageAppBarTitle => 'Aufgabe Zwei';

  @override
  String get taskTwoPagePlaceholderMessage =>
      'Hier wird Aufgabe Zwei implementiert.';

  @override
  String get homePageNavigateToTaskOneButtonText => 'Gehe zu Aufgabe Eins';

  @override
  String get homePageNavigateToTaskTwoButtonText => 'Gehe zu Aufgabe Zwei';

  @override
  String get biddingZonesLabel => 'Gebotszonen';

  @override
  String get countriesLabel => 'Länder';

  @override
  String get startDateLabel => 'Startdatum';

  @override
  String get endDateLabel => 'Enddatum';

  @override
  String get selectMetricsLabel => 'Metriken auswählen';

  @override
  String get fetchDataButtonLabel => 'Daten abrufen';

  @override
  String get generatePlotButtonLabel => 'Diagramm erstellen';

  @override
  String get noDataMessage =>
      'Keine Daten für die ausgewählten Optionen verfügbar.';

  @override
  String get selectAtLeastOneMetricMessage =>
      'Bitte wählen Sie mindestens eine Metrik aus.';

  @override
  String get fetchingDataMessage => 'Daten werden abgerufen...';

  @override
  String get errorFetchingDataMessage =>
      'Fehler beim Abrufen der Daten. Bitte versuchen Sie es erneut.';

  @override
  String get generatedPlotRequestTitle => 'Generierte Diagrammanfrage';

  @override
  String get noPlotGeneratedMessage =>
      'Es wurde noch kein Diagramm erstellt. Wählen Sie Datenpunkte aus und klicken Sie auf \"Diagramm erstellen\".';

  @override
  String errorGeneratingPlotMessage(Object error) {
    return 'Fehler beim Erstellen des Diagramms: $error';
  }

  @override
  String errorLoadingDataMessage(Object error) {
    return 'Fehler beim Laden der Daten: $error';
  }

  @override
  String get datapointsLabel => 'Datenpunkte';

  @override
  String get invalidFormMessage => 'Ungültiges Formular';

  @override
  String get invalidDateRangeMessage => 'Ungültiger Datumsbereich';

  @override
  String get dataSeriesLabel => 'Datenreihe';

  @override
  String get clearSelectionsButtonText => 'Auswahl löschen';

  @override
  String get retryButtonText => 'Erneut versuchen';

  @override
  String get showLegendLabel => 'Legende anzeigen';

  @override
  String appVersionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get requestedDataNotFoundMessage =>
      'Die angeforderten Daten wurden nicht gefunden. Bitte überprüfen Sie Ihre Auswahl.';

  @override
  String get validationErrorMessage =>
      'Es gab ein Problem mit Ihrer Anfrage. Bitte überprüfen Sie Ihre Eingaben.';

  @override
  String get serverErrorMessage =>
      'Beim Abrufen der Daten ist ein Serverfehler aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get unexpectedErrorMessage =>
      'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get unknownErrorMessage => 'Ein unbekannter Fehler ist aufgetreten.';

  @override
  String get chartLegendTitle => 'Diagrammlegende';

  @override
  String get closeButtonText => 'Schließen';
}
