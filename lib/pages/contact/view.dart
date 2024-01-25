import 'package:firebase_chat/common/values/values.dart';
import 'package:firebase_chat/common/widgets/widgets.dart';

import 'index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_chat/pages/contact/widget/contact_list.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return transparentAppBar(
        title: Text(
          "Contact",
          style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize:18.sp,
            fontWeight: FontWeight.w600,
          ),
        )
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: ContactList(),
    );
  }
}
