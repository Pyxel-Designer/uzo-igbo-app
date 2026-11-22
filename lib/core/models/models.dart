class Dialect {
  final String id;
  final String name;
  final String region;
  final bool popular;

  const Dialect({
    required this.id,
    required this.name,
    required this.region,
    this.popular = false,
  });

  factory Dialect.fromJson(Map<String, dynamic> json) {
    return Dialect(
      id: json['id'] as String,
      name: json['name'] as String,
      region: json['region'] as String,
      popular: json['popular'] as bool? ?? false,
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String type; // 'listening', 'speaking', 'market_dialogue'
  final int xp;
  final Map<String, dynamic> content;
  bool isCompleted;

  Lesson({
    required this.id,
    required this.title,
    required this.type,
    required this.xp,
    required this.content,
    this.isCompleted = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      xp: json['xp'] as int,
      content: json['content'] as Map<String, dynamic>,
    );
  }
}

class LearningUnit {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;

  const LearningUnit({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });

  factory LearningUnit.fromJson(Map<String, dynamic> json) {
    final list = (json['lessons'] as List)
        .map((l) => Lesson.fromJson(l as Map<String, dynamic>))
        .toList();
    return LearningUnit(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      lessons: list,
    );
  }
}

class ToneVariation {
  final String word;
  final String toneProfile;
  final String meaning;
  final String example;

  const ToneVariation({
    required this.word,
    required this.toneProfile,
    required this.meaning,
    required this.example,
  });

  factory ToneVariation.fromJson(Map<String, dynamic> json) {
    return ToneVariation(
      word: json['word'] as String,
      toneProfile: json['toneProfile'] as String,
      meaning: json['meaning'] as String,
      example: json['example'] as String,
    );
  }
}

class ToneWorkout {
  final String id;
  final String baseWord;
  final List<ToneVariation> variations;

  const ToneWorkout({
    required this.id,
    required this.baseWord,
    required this.variations,
  });

  factory ToneWorkout.fromJson(Map<String, dynamic> json) {
    final list = (json['variations'] as List)
        .map((v) => ToneVariation.fromJson(v as Map<String, dynamic>))
        .toList();
    return ToneWorkout(
      id: json['id'] as String,
      baseWord: json['baseWord'] as String,
      variations: list,
    );
  }
}

class TravelPhrase {
  final String igbo;
  final String english;
  final String phonetic;

  const TravelPhrase({
    required this.igbo,
    required this.english,
    required this.phonetic,
  });

  factory TravelPhrase.fromJson(Map<String, dynamic> json) {
    return TravelPhrase(
      igbo: json['igbo'] as String,
      english: json['english'] as String,
      phonetic: json['phonetic'] as String,
    );
  }
}

class TravelCategory {
  final String category;
  final List<TravelPhrase> phrases;

  const TravelCategory({
    required this.category,
    required this.phrases,
  });

  factory TravelCategory.fromJson(Map<String, dynamic> json) {
    final list = (json['phrases'] as List)
        .map((p) => TravelPhrase.fromJson(p as Map<String, dynamic>))
        .toList();
    return TravelCategory(
      category: json['category'] as String,
      phrases: list,
    );
  }
}

class Proverb {
  final String igbo;
  final String literal;
  final String meaning;
  final String theme;

  const Proverb({
    required this.igbo,
    required this.literal,
    required this.meaning,
    required this.theme,
  });

  factory Proverb.fromJson(Map<String, dynamic> json) {
    return Proverb(
      igbo: json['igbo'] as String,
      literal: json['literal'] as String,
      meaning: json['meaning'] as String,
      theme: json['theme'] as String,
    );
  }
}

class UserProfile {
  String name;
  String selectedDialect;
  int streakDays;
  int xp;
  int gems;
  int dailyGoalMinutes;
  Set<String> completedLessonIds;

  UserProfile({
    this.name = "Nwanne",
    this.selectedDialect = "Central Igbo (Izugbe)",
    this.streakDays = 5,
    this.xp = 340,
    this.gems = 120,
    this.dailyGoalMinutes = 15,
    Set<String>? completedLessonIds,
  }) : completedLessonIds = completedLessonIds ?? {'lesson_1_1'};
}
