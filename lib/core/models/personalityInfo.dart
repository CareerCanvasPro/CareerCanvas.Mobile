import 'package:flutter/material.dart';

class PersonalityType {
  final String category;
  final String name;
  final String description;
  final List<String> idealCareers;
  final List<String> workEnvironment;
  final List<String> strengths;
  final List<String> recommendedRoles;

  static PersonalityType? getType(String type) {
    return personalityTypes[type];
  }

  static CategoryColors getCategoryColor(String category) {
    return categoryColors[category] ??
        CategoryColors(
          background: Colors.grey.shade200, // Default background color
          foreground: Colors.grey.shade600, // Default foreground color
        );
  }

  PersonalityType({
    required this.category,
    required this.name,
    required this.description,
    required this.idealCareers,
    required this.workEnvironment,
    required this.strengths,
    required this.recommendedRoles,
  });
}

class CategoryColors {
  final Color background;
  final Color foreground;

  CategoryColors({
    required this.background,
    required this.foreground,
  });
}

final Map<String, CategoryColors> categoryColors = {
  "Analysts": CategoryColors(
    background: Color(0xFFE7DFEA),
    foreground: Color(0xFF88619A),
  ),
  "Diplomats": CategoryColors(
    background: Color(0xFFD6ECE3),
    foreground: Color(0xFF33A474),
  ),
  "Sentinels": CategoryColors(
    background: Color(0xFFD9EAF0),
    foreground: Color(0xFF4298B4),
  ),
  "Explorers": CategoryColors(
    background: Color(0xFFF9EED7),
    foreground: Color(0xFFE4AE3A),
  ),
};

final Map<String, PersonalityType> personalityTypes = {
  // Analysts (N & T)
  "INTJ": PersonalityType(
    category: "Analysts",
    name: "Architect",
    description:
        "Imaginative and strategic thinkers, with a plan for everything.",
    idealCareers: [
      "Strategy Consulting",
      "Scientific Research",
      "Engineering",
      "Software Development",
      "Investment Banking"
    ],
    workEnvironment: [
      "Prefers structured, analytical environments with intellectual challenges.",
      "Thrive in leadership roles and long-term strategic planning."
    ],
    strengths: [
      "Excellent at long-term planning and problem-solving.",
      "Highly strategic and logical thinkers."
    ],
    recommendedRoles: [
      "Data Scientist",
      "AI Engineer",
      "Economist",
      "Architect",
      "Business Consultant"
    ],
  ),
  "INTP": PersonalityType(
    category: "Analysts",
    name: "Logician",
    description:
        "Innovative inventors with an unquenchable thirst for knowledge.",
    idealCareers: [
      "Software Development",
      "Academia",
      "Philosophy",
      "Mathematics",
      "Theoretical Physics"
    ],
    workEnvironment: [
      "Prefers independent work with creative problem-solving opportunities.",
      "Thrives in research-heavy roles that allow deep thinking."
    ],
    strengths: [
      "Exceptional problem-solving and analytical skills.",
      "Deep curiosity and ability to explore abstract concepts."
    ],
    recommendedRoles: [
      "Philosopher",
      "Software Engineer",
      "University Professor",
      "Data Analyst",
      "Machine Learning Specialist"
    ],
  ),
  "ENTJ": PersonalityType(
    category: "Analysts",
    name: "Commander",
    description:
        "Bold, imaginative, and strong-willed leaders, always finding a way – or making one.",
    idealCareers: [
      "Leadership",
      "Entrepreneurship",
      "Politics",
      "Finance",
      "Corporate Management"
    ],
    workEnvironment: [
      "Enjoys structured and competitive workplaces with clear goals.",
      "Thrives in high-responsibility roles requiring vision and decision-making."
    ],
    strengths: [
      "Natural leadership and ability to inspire teams.",
      "Highly goal-oriented and strategic."
    ],
    recommendedRoles: [
      "CEO",
      "Political Leader",
      "Financial Analyst",
      "Corporate Manager",
      "Startup Founder"
    ],
  ),
  "ENTP": PersonalityType(
    category: "Analysts",
    name: "Debater",
    description:
        "Smart and curious thinkers who cannot resist an intellectual challenge.",
    idealCareers: [
      "Entrepreneurship",
      "Marketing",
      "Public Relations",
      "Law",
      "Startups"
    ],
    workEnvironment: [
      "Enjoys dynamic, fast-paced environments with intellectual debates.",
      "Prefers roles that involve brainstorming, problem-solving, and persuasion."
    ],
    strengths: [
      "Exceptional communication and debating skills.",
      "Ability to see opportunities where others see problems."
    ],
    recommendedRoles: [
      "Lawyer",
      "Political Analyst",
      "Public Speaker",
      "Venture Capitalist",
      "Marketing Director"
    ],
  ),
  // Diplomats (N & F)
  "INFJ": PersonalityType(
    category: "Diplomats",
    name: "Advocate",
    description:
        "Quiet and mystical, yet very inspiring and tireless idealists.",
    idealCareers: [
      "Psychology",
      "Social Work",
      "Writing",
      "Non-Profit Work",
      "Spiritual Leadership"
    ],
    workEnvironment: [
      "Prefers quiet, meaningful work that aligns with personal values.",
      "Flourishes in roles where they can help others or bring about change."
    ],
    strengths: [
      "Deep understanding of emotions and human nature.",
      "Strong moral compass and idealistic thinking."
    ],
    recommendedRoles: [
      "Psychologist",
      "Counselor",
      "Author",
      "Human Rights Advocate",
      "Life Coach"
    ],
  ),
  "INFP": PersonalityType(
    category: "Diplomats",
    name: "Mediator",
    description:
        "Poetic, kind, and altruistic people, always eager to help a good cause.",
    idealCareers: ["Writing", "Counseling", "Art", "Music", "Therapy"],
    workEnvironment: [
      "Thrives in independent and creative environments.",
      "Prefers workplaces that align with their personal values."
    ],
    strengths: [
      "Deeply empathetic and compassionate.",
      "Creative and excellent at expressing emotions through art."
    ],
    recommendedRoles: ["Writer", "Poet", "Therapist", "Musician", "NGO Worker"],
  ),
  "ENFJ": PersonalityType(
    category: "Diplomats",
    name: "Protagonist",
    description:
        "Charismatic and inspiring leaders, able to mesmerize their listeners.",
    idealCareers: [
      "Coaching",
      "Teaching",
      "Public Speaking",
      "Human Resources",
      "Politics"
    ],
    workEnvironment: [
      "Thrives in social and leadership roles.",
      "Prefers organizations that focus on people development."
    ],
    strengths: [
      "Natural leaders with excellent communication skills.",
      "Empathetic and inspiring."
    ],
    recommendedRoles: [
      "Teacher",
      "Motivational Speaker",
      "HR Manager",
      "Life Coach",
      "Social Worker"
    ],
  ),
  "ENFP": PersonalityType(
    category: "Diplomats",
    name: "Campaigner",
    description:
        "Enthusiastic, creative, and sociable free spirits, who can always find a reason to smile.",
    idealCareers: [
      "Acting",
      "Marketing",
      "Public Relations",
      "Entrepreneurship",
      "Content Creation"
    ],
    workEnvironment: [
      "Thrives in environments that allow creativity and social interactions.",
      "Prefers flexibility over rigid structures."
    ],
    strengths: [
      "Charismatic and great at inspiring people.",
      "High emotional intelligence and creativity."
    ],
    recommendedRoles: [
      "Actor",
      "YouTuber",
      "Podcast Host",
      "Marketing Specialist",
      "Public Speaker"
    ],
  ),
  // Sentinels (S & J)
  "ISTJ": PersonalityType(
    category: "Sentinels",
    name: "Logistician",
    description:
        "Practical and fact-minded individuals, whose reliability cannot be doubted.",
    idealCareers: [
      "Accounting",
      "Law Enforcement",
      "Financial Analysis",
      "Government Work"
    ],
    workEnvironment: [
      "Prefers structured and organized settings with clear rules.",
      "Enjoys working independently on well-defined tasks."
    ],
    strengths: [
      "Excellent at following procedures and ensuring accuracy.",
      "Strong sense of responsibility and duty."
    ],
    recommendedRoles: [
      "Accountant",
      "Auditor",
      "Police Officer",
      "Military Officer",
      "Operations Manager"
    ],
  ),
  "ISFJ": PersonalityType(
    category: "Sentinels",
    name: "Defender",
    description:
        "Very dedicated and warm protectors, always ready to defend their loved ones.",
    idealCareers: [
      "Healthcare",
      "Education",
      "Social Work",
      "Customer Service",
      "Human Resources"
    ],
    workEnvironment: [
      "Flourishes in roles that require empathy and support for others.",
      "Prefers structured and predictable environments."
    ],
    strengths: [
      "Highly empathetic and dependable.",
      "Great at organizing and supporting others."
    ],
    recommendedRoles: [
      "Nurse",
      "Teacher",
      "Counselor",
      "Social Worker",
      "Human Resources Manager"
    ],
  ),
  "ESTJ": PersonalityType(
    category: "Sentinels",
    name: "Executive",
    description:
        "Excellent administrators, unsurpassed at managing things – or people.",
    idealCareers: [
      "Management",
      "Law",
      "Project Management",
      "Government Work",
      "Business Operations"
    ],
    workEnvironment: [
      "Prefers hierarchical workplaces with clear leadership structures.",
      "Enjoys managing people and making data-driven decisions."
    ],
    strengths: [
      "Strong leadership and organizational skills.",
      "Decisive and goal-oriented."
    ],
    recommendedRoles: [
      "CEO",
      "Lawyer",
      "Corporate Manager",
      "Political Leader",
      "Financial Advisor"
    ],
  ),
  "ESFJ": PersonalityType(
    category: "Sentinels",
    name: "Consul",
    description:
        "Extraordinarily caring, social and popular people, always eager to help.",
    idealCareers: [
      "Healthcare",
      "Education",
      "Event Planning",
      "Customer Service",
      "Human Resources"
    ],
    workEnvironment: [
      "Enjoys working in teams and making personal connections.",
      "Prefers structured environments where they can help others."
    ],
    strengths: [
      "Highly empathetic and socially aware.",
      "Great at building connections and fostering harmony."
    ],
    recommendedRoles: [
      "Nurse",
      "Teacher",
      "Event Planner",
      "Human Resources Specialist",
      "Community Manager"
    ],
  ),
  // Explorers (S & P)
  "ISTP": PersonalityType(
    category: "Explorers",
    name: "Virtuoso",
    description:
        "Bold and practical experimenters, masters of all kinds of tools.",
    idealCareers: [
      "Engineering",
      "Carpentry",
      "Mechanics",
      "Forensic Science",
      "Aviation",
      "Military"
    ],
    workEnvironment: [
      "Prefers hands-on, practical work that involves problem-solving.",
      "Enjoys autonomy and dislikes rigid structures."
    ],
    strengths: [
      "Quick learner and excellent with tools.",
      "Enjoys troubleshooting and fixing real-world problems."
    ],
    recommendedRoles: [
      "Mechanical Engineer",
      "Auto Technician",
      "Forensic Scientist",
      "Pilot",
      "Navy SEAL"
    ],
  ),
  "ISFP": PersonalityType(
    category: "Explorers",
    name: "Adventurer",
    description:
        "Flexible and charming artists, always ready to explore and experience something new.",
    idealCareers: ["Art", "Fashion", "Music", "Photography", "Travel Blogger"],
    workEnvironment: [
      "Prefers creative, spontaneous environments where they can express themselves.",
      "Enjoys roles with a hands-on approach and flexibility."
    ],
    strengths: [
      "Creative, artistic, and in touch with their emotions.",
      "Highly adaptable and good at thinking on their feet."
    ],
    recommendedRoles: [
      "Artist",
      "Photographer",
      "Musician",
      "Travel Blogger",
      "Fashion Designer"
    ],
  ),
  "ESTP": PersonalityType(
    category: "Explorers",
    name: "Entrepreneur",
    description:
        "Smart, energetic and very perceptive people, who truly enjoy living on the edge.",
    idealCareers: [
      "Entrepreneurship",
      "Sales",
      "Marketing",
      "Sports",
      "Investing"
    ],
    workEnvironment: [
      "Thrives in high-energy, fast-paced environments.",
      "Enjoys taking risks and thrives in situations requiring quick decision-making."
    ],
    strengths: [
      "Highly energetic and adaptable.",
      "Great at reading situations and responding quickly."
    ],
    recommendedRoles: [
      "Entrepreneur",
      "Sales Director",
      "Marketing Specialist",
      "Investor",
      "Event Coordinator"
    ],
  ),
  "ESFP": PersonalityType(
    category: "Explorers",
    name: "Entertainer",
    description:
        "Spontaneous, energetic and enthusiastic people – life is never boring around them.",
    idealCareers: [
      "Acting",
      "Music",
      "Dancing",
      "Event Hosting",
      "Sales",
      "Travel Industry"
    ],
    workEnvironment: [
      "Prefers social and lively environments with room for creativity.",
      "Enjoys working with people and keeping things exciting."
    ],
    strengths: [
      "Naturally charismatic and great at entertaining audiences.",
      "Excellent interpersonal and networking skills."
    ],
    recommendedRoles: [
      "Actor",
      "Comedian",
      "Event Planner",
      "TV Host",
      "Social Media Influencer"
    ],
  ),
};
