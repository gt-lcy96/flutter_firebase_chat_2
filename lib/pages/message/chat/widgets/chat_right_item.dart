import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/routes.dart';
import 'package:firebase_chat/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

Widget ChatRightItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.w),
            child: Container(
              margin: EdgeInsets.only(top: 0.w, right: 10.w),
              padding: EdgeInsets.only(
                  top: 10.w, left: 15.w, right: 10.w, bottom: 10.w),
              decoration: BoxDecoration(
                gradient: AppColors.chatGradient,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
              ),
              child: item.type == "text"
                  ? Text("${item.content}")
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 90.w,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.Photoimgview,
                            parameters: {"url": item.content ?? ""}
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: "${item.content}",
                        ),
                      )),
            ))
      ],
    ),
  );
}
