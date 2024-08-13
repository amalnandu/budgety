
import 'package:budget/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Debitpage extends StatefulWidget {
  const Debitpage({super.key});

  @override
  State<Debitpage> createState() => _DebitpageState();
}

class _DebitpageState extends State<Debitpage> {
  ////////// Implementing date
  late dynamic date = "";

  TextEditingController datecontroller = TextEditingController();

  _showDatePicker() {
    showDateRangePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2040));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cr(dynamic startdate, dynamic enddate) {
    return FirebaseFirestore.instance
        .collection('debit')
        .where('datevalue', isGreaterThanOrEqualTo: startdate)
        .where('datevalue', isLessThanOrEqualTo: enddate)
        .snapshots();
  }

  var name = "";
  dynamic startdate;
  dynamic enddate;
  late dynamic selectedDates;

  /////
  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),

    );

    if (picked != null) {
      setState(() {
        startdate = picked.start;
        enddate = picked.end;
      });

    }
  }
  ///////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgcolor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 8,
          title: Text(
            "Debits",
            style:
            GoogleFonts.satisfy(fontWeight: FontWeight.w500, fontSize: 22),
          )),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.9],
            colors: [bgcolor, bgcolor1, primaryColor],
          ),
        ),
        child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Text("Select dates   ",style: GoogleFonts.poppins(color: Colors.white,fontSize: 18),),

                          IconButton(onPressed: (){
                            _selectDateRange(context);
                            cr(startdate, enddate);
                          }, icon: const Icon(
                            Icons.calendar_month,color: Colors.white,size: 40,
                          ))
                        ],
                      )),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: cr(startdate,enddate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final debitinfo = snapshot.data!.docs;

                        return ListView.builder(
                            itemCount: debitinfo.length,
                            itemBuilder: (context, index) {
                              int rev = debitinfo.length - 1 - index;
                              return Dismissible(
                                key: Key(index.toString()),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10, right: 10.0),
                                  child: Card(
                                    color: Colors.white10.withOpacity(0.1),
                                    elevation: 1,
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          debitinfo[rev]['note'],
                                          style: GoogleFonts.poppins(
                                              color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                      subtitle: Text(
                                        debitinfo[rev]['date'],
                                        style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                      ),
                                      trailing: Text(
                                        debitinfo[rev]['amount'],
                                        style: GoogleFonts.manrope(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )),
      ),
    );
  }
}
