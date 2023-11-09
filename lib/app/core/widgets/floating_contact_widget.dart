import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingContactWidget extends StatefulWidget {
  final String msg;
  const FloatingContactWidget({
    super.key,
    this.msg = 'Hi, I am interested to invest in a project',
  });

  @override
  State<FloatingContactWidget> createState() => _FloatingContactWidgetState();
}

class _FloatingContactWidgetState extends State<FloatingContactWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  void makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '8801798101013',
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  void openWhatsAppChat() async {
    const String phoneNumber = '8801798101013';
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
      queryParameters: {
        'text': widget.msg,
      },
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(
        launchUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        Bubble(
          title: "WhatsApp",
          iconColor: AppColor.primary,
          bubbleColor: AppColor.secondary,
          icon: Icons.wechat_outlined,
          titleStyle: TextStyle(
            fontSize: AppSize.fSixteen,
            color: AppColor.primary,
          ),
          onPress: () {
            openWhatsAppChat();
            // launchWhatsApp(phone: 01627465928, message: 'hi');
            // openWhatsapp(
            //   context: context,
            //   text: "Hello",
            //   number: "01627465928",
            // );
            _animationController.reverse();
          },
        ),
        //Floating action menu item
        Bubble(
          title: "Call",
          iconColor: AppColor.primary,
          bubbleColor: AppColor.secondary,
          icon: Icons.call_outlined,
          titleStyle: TextStyle(
            fontSize: AppSize.fSixteen,
            color: AppColor.primary,
          ),
          onPress: () {
            makePhoneCall();
            _animationController.reverse();
          },
        ),
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),

      // Floating Action button Icon color
      iconColor: AppColor.secondary,

      // Floating Action button Icon
      iconData: Icons.contacts,
      backGroundColor: AppColor.primary,
    );
  }
}
