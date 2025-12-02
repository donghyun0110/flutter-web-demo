enum Language {
  korean,
  chinese,
  japanese,
  english,
}

enum Gender {
  female,
  male,
}

enum AgeGroup {
  teens,
  twenties,
  thirties,
  forties,
  fiftiesPlus,
}

enum Concern {
  immune,
  digestive,
  joint,
  skin,
  eye,
  energy,
}

class UserProfile {
  final Language? language;
  final Gender? gender;
  final AgeGroup? ageGroup;
  final Concern? concern;

  const UserProfile({
    this.language,
    this.gender,
    this.ageGroup,
    this.concern,
  });

  UserProfile copyWith({
    Language? language,
    Gender? gender,
    AgeGroup? ageGroup,
    Concern? concern,
  }) {
    return UserProfile(
      language: language ?? this.language,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      concern: concern ?? this.concern,
    );
  }
}

