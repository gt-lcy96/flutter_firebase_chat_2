import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/pages/message/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/common/entities/msg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});

  Widget messageListItem(QueryDocumentSnapshot<Msg> item) {
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
      child: InkWell(
          onTap: () {},
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0.h, left: 0.w, right: 15.w),
                  child: SizedBox(
                    width: 54.w,
                    height: 54.h,
                    child: CachedNetworkImage(
                      imageUrl: item.data().from_uid == controller.token
                          ? item.data().to_avatar!
                          : item.data().from_avatar!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 54.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular((54))),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                      errorWidget: (context, url, error) => Image(
                        image: AssetImage('assets/images/feature-1.png'),
                      ),
                    ),
                  ),
                )
              ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    var item = controller.state.msgList[index];
                    return messageListItem(item);
                  }, childCount: controller.state.msgList.length))),
            ],
          )),
    );
  }
}
