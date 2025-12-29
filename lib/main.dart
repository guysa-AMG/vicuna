import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vicuna/screen/miscscreen.dart';
import 'package:vicuna/screen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:vicuna/services/blocs/controllers/aimodelcontroller.dart';
import 'package:vicuna/services/blocs/controllers/authcontroller.dart';
import 'package:vicuna/services/blocs/controllers/homeviewcontroller.dart';
import 'package:vicuna/services/blocs/controllers/themeController.dart';
import 'package:vicuna/services/blocs/states/themeState.dart';
import 'package:vicuna/services/misc/constants.dart';
import 'package:vicuna/services/repository/aimodel.dart';
import 'package:vicuna/services/repository/analyzer.dart';
import 'package:vicuna/services/repository/authentication.dart';
import 'package:vicuna/services/repository/localpref.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//  Gemini.init(apiKey: "API_KEY");

  // await FlutterGemma.initialize( huggingFaceToken: const String.fromEnvironment('HUGGINGFACE_TOKEN'),maxDownloadRetries: 10,);

  //  await FlutterGemma.installModel(modelType: ModelType.gemmaIt).fromNetwork("https://huggingface.co/google/gemma-3n-E2B-it-litert-preview").install();
  //final model = await FlutterGemma.getActiveModel(maxTokens: 2048);
  LocalInstance local = LocalInstance();
  VicunaAi vicAi = VicunaAi();
  await vicAi.init();
  await local.init();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (dctx) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: local),
          RepositoryProvider.value(value: vicAi),
          RepositoryProvider(create: (repctx) => AuthRepo()),
          RepositoryProvider(create: (repctx) => Analyzer()),
        ],

        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (ct) => Themecontroller()),
            BlocProvider(
              create: (ct) =>
                  LLMController(vicai: RepositoryProvider.of<VicunaAi>(ct),pref: RepositoryProvider.of<LocalInstance>(ct)),
            ),
            BlocProvider(
              create: (ct) => QuickAnalysisController(
                prevState: RepositoryProvider.of<LocalInstance>(ct),
                vicuna: RepositoryProvider.of<Analyzer>(ct),
              ),
            ),
            BlocProvider(
              create: (ct) => Authcontroller(
                prevState: RepositoryProvider.of<LocalInstance>(ct),
                authRepo: RepositoryProvider.of<AuthRepo>(ct),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Themecontroller, Themestate>(
      builder: (ctz, state) {
        return MaterialApp(
          title: 'vicuna',
          locale: Locale('fr', "CH"),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.robotoTextTheme(),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(
                      VicunaVar.borderRadius,
                    ),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  const Color(0xFF2563E0),
                ),
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color.fromARGB(255, 250, 250, 250),
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 250),
            colorScheme: .fromSeed(seedColor: const Color(0xFF2563E0)),
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(VicunaVar.borderRadius),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.white),

                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(
                      VicunaVar.borderRadius,
                    ),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  const Color(0xFF2563E0),
                ),
              ),
            ),
            colorScheme: .fromSeed(
              seedColor: const Color(0xFF2563E0),
              brightness: Brightness.dark,
            ),
          ),
          themeMode: (state is LightTheme) ? ThemeMode.light : ThemeMode.dark,

          home: NavBar(),
        );
      },
    );
  }
}
