
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int balance = 0;

  TextEditingController notecont = TextEditingController();
  TextEditingController amountcont = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Load the balance value from SharedPreferences when the widget is created
    _loadBalance();
    // setState(() {
    //   initController();
    // });
  }

  // Load the balance value from SharedPreferences
  void _loadBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedBalance = prefs.getInt('balance') ?? 0;
    setState(() {
      balance = savedBalance;
    });
  }

  // Save the balance value to SharedPreferences
  void _saveBalance(int newBalance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('balance', newBalance);
  }

  void _saveBalancetozero() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('balance', 0);
  }

  @override
  Widget build(BuildContext context) {
    ///////////////////

    var dt = DateTime.now().toString();
    var date = DateTime.parse(dt);
    var formattedDate = "${date.day}-${date.month}-${date.year}";

    ////////////

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: CircleAvatar(
      //         backgroundColor: bgcolor1,
      //         child: IconButton(
      //           onPressed: () {},
      //           icon: const Icon(Icons.person),
      //         ),
      //       ),
      //     )
      //   ],
      //   title: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: Text(
      //       "Welcome ",
      //       style:
      //           GoogleFonts.satisfy(fontWeight: FontWeight.w500, fontSize: 22),
      //     ),
      //   ),
      //   elevation: 8,
      //   backgroundColor: primaryColor,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.9],
            colors: [bgcolor, bgcolor1, primaryColor],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // buildConfettiWidget(controllerTopCenter, pi / 1),
              // buildConfettiWidget(controllerTopCenter, pi / 4),
               SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [bgcolor, primaryColor],
                      )),
                  alignment: Alignment.topLeft,
                  height: 165,
                  child: Container(
                    color: Colors.white.withOpacity(0.0),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 21),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                GradientText(
                                  "My Balance :",
                                  colors: const [Colors.blue, Colors.purple],
                                  style: GoogleFonts.poppins(shadows: [
                                    Shadow(
                                      offset:
                                          const Offset(2.0, 2.0), //position of shadow
                                      blurRadius:
                                          6.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(
                                          0.8), //color of shadow with opacity
                                    ),

                                    //add more shadow with different position offset here
                                  ], fontSize: 25, color: Colors.white),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    '₹ $balance',
                                    style: GoogleFonts.raleway(
                                        fontSize: 45, color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: TextField(
                  controller: notecont,
                  cursorColor: Colors.grey,
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      hintStyle:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 15),
                      hintText: '  Enter the Note',
                      border: InputBorder.none,
                      fillColor: Colors.grey.withOpacity(0.0)),
                ),
              ),
             const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: TextField(
                  controller: amountcont,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.grey,
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      //<-- SEE HERE
                      hintStyle:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 15),
                      hintText: '  Enter the Amount',
                      border: InputBorder.none,
                      fillColor: Colors.grey.withOpacity(0.0)),
                ),
              ),
              SizedBox(
                height: 120,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Buttonwidget(
                            text: 'Credit',
                            onPressed: () {
                              Map<String, dynamic> data1 = {
                                'note': notecont.text,
                                'amount': amountcont.text,
                                'date': formattedDate.toString(),
                                'type': "credit",
                                'datevalue': DateTime.now(),
                              };
                              setState(() {
                                balance = balance + int.parse(amountcont.text);
                                // Save the updated balance to SharedPreferences
                                _saveBalance(balance);
                              });
                              FirebaseFirestore.instance
                                  .collection('credit')
                                  .add(data1);
                              // controllerTopCenter.play();

                              /////////

                              FirebaseFirestore.instance
                                  .collection('transactions')
                                  .add(data1);
                              /////
                              notecont.text = '';
                              amountcont.text = '';
                            },
                            bgc: Colors.green.shade500.withOpacity(0.75)),
                        const SizedBox(
                          width: 25,
                        ),
                        Buttonwidget(
                            text: "Debit",
                            onPressed: () {
                              Map<String, dynamic> data2 = {
                                'note': notecont.text,
                                'amount': amountcont.text,
                                'date': formattedDate.toString(),
                                'type': "debit",
                                'datevalue': DateTime.now(),
                              };
                              setState(() {
                                balance = balance - int.parse(amountcont.text);
                                // Save the updated balance to SharedPreferences
                                _saveBalance(balance);
                              });
                              FirebaseFirestore.instance
                                  .collection('debit')
                                  .add(data2);

                              ///// Storing in transaction database

                              FirebaseFirestore.instance
                                  .collection('transactions')
                                  .add(data2);

                              //////
                              notecont.text = '';
                              amountcont.text = '';
                            },
                            bgc: Colors.red.shade500.withOpacity(0.75))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Buttonwidget(
                      text: 'View Credits',
                      onPressed: () {
                        Navigator.of(context).pushNamed('creditpage');
                      },
                      bgc: Colors.white12),
                  const SizedBox(
                    width: 25,
                  ),
                  Buttonwidget(
                      text: "View debits",
                      onPressed: () {
                        Navigator.of(context).pushNamed('debitpage');
                      },
                      bgc: Colors.white12)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
