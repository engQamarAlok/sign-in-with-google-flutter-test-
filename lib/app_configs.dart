import 'package:flutter/material.dart';

class AppConfigs {
  // --- 1. إعدادات الهوية ---
  static const String appTitle = 'Tasks Management';
  static const String fontFamily = 'ElMessiri';

  // --- 2. ألوان الوضع الفاتح (Light Mode) ---
  static const Color lightPrimary = Color(0xFF673AB7);
  static const Color lightAppBar = Color(0xFF92BFC6);
  static const Color lightScaffold = Color(0xFFF8F9FA);
  static const Color lightAccent = Color(0xFFFF72CB);

  // --- 3. ألوان الوضع الليلي (Dark Mode) ---
  static const Color darkPrimary = Color(0xFFBB86FC);
  static const Color darkAppBar = Color(0xFF1F1F1F);
  static const Color darkScaffold = Color(0xFF121212);
  static const Color darkAccent = Color(0xFF03DAC6);

  // --- 4. خواص التصميم الموحدة (إضافات ذكية) ---
  static const double borderRadius =
      20.0; // التحكم في انحناء كل البطاقات والأزرار
  static const double defaultPadding = 16.0; // المسافة الافتراضية حول العناصر

  // أحجام الخطوط الموحدة
  static const double fontSizeTitle = 28.0;
  static const double fontSizeBody = 18.0;

  ThemeData buildTheme(Brightness brightness) {
    bool isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppConfigs.fontFamily,

      // الألوان الأساسية بناءً على الوضع
      primaryColor: isDark ? AppConfigs.darkPrimary : AppConfigs.lightPrimary,
      scaffoldBackgroundColor: isDark
          ? AppConfigs.darkScaffold
          : AppConfigs.lightScaffold,

      colorScheme: ColorScheme.fromSeed(
        seedColor: isDark ? AppConfigs.darkPrimary : AppConfigs.lightPrimary,
        brightness: brightness,
        secondary: isDark ? AppConfigs.darkAccent : AppConfigs.lightAccent,
      ),

      // إعدادات الـ AppBar (مع الحواف والخطوط)
      appBarTheme: AppBarTheme(
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 4,
        backgroundColor: isDark
            ? AppConfigs.darkAppBar
            : AppConfigs.lightAppBar,
        actionsPadding: const EdgeInsets.all(8),
        titleTextStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: AppConfigs.fontFamily,
        ),
        // الحواف المستمرة (ContinuousRectangleBorder) التي تعطي طابعاً فخماً
        shape: ContinuousRectangleBorder(
          side: BorderSide(
            color: isDark ? Colors.white12 : const Color(0xFF7FA6AC),
            width: 2,
          ),
        ),
      ),

      // إعدادات النصوص الموحدة (TextTheme)
      textTheme:
          TextTheme(
            headlineLarge: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? AppConfigs.darkPrimary : Colors.blue,
            ),
            labelMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ).apply(
            fontFamily: AppConfigs.fontFamily,
          ), // تطبيق الخط العربي على جميع النصوص
    );
  }

  static const Color tasksInProgressColor = Color.fromARGB(255, 243, 190, 99);
  static const Color newTasksColor = Color.fromARGB(255, 121, 174, 217);
  static const Color completedTasksColor = Color.fromARGB(255, 86, 198, 90);
  static const Color overDueTasksColor = Color.fromARGB(255, 244, 81, 70);
  static const Color todayDeadlineTasksColor = Color.fromARGB(
    255,
    223,
    120,
    113,
  );
}
