import 'package:firebase_chat/common/values/values.dart';
import 'package:firebase_chat/pages/message/photoView/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoImageViewPage extends GetView<PhotoImageViewController> {
  const PhotoImageViewPage({super.key});
  AppBar _buildAppBar() {
    return AppBar(
        bottom: PreferredSize(
      child: Container(
        color: AppColors.secondaryElement,
        height: 2.0.h,
      ),
      preferredSize: Size.fromHeight(1.0),
    ),
    title: Text(
      "PhotoView",
      style: TextStyle(
        color: AppColors.primaryText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(controller.state.url.value),
        ),
      ),
    );
  }
}
