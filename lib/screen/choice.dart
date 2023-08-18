import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:SKT_FLY_AI/screen/diary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ChoiceScreen(),
    );
  }
}

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  TextEditingController cartoonNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime? selectedDateTime;
  String selectedWhoWith = '누구랑';
  List<String> selectedMoods = [];
  String selectedWeather = ''; // New variable for Weather selection
  String selectedStyle = ''; // New variable for Art Style selection

  void _selectDateTime() async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
          );
        });
      }
    }
  }

  @override
  void dispose() {
    cartoonNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Color(0xffF1F2F6),
          elevation: 0,
          flexibleSpace: Column(
            children: [
              SizedBox(height: 28.0),
              SvgPicture.asset(
                'assets/icons/input/logo.svg',
                height: 95,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffF1F2F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 27.0),
              Text(
                '만화를 만들어 볼까요?',
                style: TextStyle(
                  color: Color(0xff3B4866),
                  fontSize: 24,
                  fontFamily: 'moebiusRegular',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Text(
                '만화 이름 (Name)',
                style: TextStyle(
                  color: Color(0xff3B4866),
                  fontSize: 16,
                  fontFamily: 'moebiusBold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 48,
                child: TextField(
                  controller: cartoonNameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffD9D9D9)), // 변경된 부분
                    ),
                    hintText: '만화제목을 입력하세요.',
                    hintStyle: TextStyle(
                      color: Color(0xff6E6E6E),
                      fontSize: 16,
                      fontFamily: 'moebiusRegular',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                '장소 (Place)',
                style: TextStyle(
                  color: Color(0xff3B4866),
                  fontSize: 16,
                  fontFamily: 'moebiusBold',
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 48,
                child: TextField(
                  controller: locationController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD9D9D9)),
                    ),
                    hintText: '방문하였거나 추억이 있는 장소를 입력하세요.',
                    hintStyle: TextStyle(
                      color: Color(0xff6E6E6E),
                      fontSize: 16,
                      fontFamily: 'moebiusRegular',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                '날짜 (Date)',
                style: TextStyle(
                  color: Color(0xff3B4866),
                  fontSize: 16,
                  fontFamily: 'moebiusBold',
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _selectDateTime,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDateTime != null
                            ? DateFormat('yyyy-MM-dd HH:mm')
                                .format(selectedDateTime!)
                            : '날짜와 시간',
                        style: TextStyle(
                          color: Color(0xff6E6E6E),
                          fontSize: 16,
                          fontFamily: 'moebiusRegular',
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/choice/day.svg',
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              /* 카테고리 */
              SizedBox(height: 24),
              Text(
                '카테고리(Category)',
                style: TextStyle(
                  color: Color(0xff3B4866),
                  fontSize: 16,
                  fontFamily: 'moebiusBold',
                ),
              ),
              SizedBox(height: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '누구랑(Who)',
                    style: TextStyle(
                      color: Color(0xff3B4866),
                      fontSize: 14,
                      fontFamily: 'moebiusBold',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildWhoWithButton('가족'),
                      buildWhoWithButton('친구'),
                      buildWhoWithButton('연인'),
                      buildWhoWithButton('혼자'),
                      buildWhoWithButton('반려동물'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 11),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0xffD9D9D9),
              ),
              SizedBox(height: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '분위기(Mood)',
                    style: TextStyle(
                      color: Color(0xff3B4866),
                      fontSize: 14,
                      fontFamily: 'moebiusBold',
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 7, // 가로 간격
                    children: buildMoodButtons(),
                  ),
                ],
              ),
              SizedBox(height: 11),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0xffD9D9D9),
              ),
              SizedBox(height: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '날씨(Weather)',
                    style: TextStyle(
                      color: Color(0xff3B4866),
                      fontSize: 14,
                      fontFamily: 'moebiusBold',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildWeatherButton('맑음'),
                      buildWeatherButton('흐림'),
                      buildWeatherButton('비'),
                      buildWeatherButton('눈'),
                      buildWeatherButton('천둥/번개'),
                    ],
                  ),
                ],
              ),
              // Check box
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '그림체(Drawing Style)',
                    style: TextStyle(
                      color: Color(0xff3B4866),
                      fontSize: 16,
                      fontFamily: 'moebiusBold',
                    ),
                  ),
                  SizedBox(height: 8),
                  buildArtStyleCheckbox('AI 그림체'),
                  SizedBox(height: 8), // 체크박스 간 간격 조절
                  buildArtStyleCheckbox('웹툰 그림체'),
                ],
              ),
              SizedBox(height: 28),
              SizedBox(
                width: 358,
                height: 51,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiaryScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff727DBC),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '이야기 작성하러 가기',
                    style:
                        TextStyle(fontSize: 18, fontFamily: 'moebiusRegular'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWhoWithButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedWhoWith = text;
        });
      },
      style: ElevatedButton.styleFrom(
        primary:
            selectedWhoWith == text ? Color(0xff727DBC) : Colors.transparent,
        elevation: 0,
        side: BorderSide(color: Color(0xff727DBC)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'moebiusRegular',
          fontSize: 14,
          color: selectedWhoWith == text ? Colors.white : Color(0xff3B4866),
        ),
      ),
    );
  }

  List<String> moodOptions = [
    '따스함',
    '고요한',
    '즐거운',
    '감동적인',
    '흥미진진',
    '환상적인',
    '차가움',
    '평화로운',
    '상쾌함',
    '엄숙함',
  ];

  List<Widget> buildMoodButtons() {
    return moodOptions.map((mood) {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            if (selectedMoods.contains(mood)) {
              selectedMoods.remove(mood);
            } else {
              selectedMoods.add(mood);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          primary: selectedMoods.contains(mood)
              ? Color(0xff727DBC)
              : Colors.transparent,
          elevation: 0,
          side: BorderSide(color: Color(0xff727DBC)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(
          mood,
          style: TextStyle(
            fontFamily: 'moebiusRegular',
            fontSize: 14,
            color:
                selectedMoods.contains(mood) ? Colors.white : Color(0xff3B4866),
          ),
        ),
      );
    }).toList();
  }

  Widget buildWeatherButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedWeather = text;
        });
      },
      style: ElevatedButton.styleFrom(
        primary:
            selectedWeather == text ? Color(0xff727DBC) : Colors.transparent,
        elevation: 0,
        side: BorderSide(color: Color(0xff727DBC)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'moebiusRegular',
          fontSize: 14,
          color: selectedWeather == text ? Colors.white : Color(0xff3B4866),
        ),
      ),
    );
  }

  Widget buildArtStyleCheckbox(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedStyle == text
              ? Color(0xff727DBC)
              : Color(0xffD9D9D9), // 선택 여부에 따라 테두리 색 변경
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Checkbox(
            value: selectedStyle == text,
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  selectedStyle = text;
                }
              });
            },
            activeColor: Color(0xff727DBC), // 체크됐을 때 색상
            checkColor: Color(0xffFFFFFF), // 체크 안됐을 때 체크 표시 색상
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'moebiusRegular',
              fontSize: 14,
              color: Color(0xff3B4866),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
    );
  }

  // void _showResultDialog() {
  //   // ... (이하 코드는 생략)
  // }
}
