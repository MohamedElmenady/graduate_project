import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/appointment/data/appointmentRequest.dart';
import 'package:graduate_project/feature/appointment/data/bookingService.dart';
import 'package:graduate_project/feature/appointment/logic/bookingCubit.dart';
import 'package:graduate_project/feature/appointment/logic/bookingState.dart';
import 'package:graduate_project/feature/appointment/paymentScreen.dart';

class BookingScreen extends StatefulWidget {
  final String doctorId;

  const BookingScreen({super.key, required this.doctorId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 30);

  final List<TimeOfDay> availableTimes = [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 8, minute: 30),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 9, minute: 30),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 10, minute: 30),
  ];

  void submit() {
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final request = AppointmentRequest(
      doctorId: widget.doctorId,
      date: selectedDateTime,
    );

    context.read<BookingCubit>().bookAppointment(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Appointment")),
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            /*ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.blue,
                  content: Text("Appointment booked successfully")),
            );*/
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                      create: (context) => BookingCubit(BookingService()),
                      child: const PaymentScreen()),
                ));
            //Navigator.pop(context);
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.red, content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Date",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${selectedDate.toLocal()}'.split(' ')[0]),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 7)),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                      child: const Text("Set Manual"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Available time",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: availableTimes.map((time) {
                    final selected = time == selectedTime;
                    return ChoiceChip(
                      label: Text(time.format(context)),
                      selected: selected,
                      onSelected: (_) => setState(() => selectedTime = time),
                    );
                  }).toList(),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: state is BookingLoading
                      ? CircularProgressIndicator.new
                      : submit,
                  child: state is BookingLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text("Continue"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
