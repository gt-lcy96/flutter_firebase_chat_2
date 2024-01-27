import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/pages/message/chat/widgets/message_list.dart';

import 'index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_chat/common/widgets/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  AppBar _buildAppBar() {
      return transparentAppBar(
        title: Text("Message",
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: MessageList(),
    );

  }
}
