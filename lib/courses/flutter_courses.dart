// Mobile Development Courses Aggregator
//
// This file combines the Mobile Development curriculum
// into a single list for the application.

import 'package:flutter/material.dart';
import '../models/app_course.dart';
import 'mobile_development_courses.dart';

final List<AppCourse> flutterCourses = [
  ...mobileDevelopmentCourses,
];
