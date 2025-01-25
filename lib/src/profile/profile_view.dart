import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  static const String routeName = "/userProfile";

  @override
  Widget build(BuildContext context) {
    ScrollController? controller = ScrollController();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      //backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          _profileHeaderSection(context),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  // About Me Section
                  _aboutMeSection(context),

                  // Work Experience Section
                  _workExperianceSection(context),

                  // Education Section
                  _educationSection(context),
                  // Skills Section
                  _skillsSection(context),

                  // Language Section
                  _languageSection(context),

                  // Appreciation Section
                  _appreciationSection(context),

                  // Resume section

                  _resumeSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _profileHeaderSection(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(25),
          bottomEnd: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://ugv.edu.bd/images/teacher_images/1581406453.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.ios_share),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Razibul Hasan Raj",
              style: getHeadlineTextStyle(
                context,
                18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Dhaka, Bangladesh",
              style: getBodyTextStyle(context, 12, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  "assets/images/madels/Bronze_Medal.png",
                  semanticLabel: "Bronze Medal",
                ),
                Image.asset(
                  "assets/images/madels/Silver_Medal.png",
                  semanticLabel: "Silver Medal",
                ),
              ],
            ),
            // const SizedBox(height: 8),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "120k",
                        style: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: " Followers",
                        style: getBodyTextStyle(
                          context,
                          12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "23k",
                        style: getCTATextStyle(
                          context,
                          14,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: " Following",
                        style: getBodyTextStyle(
                          context,
                          12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  onPressed: () {},
                  label: Text(
                    "Edit ",
                    style: getBodyTextStyle(
                      context,
                      14,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    "assets/svg/icons/Edit.svg",
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _aboutMeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_About_me.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "About Me",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lectus id commodo egestas metus interdum dolor.",
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Container _workExperianceSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Work_experience.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Work Experience",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Add.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          getExperianceItem(
            context,
            title: "Manager",
            company: "Amazone, Inc.",
            startDate: DateTime.now(),
            endDate: DateTime.now().add(
              const Duration(days: 256),
            ),
          ),
          getExperianceItem(
            context,
            title: "AI Engineer",
            company: "Google, LLC.",
            startDate: DateTime.now(),
            endDate: DateTime.now().add(
              const Duration(days: 368),
            ),
          ),
        ],
      ),
    );
  }

  Container _educationSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Education.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Education",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Add.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          getExperianceItem(
            context,
            title: "Information Security Engineer",
            company: "Oxford University",
            startDate: DateTime.now(),
            endDate: DateTime.now().add(
              const Duration(days: 256),
            ),
          ),
          getExperianceItem(
            context,
            title: "Software Engineer",
            company: "Harvard University",
            startDate: DateTime.now(),
            endDate: DateTime.now().add(
              const Duration(days: 368),
            ),
          ),
        ],
      ),
    );
  }

  Container _skillsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Skill.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Skills",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              getChipItem(
                context,
                title: "Leadership",
              ),
              getChipItem(
                context,
                title: "Teamwork",
              ),
              getChipItem(
                context,
                title: "Visioner",
              ),
              getChipItem(
                context,
                title: "Terget Oriented",
              ),
              getChipItem(
                context,
                title: "Consistent",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _languageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Language.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Languages",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              getChipItem(
                context,
                title: "Bengali",
              ),
              getChipItem(
                context,
                title: "Engllish",
              ),
              getChipItem(
                context,
                title: "Hindi",
              ),
              getChipItem(
                context,
                title: "Spanish",
              ),
              getChipItem(
                context,
                title: "French",
              ),
              getChipItem(
                context,
                title: "Russian",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _appreciationSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Appreciation.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Appreciation",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Add.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          getAppreciationItem(
            context,
            title: "Wireless Symposium (RWS)",
            organization: "Young Scientist",
            date: DateTime.now(),
          ),
          getAppreciationItem(
            context,
            title: "Nasa Space Apps Challenge",
            organization: "Local Champion",
            date: DateTime.now(),
          ),
        ],
      ),
    );
  }

  Container _resumeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        // vertical: 20,
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/icons/Icon_Appreciation.svg",
              ),
              const SizedBox(width: 8),
              const Text(
                "Resume",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Add.svg",
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.15),
            height: 24,
            thickness: 1,
          ),
          getResumeItem(context,
              title: "Tanvir Ahmed Khan - CV - Flutter Developer",
              size: "270kb",
              date: DateTime.now(),
              onRemove: () {}),
          getResumeItem(context,
              title: "Jamet kudasi - CV - UI/UX Designer",
              size: "430kb",
              date: DateTime.now(),
              onRemove: () {}),
          getResumeItem(context,
              title: "Jamet kudasi - CV - UI/UX Designer",
              size: "680kb",
              date: DateTime.now(),
              onRemove: () {}),
        ],
      ),
    );
  }

  String getFormatedDateForResume(DateTime date) {
    return "${DateFormat().add_d().add_MMM().add_y().format(date)} at ${DateFormat().add_jm().format(date)}";
  }

  Widget getResumeItem(
    BuildContext context, {
    required String title,
    required String size,
    required DateTime date,
    required Function()? onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/icons/PDF.svg",
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "$size . ${getFormatedDateForResume(date)}",
                  overflow: TextOverflow.ellipsis,
                  style: getBodyTextStyle(
                    context,
                    12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset("assets/svg/icons/Icon_Remove.svg"),
        ],
      ),
    );
  }

  Widget getChipItem(BuildContext context, {required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: getBodyTextStyle(
          context,
          14,
          color: Colors.black,
        ),
      ),
    );
  }

  String getFormatedDate(DateTime date) {
    return DateFormat().add_MMM().add_y().format(date);
  }

  String getDuration(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate).inDays;
    if (duration >= 365) {
      return "${duration ~/ 365} Years";
    }
    if (duration >= 30) {
      return "${duration ~/ 30} Months";
    }
    return "$duration Days";
  }

  Widget getExperianceItem(
    BuildContext context, {
    required String title,
    required String company,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: getCTATextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Text(
            company,
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text(
                "${getFormatedDate(startDate)} - ${getFormatedDate(endDate)}",
                style: getBodyTextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              Text(
                " . ",
                style: getBodyTextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              Text(
                getDuration(startDate, endDate),
                style: getBodyTextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAppreciationItem(
    BuildContext context, {
    required String title,
    required String organization,
    required DateTime date,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: getCTATextStyle(
                  context,
                  14,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/icons/Edit.svg",
              ),
            ],
          ),
          Text(
            organization,
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
          Text(
            getFormatedDate(date),
            style: getBodyTextStyle(
              context,
              14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
