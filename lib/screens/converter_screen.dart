import 'package:flutter/material.dart';
import 'package:advanced_mayan_numeral_converter/helpers/classifier_list.dart';
import 'package:advanced_mayan_numeral_converter/generated/l10n.dart';
import 'package:advanced_mayan_numeral_converter/helpers/calculator.dart';
import 'package:advanced_mayan_numeral_converter/screens/configuration_screen.dart';
import 'package:advanced_mayan_numeral_converter/helpers/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConverterScreen extends StatefulWidget {
  final LocaleChangeCallback onLocaleChange;
  final Future<SharedPreferencesWithCache> prefs;
  const ConverterScreen({super.key, required this.onLocaleChange, required this.prefs});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String selectedClassifier = "p'éel";
  String finalWord = "";
  String currentPageTitle = "";
  String selectedTitlePage = "";
  List<int> numberList = [ ];
  bool firstSpawn = true;
  bool showHint = true;
  int submittedValue = 0;

  // Glyph to number
  List<int> reverseNumberList = [ ];
  int numberIndex = 0;
  int currentNumberIndex = 0;
  int finalNumber = 0;
  int totalPages = 2;
  String finalWordNumber = "";

  final codeStartValue = 65;
  int pageIndex = 0;
  bool showNumberList = false;
  FixedExtentScrollController fixedExtentScrollController = FixedExtentScrollController();

  late final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<String> pageTitles = [
      S.of(context).titleSectionOne,
      S.of(context).titleSectionTwo,
    ];
    selectedTitlePage = pageTitles[pageIndex];

    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //       ConfigurationScreen(onLocaleChange: widget.onLocaleChange, prefs: widget.prefs,)));
        // }, icon: const Icon(Icons.settings))],
        centerTitle: true,
        title: Text(selectedTitlePage),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xffB5BD68),
                ),
                child: Center(
                  child: Text(
                    S.of(context).classifierTitle,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                )
            )
          ] + List.generate(classifierList.length, (i) =>
              classifierCard(i)),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: PageController(viewportFraction: 1.0),
            onPageChanged: (i){
              debugPrint(i.toString());
              setState(() {
                showHint = false;
                selectedTitlePage = pageTitles[i];
              });},
            children: [
              hoverCardWidget(numberToGlyphWidgets(), const Color(0xffB5BD68)),
              hoverCardWidget(glyphToNumberWidgets(), const Color(0xffB5BD68)),
            ],
          ),
          Visibility(
            visible: showNumberList,
            child: Align(
              alignment: Alignment.center,
              child: ListWheelScrollView(
                controller: fixedExtentScrollController,
                physics: const FixedExtentScrollPhysics(),
                itemExtent: 60.0,
                children: List.generate(19, (index) => cardSelector(index)),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: Builder(
          //       builder: (context) {
          //         return TextButton(
          //           style: TextButton.styleFrom(
          //             backgroundColor: Colors.white,
          //             foregroundColor: Colors.black,
          //             padding: const EdgeInsets.all(15.0),
          //             textStyle: const TextStyle(
          //               fontSize: 20.0,
          //             ),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10.0),
          //             )
          //           ),
          //           onPressed: () {
          //             Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //               const ClassifierScreen()));
          //             },
          //             child: Text(S.of(context).classifierButton),
          //         );
          //       }
          //     )
          //   )
          // ),
          Visibility(
            visible: showHint,
            child: Align(
              alignment: Alignment.lerp(Alignment.topRight, Alignment.centerRight, 0.5)!,
              child: const AnimatedHintWidget(),
            ),
          )
        ],
      ),
    );
  }
  Widget cardSelector(int number) {
    return GestureDetector(
        onTap: (){
          setState(() {
            reverseNumberList[currentNumberIndex] = number;
            showNumberList = false;
            finalWordNumber = generatorFunction(reverseNumberList.reversed.toList());
            finalNumber = fromGlyphToNumber(reverseNumberList);
          });
          debugPrint(finalWordNumber);
          debugPrint(finalNumber.toString());
          debugPrint(reverseNumberList.toString());
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              String.fromCharCode(number + codeStartValue),
              style: const TextStyle(
                fontFamily: "Glyphs",
                height: 0.7,
                fontSize: 50,
              ),
            ),
          ),
        ));
  }
  Widget glyphStackWidget(int number){
    String codeGlyph = String.fromCharCode(number + codeStartValue);
    return Text(
      codeGlyph,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: "Glyphs",
        height: 0.7,
        fontSize: 120,
      ),
    );
  }
  Widget classifierCard(int index) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedClassifier = classifierList[index][1];
        });
        Navigator.pop(context);
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            classifierList[index][0],
            style: const TextStyle(
                fontSize: 20.0),),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
                classifierList[index][1]
            ),
          ),
        ],
      ),
    );
  }
  Widget hoverCardWidget(List<Widget>children, Color color){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: color,
            boxShadow: [
              BoxShadow(
                spreadRadius: 5.0,
                blurRadius: 7.0,
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 3),
              ),
            ]
        ),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
  List<Widget> numberToGlyphWidgets(){
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          finalWord,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40.0,
          ),),),
      Column(
        children: List.generate(numberList.length, (i) => glyphStackWidget(numberList[i])),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0,
            top: 30.0, bottom: 50.0),
        child: TextField(
          controller: _textController,
          autofocus: false,
          onTap: (){
            setState(() {
              showHint = false;
              firstSpawn = false;
            });
          },
          onSubmitted: (String val){
            setState(() {
              submittedValue = int.parse(val);
              numberList = calculateNumberList(submittedValue);
              finalWord = generateNumberWordMZ(numberList);
            });
          },
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30.0,
          ),
          cursorColor: Colors.black.withOpacity(0.5),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: S.of(context).numberFieldHint,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            iconColor: Colors.black,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    ];
  }
  List<Widget> glyphToNumberWidgets(){
    return <Widget>[
      IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          onPressed: (){
            if (numberIndex == 4){
              return;
            }
            reverseNumberList.add(0);
            currentNumberIndex = numberIndex;
            numberIndex++;
            debugPrint(numberIndex.toString());
            setState(() {
              showNumberList = true;
            });
          },
          icon: const Icon(Icons.add,
            size: 50.0,)),
      Column(
        children: List.generate(reverseNumberList.length, (index) {
          int correctIndex = numberIndex - (index + 1);
          return glyphSelector(correctIndex, reverseNumberList[correctIndex]);
        }),),
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Text(
          finalWordNumber,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
      Text(
        finalNumber.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40.0,
        ),
      ),
    ];
  }
  Widget glyphSelector(int index, int number){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 48.0,),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  currentNumberIndex = index;
                  showNumberList = true;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              child: glyphStackWidget(number)),
          IconButton(
              onPressed: (){
                // remove the corresponding glyph.
                reverseNumberList.removeAt(index);
                numberIndex--;
                debugPrint(numberIndex.toString());
                setState(() {
                  finalWordNumber = generateNumberWordMZ(reverseNumberList.reversed.toList());
                  finalNumber = fromGlyphToNumber(reverseNumberList);
                });
              },
              icon: const Icon(Icons.remove_circle_outline,
                color: Color(0xffB02F30),
                size: 30.0,
              ))
        ],
      ),
    );
  }
}

class AnimatedHintWidget extends StatefulWidget {
  const AnimatedHintWidget({super.key});
  @override
  State<AnimatedHintWidget> createState() => _AnimatedHintWidget();
}

class _AnimatedHintWidget extends State<AnimatedHintWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat()..addListener(() => setState(() {}));

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.5, 0.0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

  late final CurvedAnimation _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutExpo,
  );
  @override
  void dispose() {
    // TODO: implement dispose
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TickerFuture tickerFuture = _controller.repeat();
    tickerFuture.timeout(const Duration(seconds: 2 * 4), onTimeout: () {
      _controller.forward(from: 0);
      _controller.stop(canceled: true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          width: 70,
          height: 160,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/icons/swipe_icon.png')),
          ),
        ),
      ),
    );
  }
}
