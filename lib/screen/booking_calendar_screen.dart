import 'package:busan_trip/model/option_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:busan_trip/screen/pay_screen.dart';

import '../vo/item.dart';
import '../vo/option.dart';
import '../vo/user.dart';

class BookingCalendarScreen extends StatefulWidget {
  final Item item;

  const BookingCalendarScreen({Key? key, required this.item}) : super(key: key);

  @override
  _BookingCalendarScreenState createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  DateTime _today = DateTime.now();

  Map<int, int> optionQuantities = {};

  void _decrementTickets(int optionIndex) {
    setState(() {
      if (optionQuantities[optionIndex]! > 0) {
        optionQuantities[optionIndex] = optionQuantities[optionIndex]! - 1;
      }
    });
  }

  void _incrementTickets(int optionIndex) {
    setState(() {
      optionQuantities[optionIndex] = optionQuantities[optionIndex]! + 1;
    });
  }

  bool isAnyTicketSelected() {
    return optionQuantities.values.any((quantity) => quantity > 0);
  }

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
                    Provider.of<OptionModel>(context, listen: false).setOptions(widget.item.i_idx);
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
                      Consumer<OptionModel>(builder: (context, optionModel, child) {
                        return Column(
                          children: optionModel.options.asMap().entries.map((entry) {
                            Option option = entry.value;
                            int index = entry.key;
                            optionQuantities.putIfAbsent(index, () => 0);

                            return buildOptionListBox(
                              option: option,
                              option_quantity: optionQuantities[index]!,
                              onIncrement: () => _incrementTickets(index),
                              onDecrement: () => _decrementTickets(index),
                            );
                          }).toList(),
                        );
                      }),
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
                  // _selectedDay를 YYYY-MM-DD 형식의 문자열로 변환하여 전달
                  String formattedDate = _selectedDay != null
                      ? "${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}"
                      : '';

                  // 선택된 옵션을 리스트로 변환
                  List<Map<String, dynamic>> selectedOptions = optionQuantities.entries
                      .where((entry) => entry.value > 0)
                      .map((entry) => {
                    'op_name': widget.item.i_name, // 옵션 이름 설정
                    'op_price': Provider.of<OptionModel>(context, listen: false).options[entry.key].op_price,
                    'quantity': entry.value // 선택한 수량 설정
                  })
                      .toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayScreen(
                        item: widget.item,
                        selectedDate: formattedDate,
                        selectedOptions: selectedOptions,
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
}

class buildOptionListBox extends StatelessWidget {
  final Option option;
  final int option_quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  buildOptionListBox({
    required this.option,
    required this.option_quantity,
    required this.onIncrement,
    required this.onDecrement,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    bool isDecrementEnabled = option_quantity > 0;

    return Column(
      children: [
        Container(
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
                        '${option.op_name}',
                        style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Text(
                        '${option.op_price}원',
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
                        onTap: isDecrementEnabled ? onDecrement : null,
                        child: Icon(
                          Icons.remove,
                          color: isDecrementEnabled ? Color(0xff0e4194) : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      '${option_quantity}',
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
                        onTap: onIncrement,
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
        ),
        SizedBox(height: 15),
      ],
    );
  }
}