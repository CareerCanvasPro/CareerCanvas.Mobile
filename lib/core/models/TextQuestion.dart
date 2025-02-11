// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TestQuestion {
  String category;
  String question;
  String questionID;
  int? answer;
  TestQuestion({
    required this.category,
    required this.question,
    required this.questionID,
    this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionID': questionID,
      'answer': answer,
    };
  }

  factory TestQuestion.fromMap(Map<String, dynamic> map) {
    return TestQuestion(
      category: map['category'] as String,
      question: map['question'] as String,
      questionID: map['questionID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestQuestion.fromJson(String source) =>
      TestQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<Map<String, dynamic>> dummyQuestions = [
  {
    "category": "EI",
    "question": "You can easily connect with people you have just met.",
    "score": 1,
    "questionID": "4d55b118-113a-4c6d-8de0-6a0222c3be3b"
  },
  {
    "category": "EI",
    "question":
        "You feel comfortable just walking up to someone you find interesting and striking up a conversation.",
    "score": 1,
    "questionID": "82714196-6e2a-4512-bec2-2b7f8c7b82da"
  },
  {
    "category": "TF",
    "question":
        "Even a small mistake can cause you to doubt your overall abilities and knowledge.",
    "score": -1,
    "questionID": "ecce332c-bd20-4423-8a16-48e651b218a9"
  },
  {
    "category": "TF",
    "question":
        "When facts and feelings conflict, you usually find yourself following your heart.",
    "score": -1,
    "questionID": "3577b9a8-d7f5-4d7d-a3c2-11a0d4e4b737"
  },
  {
    "category": "TF",
    "question":
        "You favor efficiency in decisions, even if it means disregarding some emotional aspects.",
    "score": 1,
    "questionID": "6bd1a588-2792-4f43-bcb9-1f0cb5ad1a8c"
  },
  {
    "category": "JP",
    "question":
        "You prioritize and plan tasks effectively, often completing them well before the deadline.",
    "score": 1,
    "questionID": "9e78199a-d83c-46f7-970e-42c8810e6042"
  },
  {
    "category": "EI",
    "question": "Your friends would describe you as lively and outgoing.",
    "score": 1,
    "questionID": "1fe94c9d-7559-428c-bc1f-ac7ec355e1dc"
  },
  {
    "category": "TF",
    "question":
        "When someone thinks highly of you, you wonder how long it will take them to feel disappointed in you.",
    "score": -1,
    "questionID": "01d080f3-085b-4dc6-a65e-d3f9844cd71c"
  },
  {
    "category": "EI",
    "question":
        "You enjoy solitary hobbies or activities more than group ones.",
    "score": -1,
    "questionID": "0bb4aed0-8d5b-467c-8ce6-070859598c01"
  },
  {
    "category": "JP",
    "question":
        "You complete things methodically without skipping over any steps.",
    "score": 1,
    "questionID": "0fc2acdf-5a01-4218-aff7-26e61cbbfdba"
  },
  {
    "category": "SN",
    "question":
        "You are not too interested in discussions about various interpretations of creative works.",
    "score": 1,
    "questionID": "928fdcea-e0f7-4006-b5c4-eb625b254520"
  },
  {
    "category": "TF",
    "question": "You rarely feel insecure.",
    "score": 1,
    "questionID": "4178840e-63eb-423d-a133-a2e6da77a3d7"
  },
  {
    "category": "TF",
    "question":
        "You are prone to worrying that things will take a turn for the worse.",
    "score": -1,
    "questionID": "fbe110dd-72eb-4326-8f37-571aba0db1d9"
  },
  {
    "category": "SN",
    "question":
        "You believe that pondering abstract philosophical questions is a waste of time.",
    "score": 1,
    "questionID": "0dd6de40-f7cf-4411-b1e7-bc9505d28c00"
  },
  {
    "category": "JP",
    "question": "You like to have a to-do list for each day.",
    "score": 1,
    "questionID": "d9da4e13-db7c-4b94-be63-562d9014ab91"
  },
  {
    "category": "EI",
    "question":
        "You find the idea of networking or promoting yourself to strangers very daunting.",
    "score": -1,
    "questionID": "ac1289d1-3d1f-4b7d-a7a4-996eb2e36c9e"
  },
  {
    "category": "SN",
    "question":
        "Complex and novel ideas excite you more than simple and straightforward ones.",
    "score": -1,
    "questionID": "ef42e594-45bf-431a-abf3-0ed99ff4a5f7"
  },
  {
    "category": "TF",
    "question":
        "You are still bothered by mistakes that you made a long time ago.",
    "score": -1,
    "questionID": "e6363c19-dd62-47b9-a12e-7c10a73062ad"
  },
  {
    "category": "TF",
    "question":
        "You rarely worry about whether you make a good impression on people you meet.",
    "score": 1,
    "questionID": "305a7f98-b00e-4efb-b152-0435073c56b7"
  },
  {
    "category": "SN",
    "question":
        "You cannot imagine yourself writing fictional stories for a living.",
    "score": 1,
    "questionID": "c593d071-058c-4165-a40a-5c0d4729165f"
  },
  {
    "category": "EI",
    "question":
        "You usually wait for others to introduce themselves first at social gatherings.",
    "score": -1,
    "questionID": "ceebf4ea-976e-4995-870c-f97e683f8731"
  },
  {
    "category": "SN",
    "question": "You enjoy exploring unfamiliar ideas and viewpoints.",
    "score": -1,
    "questionID": "d17eeed4-1613-48cf-ad97-0e362f9b8342"
  },
  {
    "category": "JP",
    "question":
        "You often allow the day to unfold without any schedule at all.",
    "score": -1,
    "questionID": "38b9fa0e-38a5-4612-bd0f-ad313628719f"
  },
  {
    "category": "JP",
    "question": "You often end up doing things at the last possible moment.",
    "score": -1,
    "questionID": "82ebe0ee-876b-47b9-880e-fcb35b65a1f4"
  },
  {
    "category": "EI",
    "question":
        "You feel more drawn to busy, bustling atmospheres than to quiet, intimate places.",
    "score": 1,
    "questionID": "62ddc253-0610-4ade-9d52-abb58518a547"
  },
  {
    "category": "TF",
    "question": "You rarely second-guess the choices that you have made.",
    "score": 1,
    "questionID": "6d0a4dee-1711-4e9d-9522-61e21a67a36a"
  },
  {
    "category": "TF",
    "question":
        "If a decision feels right to you, you often act on it without needing further proof.",
    "score": -1,
    "questionID": "b2ef438c-28f2-4252-af1e-3a73462be767"
  },
  {
    "category": "TF",
    "question": "You enjoy debating ethical dilemmas.",
    "score": -1,
    "questionID": "d67156a8-34cc-4d4d-af75-ed8575ba34f1"
  },
  {
    "category": "TF",
    "question":
        "You are more likely to rely on emotional intuition than logical reasoning when making a choice.",
    "score": -1,
    "questionID": "f5752fbf-26f3-4e9a-a0ed-20b3c4306789"
  },
  {
    "category": "JP",
    "question":
        "If your plans are interrupted, your top priority is to get back on track as soon as possible.",
    "score": 1,
    "questionID": "b52ec1e7-fb61-42db-9d2a-9a058c43559b"
  },
  {
    "category": "SN",
    "question": "You enjoy experimenting with new and untested approaches.",
    "score": -1,
    "questionID": "929f2859-7a9a-467c-97f3-dcb2a08144ce"
  },
  {
    "category": "SN",
    "question":
        "You become bored or lose interest when the discussion gets highly theoretical.",
    "score": 1,
    "questionID": "cc29fc4a-bed1-4683-90c1-09dac23a8c75"
  },
  {
    "category": "EI",
    "question":
        "You would love a job that requires you to work alone most of the time.",
    "score": -1,
    "questionID": "1770063e-8896-46bd-8d57-1fd93444fb11"
  },
  {
    "category": "TF",
    "question": "Your mood can change very quickly.",
    "score": -1,
    "questionID": "a6cb63e1-efda-45c7-8292-635802df4754"
  },
  {
    "category": "TF",
    "question": "Your emotions control you more than you control them.",
    "score": -1,
    "questionID": "ddef498c-9673-4ab5-b63d-4b25ce57889f"
  },
  {
    "category": "TF",
    "question": "You prioritize being sensitive over being completely honest.",
    "score": -1,
    "questionID": "5447d4a4-4ef7-4273-8362-0bc8c44c123e"
  },
  {
    "category": "JP",
    "question": "Your living and working spaces are clean and organized.",
    "score": 1,
    "questionID": "22e4f046-8e48-4375-85ae-348f728970df"
  },
  {
    "category": "TF",
    "question": "You feel confident that things will work out for you.",
    "score": 1,
    "questionID": "aa84afb3-af67-446d-a96d-2283762f443d"
  },
  {
    "category": "SN",
    "question":
        "You are not too interested in discussing theories on what the world could look like in the future.",
    "score": 1,
    "questionID": "f9ce2b05-7052-4fbd-8fe6-307424b49061"
  },
  {
    "category": "TF",
    "question":
        "You usually base your choices on objective facts rather than emotional impressions.",
    "score": 1,
    "questionID": "4343051a-d620-44fe-87c4-62fee1dd900e"
  },
  {
    "category": "SN",
    "question":
        "You actively seek out new experiences and knowledge areas to explore.",
    "score": -1,
    "questionID": "2db18218-615d-4134-bbf7-c0b006fb2006"
  },
  {
    "category": "TF",
    "question":
        "In disagreements, you prioritize proving your point over preserving the feelings of others.",
    "score": 1,
    "questionID": "0d4d3f01-915a-4cb5-b6fc-41fd4eddf41d"
  },
  {
    "category": "JP",
    "question": "You struggle with deadlines.",
    "score": -1,
    "questionID": "a4b66ea0-ce72-4f43-8a3c-c8b2645383c8"
  },
  {
    "category": "EI",
    "question": "You enjoy participating in team-based activities.",
    "score": 1,
    "questionID": "ff93ae4d-1880-4a6a-af0e-3cff6b8033c7"
  },
  {
    "category": "TF",
    "question":
        "You prioritize facts over people’s feelings when determining a course of action.",
    "score": 1,
    "questionID": "7027536d-598b-4f1c-bbf4-90b968d48787"
  },
  {
    "category": "EI",
    "question":
        "You usually prefer to be around others rather than on your own.",
    "score": 1,
    "questionID": "f205696d-4324-41c4-b457-4b2cd4f26a18"
  },
  {
    "category": "JP",
    "question":
        "You find it challenging to maintain a consistent work or study schedule.",
    "score": -1,
    "questionID": "bc7c8be9-7343-4b56-9de6-582159cc9697"
  },
  {
    "category": "TF",
    "question": "You often feel overwhelmed.",
    "score": -1,
    "questionID": "f2bb2f05-5363-4f8d-81c8-6554bd13476a"
  },
  {
    "category": "TF",
    "question":
        "People’s stories and emotions speak louder to you than numbers or data.",
    "score": -1,
    "questionID": "45558872-59da-4f30-b6d1-df38f11f6766"
  },
  {
    "category": "TF",
    "question": "You usually stay calm, even under a lot of pressure.",
    "score": 1,
    "questionID": "aaf56309-5081-44fd-932c-667d411d2a29"
  },
  {
    "category": "SN",
    "question":
        "You are drawn to various forms of creative expression, such as writing.",
    "score": -1,
    "questionID": "f7e50cfa-14a8-4d5e-a31f-077f2b021da7"
  },
  {
    "category": "TF",
    "question":
        "You usually feel more persuaded by what resonates emotionally with you than by factual arguments.",
    "score": -1,
    "questionID": "7ad5a664-28dc-430e-a0b9-a55ef9ed2762"
  },
  {
    "category": "TF",
    "question":
        "When making decisions, you focus more on how the affected people might feel than on what is most logical or efficient.",
    "score": -1,
    "questionID": "464d5097-9969-4590-979d-0de44cff1721"
  },
  {
    "category": "JP",
    "question": "You like to use organizing tools like schedules and lists.",
    "score": 1,
    "questionID": "9d77e536-f628-493a-b808-3f8ba5e0a70f"
  },
  {
    "category": "SN",
    "question":
        "You prefer tasks that require you to come up with creative solutions rather than follow concrete steps.",
    "score": -1,
    "questionID": "76b4c30a-5c76-4560-a104-52953543a0dd"
  },
  {
    "category": "EI",
    "question": "You avoid making phone calls.",
    "score": -1,
    "questionID": "89aace16-7d24-4bcb-aff7-bce722585e40"
  },
  {
    "category": "TF",
    "question": "You are not easily swayed by emotional arguments.",
    "score": 1,
    "questionID": "73e46930-2a8e-41c4-a0ea-732f7597aa94"
  },
  {
    "category": "JP",
    "question":
        "Your personal work style is closer to spontaneous bursts of energy than organized and consistent efforts.",
    "score": -1,
    "questionID": "6b4b63a5-8f94-44d0-bbd1-edbaabeb94d0"
  },
  {
    "category": "EI",
    "question": "You regularly make new friends.",
    "score": 1,
    "questionID": "24feeb34-53b6-4282-8e38-228f6c3c5df8"
  },
  {
    "category": "JP",
    "question":
        "You prefer to do your chores before allowing yourself to relax.",
    "score": 1,
    "questionID": "602e7913-4498-421d-ae9f-c418c494917e"
  }
];
