import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_scheduler/holiAPI.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() {
  runApp(MyScheduler());
}

XmlDocument? XmlData;

void getXmlData(String _year, String _month) async {
  try {
    http.Response response = await http.get(
      Uri.parse(
          "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getAnniversaryInfo" +
              "?ServiceKey=" +
              "WC0IK73jwh73kgh1LD5BfH83ClmlZ40H326NPMXgj0dwGl6LDrmGY6VYN/CcBA2xd8T5K69f4n01AbAtcRsQcA==" + // decoding key
//              "WC0IK73jwh73kgh1LD5BfH83ClmlZ40H326NPMXgj0dwGl6LDrmGY6VYN%2FCcBA2xd8T5K69f4n01AbAtcRsQcA%3D%3D" + // encoding key
              "&pageNo=1&numOfRows=10&solYear=" +
              _year +
              "&solMonth=" +
              _month),
    );

    XmlData = XmlDocument.parse(response.body);
    print(response.statusCode);
  } catch (e) {
    print('fail to call url inromation');
  }
}

class MyScheduler extends StatefulWidget {
  @override
  _StateMyScheduler createState() => _StateMyScheduler();
}

class _StateMyScheduler extends State<MyScheduler> {
  late double _deviceHeight;
  late double _deviceWidth;
  late var _oneDayHeight;
  late var _oneDayWidth;
  late var _yearMonthHeight;
  late var _calanderSideSpace;
  late var _dayTitleHeight;

  // var _now = DateTime.now();
  //var _nowYear = int.parse(DateFWormat('yyyy').format(DateTime.now()));
  //var _nowMonth = int.parse(DateFormat('MM').format(DateTime.now()));
  //var _nowDay = getIntDay(DateFormat('E').format(DateTime.now()));
  var _nowDate = int.parse(DateFormat('dd').format(DateTime.now()));

  var _selYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  var _selMonth = int.parse(DateFormat('MM').format(DateTime.now()));

  late var _selMonth1stDay;
  late var _selMonthLastDate;

  final _appBarHeight = 56; // app bar default height = 56

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyScheduler main page',
      home: Builder(builder: (BuildContext context) {
        _deviceHeight = MediaQuery.of(context).size.height;
        _deviceWidth = MediaQuery.of(context).size.width;
        _yearMonthHeight = (_deviceHeight - _appBarHeight) * 0.1;
        _dayTitleHeight = (_deviceHeight - _appBarHeight) * 0.05;
        _oneDayHeight = (_deviceHeight - _appBarHeight) * 0.7 / 6;
        _oneDayWidth = (_deviceWidth) * 0.9 / 7;
        _calanderSideSpace = _deviceWidth * 0.05;

        // _now = new DateTime.now();
        // _nowYear = DateFormat('yyyy').format(_now);
        // _nowMonth = DateFormat('MM').format(_now);

        //_selYear = _nowYear;
        //_selMonth = '04'; //_nowMonth;
        // _nowDay = getIntDay(DateFormat('E').format(_now));
        _selMonth1stDay = getIntDay(
            DateFormat('E').format(DateTime.utc(_selYear, _selMonth, 1)));
        switch (_selMonth) {
          case 1:
          case 3:
          case 5:
          case 7:
          case 8:
          case 10:
          case 12:
            _selMonthLastDate = 31;
            break;
          case 4:
          case 6:
          case 9:
          case 11:
            _selMonthLastDate = 30;
            break;
          case 2:
            if (_selYear % 400 == 0)
              _selMonthLastDate = 29;
            else if (_selYear % 100 == 0)
              _selMonthLastDate = 28;
            else if (_selYear % 4 == 0)
              _selMonthLastDate = 29;
            else
              _selMonthLastDate = 28;
            break;
          default:
            _selMonthLastDate = 31;
            break;
        }

        //final resultCode = XmlData!.findAllElements('resultCode');
        //final items = XmlData!.findAllElements('item');

        try {
          getXmlData(_selYear.toString(),
              (_selMonth < 10 ? "0" : "") + _selMonth.toString());
          print(XmlData!
              .getElement('response')!
              .getElement('header')!
              .getElement('resultCode')!
              .text);
        } catch (e) {
          print('xml data get element exception');
        }
        //print(resultCode);
        //print(items);

        return _buildHome(context);
      }),
    );
  }

  Scaffold _buildHome(BuildContext context) {
    //_deviceHeight = MediaQuery.of(context).size.height;
    //_deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.blueGrey,
      elevation: 0, // appBar 자체의 그림자 정도, 높을수로 그림자 많아짐.

      leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.image),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildYearMonth(context),
        Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
        _buildCalender(context),
      ],
    );
  }

  Widget _buildYearMonth(BuildContext context) {
    return Row(children: [
      SizedBox(width: _calanderSideSpace),
      IconButton(
          onPressed: () {
            _selYear--;
            setState(() {});
          },
          icon: Icon(Icons.keyboard_double_arrow_left)),
      IconButton(
          onPressed: () {
            if (_selMonth == 1) {
              _selYear--;
              _selMonth = 12;
            } else {
              _selMonth--;
            }
            setState(() {});
          },
          icon: Icon(Icons.keyboard_arrow_left)),
      Container(
        child: Center(
            child: Text(
          _selYear.toString() +
              " " +
              ((_selMonth > 9) ? '' : '0') +
              _selMonth.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )),
        color: Colors.white,
        width: _oneDayWidth * 3,
        height: _yearMonthHeight,
      ),
      IconButton(
          onPressed: () {
            if (_selMonth == 12) {
              _selYear++;
              _selMonth = 1;
            } else {
              _selMonth++;
            }
            setState(() {});
          },
          icon: Icon(Icons.keyboard_arrow_right)),
      IconButton(
          onPressed: () {
            _selYear++;
            setState(() {});
          },
          icon: Icon(Icons.keyboard_double_arrow_right)),
      SizedBox(width: _calanderSideSpace),
    ]);
  }

  Widget _buildCalender(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: _calanderSideSpace),
        Column(
          children: [_DayTitle(context), _OneMonth(context)],
        ),
        SizedBox(width: _calanderSideSpace),
      ],
    );
  }

  Widget _DayTitle(BuildContext context) {
    return Row(
      children: [
        _EachDayTitle(context, 'SUN', true),
        _EachDayTitle(context, 'MON', false),
        _EachDayTitle(context, 'THU', false),
        _EachDayTitle(context, 'WED', false),
        _EachDayTitle(context, 'THR', false),
        _EachDayTitle(context, 'FRI', false),
        _EachDayTitle(context, 'SAT', true),
      ],
    );
  }

  Widget _EachDayTitle(BuildContext context, String day, bool isWeekend) {
    return Container(
        width: _oneDayWidth,
        height: _dayTitleHeight,
        child: Center(
          child: Text(
            day,
            style: TextStyle(
                color: isWeekend ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget _OneDay(BuildContext context, int dayId) {
    var _cellColorVar = 255 - dayId * 7;
    String _day = dayId <= _selMonth1stDay
        ? ''
        : dayId - _selMonth1stDay > _selMonthLastDate
            ? ''
            : (dayId - _selMonth1stDay).toString();
    return Column(
      children: [
        Container(
          child: Center(
              child: Text(
            _day,
            textAlign: TextAlign.center,
          )),
          height: _oneDayHeight * 0.5,
          width: _oneDayWidth,
        ),
        Container(
          color: _day == ''
              ? null
              : Color.fromARGB(255, _cellColorVar, _cellColorVar, 120),
          height: _oneDayHeight * 0.1,
          width: _oneDayWidth,
        ),
        Container(
          color: _day == ''
              ? null
              : Color.fromARGB(255, _cellColorVar, 120, _cellColorVar),
          height: _oneDayHeight * 0.1,
          width: _oneDayWidth,
        ),
        Container(
          color: _day == ''
              ? null
              : Color.fromARGB(255, 120, _cellColorVar, _cellColorVar),
          height: _oneDayHeight * 0.1,
          width: _oneDayWidth,
        ),
        SizedBox(
          height: _oneDayHeight * 0.2,
          width: _oneDayWidth,
        ),
      ],
    );

    /*
    Container(
      color: Color.fromARGB(255, _cellColorVar, _cellColorVar, 120),
      height: _oneDayHeight,
      width: _oneDayWidth,
    );
    */
  }

  Widget _OneWeek(BuildContext context, int weekId) {
    return Row(
      children: [
        _OneDay(context, weekId * 7 + 1),
        _OneDay(context, weekId * 7 + 2),
        _OneDay(context, weekId * 7 + 3),
        _OneDay(context, weekId * 7 + 4),
        _OneDay(context, weekId * 7 + 5),
        _OneDay(context, weekId * 7 + 6),
        _OneDay(context, weekId * 7 + 7),
      ],
    );
  }

  Widget _OneMonth(BuildContext context) {
    return Column(children: [
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
      _OneWeek(context, 0),
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
      _OneWeek(context, 1),
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
      _OneWeek(context, 2),
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
      _OneWeek(context, 3),
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
      _OneWeek(context, 4),
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
      _OneWeek(context, 5),
      Container(width: _oneDayWidth * 7, height: 1, color: Colors.grey),
    ]);
  }
}

int getIntDay(String _strDay) {
  int res;
  switch (_strDay) {
    case 'Sun':
      res = 0;
      break;
    case 'Mon':
      res = 1;
      break;
    case 'Tue':
      res = 2;
      break;
    case 'Wed':
      res = 3;
      break;
    case 'Thr':
      res = 4;
      break;
    case 'Fri':
      res = 5;
      break;
    case 'Sat':
      res = 6;
      break;
    default:
      res = 0;
      break;
  }

  return res;
}
