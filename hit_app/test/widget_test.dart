import 'package:flutter_test/flutter_test.dart';
import 'package:hit_app/main.dart';
void main(){testWidgets('HIT muestra inicio de sesión', (tester) async {await tester.pumpWidget(const HitApp(demoMode:true));expect(find.text('Hotel Incident Tracker'),findsOneWidget);expect(find.text('Iniciar sesión'),findsOneWidget);});}
