import 'package:auto_route/auto_route.dart';
import 'package:doumo_test_task/src/presentation/views/weather_view.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes =>
      [AutoRoute(page: WeatherRoute.page, initial: true)];
}
