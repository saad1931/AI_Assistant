import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:personalassistant/Image_AI/image_home_screen.dart';
import 'package:personalassistant/chat_AI/speechscreen.dart';
import 'package:personalassistant/feature_box.dart';

class HomeAI extends StatelessWidget {
  const HomeAI({super.key});

  @override
  Widget build(BuildContext context) {
    int start = 200;
    int delay = 200;
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: BounceInDown(
          child: const Text('AI Corner'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            // virtual assistant picture
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(209, 243, 249, 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/virtualAssistant.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             // chat bubble
            FadeInRight(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                        'Hello, Welcome to AI corner!',
                    style: TextStyle(
                      // fontFamily: 'Cera Pro',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SlideInLeft(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, left: 22),
                child: const Text(
                  'Here are few features of AI Corner',
                  style: TextStyle(
                    // fontFamily: 'Cera Pro',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                 SlideInLeft(
                  delay: Duration(milliseconds: start),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>const SpeechScreen()));
                    },
                    child: const FeatureBox(
                      color: Colors.green,
                      headerText: 'Chat with AI',
                      description:
                          'A smarter way to stay organized and informed with AI',
                    ),
                  ),
                ),
                 SlideInLeft(
                  delay: Duration(milliseconds: start + delay),
                  child: GestureDetector(
                    onTap: (){
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>const ImageHomeScreen()));
                    },
                    child: const FeatureBox(
                      color: Color.fromARGB(255, 29, 93, 62),
                      headerText: 'Generate AI Images',
                      description:
                          'Get inspired and stay creative with your personal assistant powered by Dall-E',
                    ),
                  ),
                ),
              ],
            )
          ]
        )
      )
    );
  }
}