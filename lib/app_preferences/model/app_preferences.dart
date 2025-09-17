class AppPreferences {
  AppPreferences({
    this.activeTheme = 'system',
    this.preferredLanguageCode,
  });

  factory AppPreferences.fromMap(Map<String, dynamic> map) {
    return AppPreferences(
      activeTheme: map['activeTheme'] as String? ?? 'system',
      preferredLanguageCode: map['preferredLanguageCode'] as String?,
    );
  }

  factory AppPreferences.withDefaults() => AppPreferences();

  String activeTheme;
  String? preferredLanguageCode;

  Map<String, dynamic> toMap() {
    return {
      'activeTheme': activeTheme,
      'preferredLanguageCode': preferredLanguageCode,
    };
  }

  @override
  String toString() {
    return 'AppPreferences{'
        'activeTheme: $activeTheme, '
        'preferredLanguageCode: $preferredLanguageCode}}';
  }
}
