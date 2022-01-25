import 'package:academyproject/components/widgets/buttonwidget.dart';
import 'package:academyproject/components/widgets/pageviewerwidget.dart';
import 'package:academyproject/pages/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(),

      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        elevation: 0,
          title: const Text("Entertainment App"),

      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/redvector.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 94),
          child: PageView(
            controller: pageController,
            onPageChanged: (int index){
              setState(() {
                pageIndex = index;
              });
            },
            // controller: pageController,
            children: [

              // 1st Page
              PageViewerWidget(
                text1: 'ENTA',
                text2: 'Read Terms and Conditions',
                text3: 'Accept the Terms and Conditions',
                text4: 'Next',
                text5: 'Try Out Enta',
                onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context) =>const LoginScreen()));},
                onClicked: () => pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.bounceInOut),
                image: 'musics.jpg',

              ),


              // 2nd Page
              PageViewerWidget(
                text1: 'Movies',
                text2: '',
                text3: 'Enjoy your movies, series, animes and Trailers from your personal devices',
                text4: 'Watch Movies',
                text5: '',
                onTap:(){},
                onClicked: () => pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.bounceInOut),
                image: 'smiley.png',

              ),


              // 3rd Page
              PageViewerWidget(
                text1: 'Music',
                text2: '',
                text3: 'Enjoy your music streams, offline, music videos and even download',
                text4: 'Next',
                text5: '',
                onTap:(){},
                onClicked: () => pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.bounceInOut),
                image: 'music.png',

              ),

              //4th Page
              PageViewerWidget(
                text1: 'Novels & Mangas',
                text2: '',
                text3: 'Book readers with this feature can enjoy the favourite novels and mangas straight from your device',
                text4: 'Get Started',
                text5: '',
                onTap:(){},
                onClicked: (){
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const  LoginScreen()));},
                image: 'icons8_book_128px.png',

              ),

            ],
          ),
        ),
      ),
      ),
    );
  }
}
