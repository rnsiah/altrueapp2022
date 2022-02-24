import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/validationCubit.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

class IntroductionSlider extends StatefulWidget {
  IntroductionSlider({
    Key? key,
  }) : super(key: key);

  @override
  _IntroductionSliderState createState() => _IntroductionSliderState();
}

class _IntroductionSliderState extends State<IntroductionSlider> {
  List<Slide> slides = [];
  late Function goToTab;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    slides.add(new Slide(
        title: 'Welcome',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(new Slide(
        title: 'Learn',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(new Slide(
        title: 'Do Something',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(new Slide(
        title: 'Get Rewarded',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
  }

  onDonePress() {
    this.goToTab(1);
  }

  void onTabChangeCompleted(index) {
    print(index);
  }

  Widget nextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35,
    );
  }

  Widget doneBtn(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.done,
          color: Colors.green,
          size: 35,
        ),
        onPressed: () => Navigator.of(context).popAndPushNamed('/signUp'));
  }

  Widget skipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.amber,
      size: 35,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
      overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
    );
  }

  List<Widget> renderTabList() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide current = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60, top: 60),
          child: ListView(
            children: [
              // GestureDetector(
              //   child: Image.asset(
              //     current.pathImage!,
              //     width: 200,
              //     height: 200,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Container(
                child: Text(
                  current.title!,
                  style: current.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              // Container(
              //   child: Text(
              //     current.description!,
              //     style: current.styleDescription,
              //     textAlign: TextAlign.center,
              //     maxLines: 5,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // )
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      renderSkipBtn: this.skipBtn(),
      skipButtonStyle: myButtonStyle(),
      renderNextBtn: this.nextBtn(),
      nextButtonStyle: myButtonStyle(),
      renderDoneBtn: doneBtn(context),
      doneButtonStyle: myButtonStyle(),
      colorDot: Colors.amber,
      sizeDot: 16,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: this.renderTabList(),
      backgroundColorAllSlides: Colors.black,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
      onDonePress: () {
        context.read<ValidationCubit>().showSignUp();
        userRepository.introDone();
      },
      scrollPhysics: BouncingScrollPhysics(),
      hideStatusBar: true,
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
