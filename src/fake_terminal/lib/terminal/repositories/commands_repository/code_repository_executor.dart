import 'package:fake_terminal/texts/terminal_texts.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

abstract class CodeRepositoryExecutor {
  void executeOpenTerminalRepositoryCommand();
  void executeOpenPersonalRepositoryCommand();
}

final _kLogger = Logger("CodeRepositoryExecutor");

class CodeRepositoryExecutorImpl extends CodeRepositoryExecutor {
  @override
  void executeOpenTerminalRepositoryCommand() => _openUrl(TerminalTexts.githubRepositoryUrl);
  @override
  void executeOpenPersonalRepositoryCommand() => _openUrl(TerminalTexts.personalRepositoryUrl);

  void _openUrl(String url) async {
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      _kLogger.warning("Could not launch $url");
    }
  }
}
