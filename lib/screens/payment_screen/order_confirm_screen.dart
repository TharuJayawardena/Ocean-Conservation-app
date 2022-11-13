import 'package:flutter/material.dart';
import 'package:ocean_conservation_app/screens/payment_screen/credit_card_screen.dart';
import '../../utils/constants.dart';
import '../login_screen/components/center_widget/center_widget.dart';
import 'dart:math' as math;

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({Key? key}) : super(key: key);

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  int _type = 1;

  final amount = TextEditingController();
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
            backgroundColor: kSecondaryColor,
            centerTitle: true,
            leading: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Amount Confirm',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white),
            )),
        body: Stack(
          children: [
            Positioned(
              top: -160,
              left: -30,
              child: topWidget(screenSize.width),
            ),
            Positioned(
              bottom: -180,
              left: -40,
              child: bottomWidget(screenSize.width),
            ),
            CenterWidget(size: screenSize),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Amount(Rs.)',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: kPrimaryColor)),
                          SizedBox(
                            width: 200,
                            child: TextField(
                                controller: amount,
                                decoration: const InputDecoration(
                                  hintText: "10000.00",
                                  //prefixIcon: Icon(Ionicons.cash),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                          width: size.width, height: 1.0, color: Colors.grey),
                      const SizedBox(height: 40.0),
                      Container(
                        width: size.width,
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: _type == 1
                              ? Border.all(width: 1.0, color: Colors.black)
                              : Border.all(width: 0.3, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 1,
                                        groupValue: _type,
                                        onChanged: _handleRadio,
                                        activeColor: kPrimaryColor),
                                    Text('Amazon pay',
                                        style: _type == 1
                                            ? const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryColor)
                                            : const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                  ],
                                ),
                                Image.asset("assets/icons/amazon-pay.png",
                                    width: 50.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: size.width,
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: _type == 2
                              ? Border.all(width: 1.0, color: Colors.black)
                              : Border.all(width: 0.3, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 2,
                                        groupValue: _type,
                                        onChanged: _handleRadio,
                                        activeColor: kPrimaryColor),
                                    Text('Credit card',
                                        style: _type == 2
                                            ? const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryColor)
                                            : const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/icons/visa.png",
                                        width: 30.0),
                                    const SizedBox(width: 8.0),
                                    Image.asset("assets/icons/mastercard.png",
                                        width: 30.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: size.width,
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: _type == 3
                              ? Border.all(width: 1.0, color: Colors.black)
                              : Border.all(width: 0.3, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 3,
                                        groupValue: _type,
                                        onChanged: _handleRadio,
                                        activeColor: kPrimaryColor),
                                    Text('Paypal',
                                        style: _type == 3
                                            ? const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryColor)
                                            : const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                  ],
                                ),
                                Image.asset("assets/icons/paypal.png",
                                    width: 50.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: size.width,
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: _type == 4
                              ? Border.all(width: 1.0, color: Colors.black)
                              : Border.all(width: 0.3, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 4,
                                        groupValue: _type,
                                        onChanged: _handleRadio,
                                        activeColor: kPrimaryColor),
                                    Text('Apple Pay',
                                        style: _type == 4
                                            ? const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryColor)
                                            : const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                  ],
                                ),
                                Image.asset("assets/icons/Apple_Pay_logo.png",
                                    width: 50.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: size.width,
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: _type == 5
                              ? Border.all(width: 1.0, color: Colors.black)
                              : Border.all(width: 0.3, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 5,
                                        groupValue: _type,
                                        onChanged: _handleRadio,
                                        activeColor: kPrimaryColor),
                                    Text('Google Pay',
                                        style: _type == 5
                                            ? const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryColor)
                                            : const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                  ],
                                ),
                                Image.asset("assets/icons/Google_Pay_Logo.png",
                                    width: 50.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Container(
                          width: size.width, height: 1.0, color: Colors.grey),
                      const SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreditCardScreen(
                                      amount: amount.text,
                                    )),
                          );
                        },
                        child: Container(
                            height: 50,
                            width: size.width,
                            decoration: const BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Center(
                              child: Text("Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color.fromARGB(255, 131, 207, 255),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color.fromARGB(255, 131, 207, 255),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }
}
