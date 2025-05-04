// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_canvas/src/constants.dart';
import 'package:flutter/material.dart';

import 'package:career_canvas/features/Career/data/models/CareerTrends.dart';
import 'package:get/get.dart';

class CareerTrends extends StatefulWidget {
  static const String routeName = '/careerTrends';
  final Career career;
  final UniqueKey heroTag;
  const CareerTrends({
    Key? key,
    required this.career,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<CareerTrends> createState() => _CareerTrendsState();
}

class _CareerTrendsState extends State<CareerTrends> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Career Trends Details',
          style: getCTATextStyle(
            context,
            16,
            color: Colors.black,
          ),
        ),
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: width / 16 * 9,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Hero(
                tag: widget.heroTag,
                child: CachedNetworkImage(
                  imageUrl: widget.career.image,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        primaryBlue,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.career.name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.career.description}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
