import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF8DCBC8)),
          borderRadius: BorderRadius.horizontal(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF8DCBC8), backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  child: Text('Data da Reserva'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF8DCBC8), backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  child: Text('Horário da Reserva'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'OBS: Tolerância de 15mn após o horário de reserva',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
