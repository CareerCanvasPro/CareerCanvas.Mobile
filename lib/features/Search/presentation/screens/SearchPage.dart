import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/core/Dependencies/setupDependencies.dart';
import 'package:career_canvas/features/Career/data/models/CoursesModel.dart';
import 'package:career_canvas/features/Search/presentation/getx/controllers/searchController.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  late final GlobalSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = getIt<GlobalSearchController>();
    if (searchController.courses.value == null) {
      searchController.getCoursesRecomendation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            elevation: 3,
            color: scaffoldBackgroundColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      onFieldSubmitted: (value) {
                        focusNode.unfocus();
                        searchController.searchCourses(value);
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        isCollapsed: false,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset(
                      "assets/svg/icons/search_icon.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Obx(() {
            if (searchController.isLoading.value) {
              return Expanded(
                child: Container(
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        primaryBlue,
                      ),
                    ),
                  ),
                ),
              );
            }
            if (searchController.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  searchController.errorMessage.value,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }
            if (searchController.courses.value == null ||
                searchController.courses.value!.data == null ||
                searchController.courses.value!.data!.courses == null) {
              return const Center(child: Text('No Courses Available'));
            }

            return Expanded(
              child: Column(
                children: [
                  Text(
                    searchController.searchQuery.value.isEmpty
                        ? 'Recomended Courses'
                        : 'Search Result for: "${searchController.searchQuery.value}"',
                    style: getCTATextStyle(
                      context,
                      16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  (searchController.courses.value == null ||
                          searchController.courses.value!.data == null ||
                          searchController.courses.value!.data!.courses ==
                              null ||
                          searchController
                              .courses.value!.data!.courses!.isEmpty)
                      ? Center(
                          child: Text(
                            'No Courses Available',
                            style: getCTATextStyle(
                              context,
                              20,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return getCourseItem(
                                  context,
                                  searchController
                                      .courses.value!.data!.courses![index]);
                            },
                            itemCount: searchController
                                .courses.value!.data!.courses!.length,
                          ),
                        ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget getCourseItem(BuildContext context, CoursesModel course) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      padding: const EdgeInsets.only(right: 16.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: 120,
            height: 100,
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: course.image,
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  primaryBlue,
                ),
              )),
              errorWidget: (context, url, error) => Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    child: Text(
                      course.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: getCTATextStyle(
                        context,
                        16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    course.authors.first,
                    style: getBodyTextStyle(context, 12, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Text(
                        "${formatNumber(course.studentCount)} Students",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: orangeStar, size: 18),
                      SizedBox(width: 4),
                      Text(
                        "${course.rating} (${formatNumber(course.ratingCount ?? 0)})",
                        style: getCTATextStyle(
                          context,
                          12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatNumber(num value) {
    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B'; // Billion
    } else if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M'; // Million
    } else if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K'; // Thousand
    } else {
      return value.toString(); // No formatting needed
    }
  }
}
