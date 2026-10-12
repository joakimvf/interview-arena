import 'package:serverpod/serverpod.dart';

/// The Flutter web app's `assets/config.json`, built from this server's public
/// API address so a deployed app talks to its own API (Serverpod's webapp
/// template).
class AppConfigWidget extends JsonWidget {
  final String apiUrl;

  AppConfigWidget({required this.apiUrl}) : super(object: {'apiUrl': apiUrl});
}

class AppConfigRoute extends WidgetRoute {
  AppConfigWidget widget;

  AppConfigRoute({required final ServerConfig apiConfig})
    : widget = AppConfigWidget(apiUrl: apiConfig.apiUrl.toString());

  @override
  Future<WebWidget> build(Session session, Request request) async {
    return widget;
  }
}

extension on ServerConfig {
  Uri get apiUrl =>
      Uri(scheme: publicScheme, host: publicHost, port: publicPort);
}
