import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  List<Dialect> dialects = [];
  List<LearningUnit> units = [];
  List<ToneWorkout> toneWorkouts = [];
  List<TravelCategory> travelCategories = [];
  List<Proverb> proverbs = [];
  UserProfile userProfile = UserProfile();

  bool isInitialized = false;

  Future<void> init() async {
    if (isInitialized) return;

    try {
      final jsonString = await rootBundle.loadString('assets/data/curriculum.json');
      final data = json.decode(jsonString) as Map<String, dynamic>;

      dialects = (data['dialects'] as List)
          .map((d) => Dialect.fromJson(d as Map<String, dynamic>))
          .toList();

      units = (data['units'] as List)
          .map((u) => LearningUnit.fromJson(u as Map<String, dynamic>))
          .toList();

      toneWorkouts = (data['toneWorkouts'] as List)
          .map((t) => ToneWorkout.fromJson(t as Map<String, dynamic>))
          .toList();

      travelCategories = (data['travelPhrases'] as List)
          .map((tc) => TravelCategory.fromJson(tc as Map<String, dynamic>))
          .toList();

      proverbs = (data['proverbs'] as List)
          .map((p) => Proverb.fromJson(p as Map<String, dynamic>))
          .toList();

      final prefs = await SharedPreferences.getInstance();
      userProfile.name = prefs.getString('user_name') ?? "Nwanne";
      userProfile.selectedDialect = prefs.getString('user_dialect') ?? "Central Igbo (Izugbe)";
      userProfile.streakDays = prefs.getInt('user_streak') ?? 7;
      userProfile.xp = prefs.getInt('user_xp') ?? 480;
      userProfile.gems = prefs.getInt('user_gems') ?? 150;
      userProfile.dailyGoalMinutes = prefs.getInt('user_goal') ?? 15;

      final completedList = prefs.getStringList('completed_lessons');
      if (completedList != null) {
        userProfile.completedLessonIds = completedList.toSet();
      }

      isInitialized = true;
    } catch (e) {
      // Graceful fallback for initial test launch
      isInitialized = true;
    }
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', userProfile.name);
    await prefs.setString('user_dialect', userProfile.selectedDialect);
    await prefs.setInt('user_streak', userProfile.streakDays);
    await prefs.setInt('user_xp', userProfile.xp);
    await prefs.setInt('user_gems', userProfile.gems);
    await prefs.setInt('user_goal', userProfile.dailyGoalMinutes);
    await prefs.setStringList('completed_lessons', userProfile.completedLessonIds.toList());
  }

  void completeLesson(String lessonId, int xpReward) {
    userProfile.completedLessonIds.add(lessonId);
    userProfile.xp += xpReward;
    userProfile.gems += 10;
    saveProfile();
  }
}
