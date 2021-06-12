import 'package:crypto_tracker/bloc/exchange/exchange_bloc.dart';
import 'package:crypto_tracker/common/appColors.dart';
import 'package:crypto_tracker/common/appStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    String dropdownFrom = BlocProvider.of<ExchangeBloc>(context).fromCoin;
    String dropdownTo = BlocProvider.of<ExchangeBloc>(context).toCoin;
    String quantity =
        BlocProvider.of<ExchangeBloc>(context).oldQuantity.toString();
    return Column(
      children: [
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Quantity:",
                  style: AppTextStyles.title,
                ),
                SizedBox(height: 40),
                Text(
                  "From:",
                  style: AppTextStyles.title,
                ),
                SizedBox(height: 40),
                Text(
                  "To:",
                  style: AppTextStyles.title,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10)),
                  width: 160,
                  child: TextField(
                    style: AppTextStyles.normal,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: quantity),
                    onChanged: (newQuantityValue) {
                      quantity = newQuantityValue;
                    },
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<ExchangeBloc, ExchangeState>(
                    builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(10)),
                    width: 160,
                    child: DropdownButton<String>(
                      style: AppTextStyles.normal,
                      dropdownColor: AppColors.primaryColor,
                      value: dropdownFrom,
                      onChanged: (String? newValue) {
                        setState(() {
                          BlocProvider.of<ExchangeBloc>(context).fromCoin =
                              newValue!;
                        });
                      },
                      items: <String>[
                        "bitcoin",
                        "ethereum",
                        "bitcoin-cash",
                        "eos",
                        "litecoin",
                        "tether"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.toUpperCase()),
                        );
                      }).toList(),
                    ),
                  );
                }),
                SizedBox(height: 20),
                BlocBuilder<ExchangeBloc, ExchangeState>(
                    builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10)),
                      width: 160,
                      child: DropdownButton<String>(
                        style: AppTextStyles.normal,
                        dropdownColor: AppColors.primaryColor,
                        value: dropdownTo,
                        onChanged: (String? newValue) {
                          setState(() {
                            BlocProvider.of<ExchangeBloc>(context).toCoin =
                                newValue!;
                          });
                        },
                        items: <String>[
                          "bitcoin",
                          "ethereum",
                          "bitcoin-cash",
                          "eos",
                          "litecoin",
                          "tether"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                      ));
                }),
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        BlocBuilder<ExchangeBloc, ExchangeState>(builder: (context, state) {
          if (state is NewQuantity) {
            return Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text("New quantity:", style: AppTextStyles.title),
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Text(state.quantity, style: AppTextStyles.title)),
                ],
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: 65,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text("New quantity:", style: AppTextStyles.title),
                FittedBox(
                    fit: BoxFit.contain,
                    child: Text("0.00000", style: AppTextStyles.title)),
              ],
            ),
          );
        }),
        SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.buttonBackground)),
            onPressed: () {
              if (quantity.isNotEmpty && double.tryParse(quantity) != null) {
                BlocProvider.of<ExchangeBloc>(context)
                    .add(CalculateQuantity(dropdownFrom, dropdownTo, quantity));
              }
            },
            child: Text(
              "Calculate",
              style: AppTextStyles.normal,
            ),
          ),
        )
      ],
    );
  }
}
