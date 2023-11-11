import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_food/config/app_color.dart';
import 'package:safe_food/config/app_text_style.dart';
import 'package:video_player/video_player.dart';

import '../../../provider/facebook_provider.dart';
import '../../../provider/google_provider.dart';
import '../login/login.dart';
import '../register/register.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({
    super.key,
  });
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/videos/video_introduce.mp4')
          ..initialize().then((_) {
            setState(() {
              _controller.play();
              _controller.setLooping(true);
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              if (_controller.value.isPlaying) {
                setState(() {
                  _controller.pause();
                });
              } else {
                setState(() {
                  _controller.play();
                });
              }
            },
            child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                width: size.width,
                height: 390,
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container()),
          ),
          const Text(
            'E-SHOPPING',
            style: AppTextStyle.heading1Medium,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: size.width - 32,
            margin: const EdgeInsets.only(bottom: 12),
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppTheme.yellow)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/kakaotalk.png'),
                  const SizedBox(
                    // width: 282,
                    child: Text(
                      'Đăng nhập bằng KakaoTalk',
                      style: AppTextStyle.heading3Black,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width - 32,
            height: 44,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppTheme.green)),
              onPressed: () {
                Provider.of<FacebookProvider>(context, listen: false).login();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/LogoFacebook.png'),
                  const SizedBox(
                    // width: 282,
                    child: Text(
                      'Đăng nhập bằng Facebook',
                      style: AppTextStyle.heading3Light,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width - 32,
            height: 44,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.black)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/LogoApple.png'),
                  const SizedBox(
                    // width: 282,
                    child: Text(
                      'Đăng nhập bằng Apple',
                      style: AppTextStyle.heading3Light,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width - 32,
            height: 44,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: Colors.grey, width: 1.5, style: BorderStyle.solid)),
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white)),
              onPressed: () {
                Provider.of<GoogleProvider>(context, listen: false).logIn();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/LogoGoogle.png'),
                  const SizedBox(
                    // width: 282,
                    child: Text(
                      'Đăng nhập bằng Google',
                      style: AppTextStyle.heading3Black,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: const Text(
                  'Đăng kí bằng Email',
                  style: AppTextStyle.heading4Black,
                ),
              ),
              const Text(
                '|',
                style: TextStyle(
                    height: 1.2,
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text(
                    'Đăng nhập bằng Email',
                    style: AppTextStyle.heading4Black,
                  )),
            ]),
          ),
        ]),
      ),
    );
  }
}
