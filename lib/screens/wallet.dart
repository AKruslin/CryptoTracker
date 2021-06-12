import 'package:crypto_tracker/bloc/wallet/wallet_bloc.dart';
import 'package:crypto_tracker/common/appColors.dart';
import 'package:crypto_tracker/common/appStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WalletBloc>(context).add(CheckWallet());
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Name",
                        style: AppTextStyles.title,
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Quantity",
                        style: AppTextStyles.title,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Value",
                      style: AppTextStyles.title,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, state) {
                  if (state is WalletDataFetched) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.wallet.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(bottom: 20),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      state.wallet[index]!.id,
                                      style: AppTextStyles.normal,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      state.wallet[index]!.quantity.toString(),
                                      style: AppTextStyles.normal,
                                    ),
                                  ),
                                  Spacer(),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      (state.wallet[index]!.value *
                                                  state.wallet[index]!.quantity)
                                              .toStringAsFixed(5) +
                                          " \$",
                                      style: AppTextStyles.normal,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.buttonBackground)),
              onPressed: () {
                String dropdownValue = "bitcoin";
                String quantityValue = "0";
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => StatefulBuilder(
                    builder: (context, StateSetter setState) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Choose your crypto:",
                                style: AppTextStyles.normal,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  dropdownColor: AppColors.primaryColor,
                                  onChanged: (String? newValue) {
                                    setState(() => dropdownValue = newValue!);
                                  },
                                  items: <String>[
                                    "bitcoin",
                                    "ethereum",
                                    "bitcoin-cash",
                                    "eos",
                                    "litecoin",
                                    "tether"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value.toUpperCase(),
                                        style: AppTextStyles.normal,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Enter quantity: ",
                                  style: AppTextStyles.normal,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 170,
                                  child: TextField(
                                    expands: false,
                                    style: AppTextStyles.normal,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      quantityValue = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(10)),
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.buttonBackground)),
                                onPressed: () {
                                  if (double.parse(quantityValue) > 0) {
                                    BlocProvider.of<WalletBloc>(context).add(
                                      AddCrypto(
                                        dropdownValue,
                                        double.parse(quantityValue),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  } else {
                                    print(
                                        "Error while adding crpyto modal-dialog");
                                  }
                                },
                                child: Text(
                                  "Confirm",
                                  style: AppTextStyles.normal,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
