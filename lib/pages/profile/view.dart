import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/values/values.dart';
import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:firebase_chat/pages/profile/index.dart';
import 'package:firebase_chat/pages/profile/widgets/head_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  AppBar _buildAppbar() {
    return transparentAppBar(
        title: Text("Profile",
            style: TextStyle(
                color: AppColors.primaryBackground,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)));
  }

  Widget MeItem(MeListItem item) {
    return Container(
      height: 56.h,
      color: AppColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.only(top: 0.h, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: () {
          if(item.route == "/logout") {
            controller.onLogOut();
          }
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Container(
                    height: 56.h,
                    child: Image(
                      image: AssetImage(item.icon ?? ""),
                      width: 40.w,
                      height: 40.h,
                    )),
                Container(
                    margin: EdgeInsets.only(left: 14.w),
                    child: Text(
                      item.name ?? "",
                      style: TextStyle(
                          color: AppColors.thirdElement,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp),
                    ))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Image(
                    image: AssetImage("assets/icons/ang.png"),
                    width: 15.w,
                    height: 15.h,
                  ))
                ],
              )
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Obx(() => CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.h,
                    horizontal: 0.w,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: controller.state.head_detail.value == null
                        ? Container()
                        : HeadItem(controller.state.head_detail.value!),
                  )),
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 0.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var item = controller.state.meListItem[index];
                        return MeItem(item);
                      },
                      childCount: controller.state.meListItem.length,
                    ),
                  )),
            ],
          )),
    );
  }
}
