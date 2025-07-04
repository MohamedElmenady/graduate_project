import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/core/healpers/constants.dart';
import 'package:graduate_project/feature/appointment/data/appointmentRequest.dart';
import 'package:graduate_project/feature/appointment/logic/bookingCubit.dart';
import 'package:graduate_project/feature/appointment/logic/bookingState.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (appointment1Id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment ID not found')),
      );
      return;
    }

    final request = PaymentRequest(
      appointmentId: appointment1Id!,
      amount: double.parse(_amountController.text),
    );

    context.read<BookingCubit>().submitPayment(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Make Payment")),
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Booking and Payment successful")),
            );
            Navigator.pop(context);
          } else if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null) {
                        return 'Invalid amount';
                      } else if (amount != 100) {
                        return 'Amount must be exactly 100 EGP';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is PaymentLoading ? null : _submit,
                    child: state is PaymentLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Pay"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
