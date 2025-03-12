class PersonalityType {
  final String category;
  final String name;
  final String description;

  static PersonalityType? getType(String type) {
    return personalityTypes[type];
  }

  PersonalityType({
    required this.category,
    required this.name,
    required this.description,
  });
}

final Map<String, PersonalityType> personalityTypes = {
  // Analysts
  "INTJ": PersonalityType(
    category: "Analysts",
    name: "Architect",
    description:
        "Imaginative and strategic thinkers, with a plan for everything.",
  ),
  "INTP": PersonalityType(
    category: "Analysts",
    name: "Logician",
    description:
        "Innovative inventors with an unquenchable thirst for knowledge.",
  ),
  "ENTJ": PersonalityType(
    category: "Analysts",
    name: "Commander",
    description:
        "Bold, imaginative and strong-willed leaders, always finding a way – or making one.",
  ),
  "ENTP": PersonalityType(
    category: "Analysts",
    name: "Debater",
    description:
        "Smart and curious thinkers who cannot resist an intellectual challenge.",
  ),

  // Diplomats
  "INFJ": PersonalityType(
    category: "Diplomats",
    name: "Advocate",
    description:
        "Quiet and mystical, yet very inspiring and tireless idealists.",
  ),
  "INFP": PersonalityType(
    category: "Diplomats",
    name: "Mediator",
    description:
        "Poetic, kind and altruistic people, always eager to help a good cause.",
  ),
  "ENFJ": PersonalityType(
    category: "Diplomats",
    name: "Protagonist",
    description:
        "Charismatic and inspiring leaders, able to mesmerize their listeners.",
  ),
  "ENFP": PersonalityType(
    category: "Diplomats",
    name: "Campaigner",
    description:
        "Enthusiastic, creative and sociable free spirits, who can always find a reason to smile.",
  ),

  // Sentinels
  "ISTJ": PersonalityType(
    category: "Sentinels",
    name: "Logistician",
    description:
        "Practical and fact-minded individuals, whose reliability cannot be doubted.",
  ),
  "ISFJ": PersonalityType(
    category: "Sentinels",
    name: "Defender",
    description:
        "Very dedicated and warm protectors, always ready to defend their loved ones.",
  ),
  "ESTJ": PersonalityType(
    category: "Sentinels",
    name: "Executive",
    description:
        "Excellent administrators, unsurpassed at managing things – or people.",
  ),
  "ESFJ": PersonalityType(
    category: "Sentinels",
    name: "Consul",
    description:
        "Extraordinarily caring, social and popular people, always eager to help.",
  ),

  // Explorers
  "ISTP": PersonalityType(
    category: "Explorers",
    name: "Virtuoso",
    description:
        "Bold and practical experimenters, masters of all kinds of tools.",
  ),
  "ISFP": PersonalityType(
    category: "Explorers",
    name: "Adventurer",
    description:
        "Flexible and charming artists, always ready to explore and experience something new.",
  ),
  "ESTP": PersonalityType(
    category: "Explorers",
    name: "Entrepreneur",
    description:
        "Smart, energetic and very perceptive people, who truly enjoy living on the edge.",
  ),
  "ESFP": PersonalityType(
    category: "Explorers",
    name: "Entertainer",
    description:
        "Spontaneous, energetic and enthusiastic people – life is never boring around them.",
  ),
};
