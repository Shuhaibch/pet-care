import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';

import '../../../../models/all_data.dart';

ValueNotifier<List<Post>> postListNotifier = ValueNotifier([]);
ValueNotifier<List<Report>> reportListNotifier = ValueNotifier([]);
ValueNotifier<List<AllData>> allDataNOtifier = ValueNotifier([]);
