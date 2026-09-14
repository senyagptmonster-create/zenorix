import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../app/brand.dart';
import '../app/theme.dart';
import 'zenorix_store.dart';
import 'screens.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});
  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  final store = ZenorixStore();
  
  @override
  void initState() {
    super.initState();
    _init();
  }
  
  Future<void> _init() async {
    try {
      final content = await rootBundle.loadString('packages/zenorix/product/content.json');
      await store.load(content);
    } catch (e) {
      await store.load('{"sessions":[]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: cBg,
          appBar: AppBar(title: Text('Zenorix Hub', style: AppTheme.display(cSurface)), backgroundColor: cBg),
          body: GridView.count(
            crossAxisCount: 2,
            children: [
              _btn(context, 'Sphere', const FocusSphereScreen(), Icons.circle),
              _btn(context, 'Log', const SessionLogScreen(), Icons.list),
              _btn(context, 'Analytics', const FlowAnalyticsScreen(), Icons.analytics),
              _btn(context, 'Sounds', const SoundscapesScreen(), Icons.music_note),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _btn(BuildContext context, String title, Widget screen, IconData icon) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(
        appBar: AppBar(title: Text(title, style: AppTheme.display(cSurface)), backgroundColor: cBg),
        backgroundColor: cBg,
        body: screen,
      ))),
      child: Card(
        color: cSurface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: cAccent),
            Text(title, style: AppTheme.text(cInk)),
          ],
        ),
      ),
    );
  }
}
