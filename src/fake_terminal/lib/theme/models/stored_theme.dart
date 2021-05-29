import 'package:equatable/equatable.dart';
import 'package:fake_terminal/theme/models/theme_settings.dart';

class StoredTheme extends Equatable {
  final ThemeSettings settings;
  StoredTheme(this.settings);

  @override
  List<Object?> get props => [settings];
}
