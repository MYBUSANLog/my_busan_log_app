import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:busan_trip/screen/pay_screen.dart';

class BookingCalendarScreen extends StatefulWidget {
  @override
  _BookingCalendarScreenState createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime _today = DateTime.now();
  int _adultAlldayTickets = 0;
  int _teenAlldayTickets = 0;
  int _childAlldayTickets = 0;
  int _babyAlldayTickets = 0;
  int _adultAfterTickets = 0;
  int _teenAfterTickets = 0;
  int _childAfterTickets = 0;
  int _babyAfterTickets = 0;

  List<String> _ticketNames = [];
  List<String> _ticketPrices = [];
  List<int> _ticketQuantities = [];

  void _decrementTickets(String type) {
    setState(() {
      switch (type) {
        case 'adultAllday':
          if (_adultAlldayTickets > 0) _adultAlldayTickets--;
          break;
        case 'teenAllday':
          if (_teenAlldayTickets > 0) _teenAlldayTickets--;
          break;
        case 'childAllday':
          if (_childAlldayTickets > 0) _childAlldayTickets--;
          break;
        case 'babyAllday':
          if (_babyAlldayTickets > 0) _babyAlldayTickets--;
          break;
        case 'adultAfter':
          if (_adultAfterTickets > 0) _adultAfterTickets--;
          break;
        case 'teenAfter':
          if (_teenAfterTickets > 0) _teenAfterTickets--;
          break;
        case 'childAfter':
          if (_childAfterTickets > 0) _childAfterTickets--;
          break;
        case 'babyAfter':
          if (_babyAfterTickets > 0) _babyAfterTickets--;
          break;
      }
    });
  }

  void _incrementTickets(String type) {
    setState(() {
      switch (type) {
        case 'adultAllday':
          _adultAlldayTickets++;
          break;
        case 'teenAllday':
          _teenAlldayTickets++;
          break;
        case 'childAllday':
          _childAlldayTickets++;
          break;
        case 'babyAllday':
          _babyAlldayTickets++;
          break;
        case 'adultAfter':
          _adultAfterTickets++;
          break;
        case 'teenAfter':
          _teenAfterTickets++;
          break;
        case 'childAfter':
          _childAfterTickets++;
          break;
        case 'babyAfter':
          _babyAfterTickets++;
          break;
      }
    });
  }

  bool isAnyTicketSelected() {
    return _adultAlldayTickets > 0 ||
        _teenAlldayTickets > 0 ||
        _childAlldayTickets > 0 ||
        _babyAlldayTickets > 0 ||
        _adultAfterTickets > 0 ||
        _teenAfterTickets > 0 ||
        _childAfterTickets > 0 ||
        _babyAfterTickets > 0;
  }

  // void _populateTicketDetails() {
  //   _ticketNames.clear();
  //   _ticketPrices.clear();
  //   _ticketQuantities.clear();
  //
  //   if (_adultAlldayTickets > 0) {
  //     _ticketNames.add('종일권 - 어른');
  //     _ticketPrices.add(47000);
  //     _ticketQuantities.add(_adultAlldayTickets);
  //   }
  //   if (_teenAlldayTickets > 0) {
  //     _ticketNames.add('종일권 - 청소년');
  //     _ticketPrices.add('39,000원');
  //     _ticketQuantities.add(_teenAlldayTickets);
  //   }
  //   if (_childAlldayTickets > 0) {
  //     _ticketNames.add('종일권 - 어린이/경로');
  //     _ticketPrices.add('33,000원');
  //     _ticketQuantities.add(_childAlldayTickets);
  //   }
  //   if (_babyAlldayTickets > 0) {
  //     _ticketNames.add('종일권 - 베이비');
  //     _ticketPrices.add('12,000원');
  //     _ticketQuantities.add(_babyAlldayTickets);
  //   }
  //   if (_adultAfterTickets > 0) {
  //     _ticketNames.add('오후권 - 어른');
  //     _ticketPrices.add('36,000원');
  //     _ticketQuantities.add(_adultAfterTickets);
  //   }
  //   if (_teenAfterTickets > 0) {
  //     _ticketNames.add('오후권 - 청소년');
  //     _ticketPrices.add('32,000원');
  //     _ticketQuantities.add(_teenAfterTickets);
  //   }
  //   if (_childAfterTickets > 0) {
  //     _ticketNames.add('오후권 - 어린이/경로');
  //     _ticketPrices.add('30,000원');
  //     _ticketQuantities.add(_childAfterTickets);
  //   }
  //   if (_babyAfterTickets > 0) {
  //     _ticketNames.add('오후권 - 베이비');
  //     _ticketPrices.add('12,000원');
  //     _ticketQuantities.add(_babyAfterTickets);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '이용 날짜 선택',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return _selectedDay != null && isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay; // 날짜 선택
                      _focusedDay = focusedDay; // 포커스된 날짜 업데이트
                    });
                  },
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                        color: Colors.transparent
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.red,
                    ),
                    todayTextStyle: TextStyle(color: Colors.black),
                  ),
                  enabledDayPredicate: (day) {
                    return day.isAfter(_today.subtract(Duration(days: 0))); // 다음 날부터 선택 가능
                  },
                ),
              ),
              SizedBox(height: 20),
              if (_selectedDay != null) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
                  child: Column(
                    children: [
                      _ticketCounter(
                        'adultAllday',
                        _adultAlldayTickets,
                        '종일권 - 어른',
                        47000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'teenAllday',
                        _teenAlldayTickets,
                        '종일권 - 청소년',
                        39000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'childAllday',
                        _childAlldayTickets,
                        '종일권 - 어린이/경로',
                        33000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'babyAllday',
                        _babyAlldayTickets,
                        '종일권 - 베이비',
                        12000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'adultAfter',
                        _adultAfterTickets,
                        '오후권 - 어른',
                        36000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'teenAfter',
                        _teenAfterTickets,
                        '오후권 - 청소년',
                        32000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'childAfter',
                        _childAfterTickets,
                        '오후권 - 어린이/경로',
                        30000,
                      ),
                      SizedBox(height: 15),
                      _ticketCounter(
                        'babyAfter',
                        _babyAfterTickets,
                        '오후권 - 베이비',
                        12000,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: isAnyTicketSelected() && _selectedDay != null
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayScreen(
                        selectedDate: _selectedDay!,
                        ticketNames: _ticketNames,
                        ticketPrices: [10000],
                        ticketQuantities: _ticketQuantities,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e4194),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '다음',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketCounter(String type, int count, String label, int price) {
    bool isDecrementEnabled = count > 0;

    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    '${price}원',
                    style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: isDecrementEnabled
                        ? () => _decrementTickets(type)
                        : null,
                    child: Icon(
                      Icons.remove,
                      color: isDecrementEnabled ? Color(0xff0e4194) : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  '$count',
                  style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18),
                ),
                SizedBox(width: 15),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () => _incrementTickets(type),
                    child: Icon(
                      Icons.add,
                      color: Color(0xff0e4194),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
