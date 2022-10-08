import 'package:fbissalama/Widgets/LoginWidgets/text_fields.dart';
import 'package:fbissalama/Widgets/widgets/drop_down.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
typedef CallbackDropDown = void Function(String newValue);

class AddJourneyPage extends StatefulWidget {
  const AddJourneyPage({super.key});

  @override
  State<AddJourneyPage> createState() => _AddJourneyPage();
}

class _AddJourneyPage extends State<AddJourneyPage> {
  TimeOfDay time = const TimeOfDay(hour: 9, minute: 00,);
  DateTime date = DateTime.now();
  bool dateChanged = false;
  bool timeChanged = false;
  final firstDate = DateTime.now();
  final lastDate = DateTime(2222, 12);
  String sourceCity = 'Source City';
  String destenationCity = 'Destination City';
  TextEditingController price = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(child: const Icon(Icons.arrow_back, color: Colors.blue,),onTap: (){Navigator.pushReplacementNamed(context, "/home");}),
          title: const Text(
            'Add Journey',
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("From:", style: TextStyle(fontSize: 18),),
                const SizedBox(width: 20,),
                DropDown(sourceCity, Colors.grey.shade200, Colors.black, Colors.grey.shade700, 18.0, items: const ['Aleppo','Damascus','Homs','Hama'],
                    callbackDropDown:(newValue){
                      sourceCity = newValue;
                    }),
              ],
            ),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 25,),
                const Text("To:", style: TextStyle(fontSize: 18),),
                const SizedBox(width: 20,),
                DropDown(destenationCity, Colors.grey.shade200, Colors.black, Colors.grey.shade700, 18.0, items: const ['Aleppo','Damascus','Homs','Hama'],
                    callbackDropDown:(newValue){
                      destenationCity = newValue;
                    }),
              ],
            ),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                      context: context, initialTime: time, );
                  if (newTime != null) {
                    setState(() {
                    time = newTime;
                  timeChanged = true;});
                  }
                },
                child: !timeChanged? const Text('Select Time',
                  style: TextStyle(fontSize: 22),): Text(
                  time.format(context),
                  style: const TextStyle(fontSize: 22),
                ),),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            ElevatedButton(
                onPressed: () async {
                  final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: firstDate,
                      lastDate: lastDate);
                  if (selectedDate != null) {
                    setState(() {
                      date = selectedDate;
                      dateChanged = true;
                    });
                  }
                },
                child: !dateChanged ? const Text('Select Date',
                  style: TextStyle(fontSize: 22),): Text(
                  '$date'.split(' ')[0],
                  style: const TextStyle(fontSize: 22),
                ),),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            myTextField(size.width / 5, size.width / 2.5, price, false, const Icon(Icons.attach_money_outlined, color: Colors.white,),'Price...', TextInputType.number),
            const SizedBox(height: 30),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (!dateChanged ||
                            !timeChanged ||
                            sourceCity == 'Source City' ||
                            destenationCity == 'Destination City' ||
                            price.text == '') {
                          Fluttertoast.showToast(
                              msg: 'To Add Journey.All fields must be filled out',
                              fontSize: 14,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        } else if (sourceCity == destenationCity) {
                          Fluttertoast.showToast(
                              msg: 'It is not possible for source city same destination city',
                              fontSize: 14,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        } else {
                          final journey = <String, dynamic> {
                            Consts.pathSourceCity: sourceCity,
                            Consts.pathDestinationCity: destenationCity,
                            Consts.pathTimeJourney: time.format(context),
                            Consts.pathDateJourney: '$date'.split(' ')[0],
                            Consts.pathPriceJourney: "${price.text} \$",
                            Consts.pathIsFavorite: "false",
                          };
                          Consts.journeyRef.child(Consts.pathJourneys).push()
                              .set(journey)
                              .then((_) => Fluttertoast.showToast(
                              msg: 'The journey has been successfully added',
                              fontSize: 14,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.greenAccent,
                              textColor: Colors.white))
                              .catchError((error) => Fluttertoast.showToast(
                              msg: 'You get an error $error',
                              fontSize: 14,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white));
                        }
                      } catch (e) {
                        customSnackBar(context, e.toString(), 3, Colors.white24, Colors.brown, 17);
                      }
                    },
                    child: const Text('Add Journey',style: TextStyle(fontSize: 22),)))
          ],
        ),
      ),
    );
  }
}
