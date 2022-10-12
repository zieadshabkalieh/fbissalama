import 'package:fbissalama/Widgets/LoginWidgets/text_fields.dart';
import 'package:fbissalama/Widgets/widgets/drop_down.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/models/provider_controller.dart';
import 'package:fbissalama/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

typedef CallbackDropDown = void Function(String newValue);

class AddJourneyPage extends StatelessWidget {
  const AddJourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firstDate = DateTime.now();
    final lastDate = DateTime(2222, 12);
    String sourceCity = 'Source City';
    String destinationCity = 'Destination City';
    TextEditingController price = TextEditingController();
    Size size = MediaQuery.of(context).size;
    ProviderController providerController =
        Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/home");
              }),
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
                const Text(
                  "From:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                Consumer<ProviderController>(builder: (context, value, child) {
                  return DropDown(value, sourceCity, Colors.grey.shade200,
                      Colors.black, Colors.grey.shade700, 18.0,
                      items: const ['Aleppo', 'Damascus', 'Homs', 'Hama'],
                      callbackDropDown: (newValue) {
                    sourceCity = newValue;
                  });
                }),
              ],
            ),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  "To:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                Consumer<ProviderController>(builder: (context, value, child) {
                  return DropDown(value, destinationCity, Colors.grey.shade200,
                      Colors.black, Colors.grey.shade700, 18.0,
                      items: const ['Aleppo', 'Damascus', 'Homs', 'Hama'],
                      callbackDropDown: (newValue) {
                    destinationCity = newValue;
                  });
                }),
              ],
            ),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime:
                      Provider.of<ProviderController>(context, listen: false)
                          .time,
                );
                if (newTime != null) {
                  providerController.setTime(newTime);
                }
              },
              child: Consumer<ProviderController>(
                  builder: (context, value, child) {
                return !value.timeChanged
                    ? const Text(
                        'Select Time',
                        style: TextStyle(fontSize: 22),
                      )
                    : Text(
                        value.time.format(context),
                        style: const TextStyle(fontSize: 22),
                      );
              }),
            ),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate:
                        Provider.of<ProviderController>(context, listen: false)
                            .date,
                    firstDate: firstDate,
                    lastDate: lastDate);
                if (newDate != null) {
                  providerController.setDate(newDate);
                }
              },
              child: Consumer<ProviderController>(
                  builder: (context, value, child) {
                return !value.dateChanged
                    ? const Text(
                        'Select Date',
                        style: TextStyle(fontSize: 22),
                      )
                    : Text(
                        '${value.date}'.split(' ')[0],
                        style: const TextStyle(fontSize: 22),
                      );
              }),
            ),
            const Divider(thickness: 1, height: 20, color: Colors.blue),
            myTextField(
                size.width / 5,
                size.width / 2.5,
                price,
                false,
                const Icon(
                  Icons.attach_money_outlined,
                  color: Colors.white,
                ),
                'Price...',
                TextInputType.number),
            const SizedBox(height: 30),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (!Provider.of<ProviderController>(context,
                                    listen: false)
                                .dateChanged ||
                            !Provider.of<ProviderController>(context,
                                    listen: false)
                                .timeChanged ||
                            sourceCity == 'Source City' ||
                            destinationCity == 'Destination City' ||
                            price.text == '') {
                          Fluttertoast.showToast(
                              msg:
                                  'To Add Journey.All fields must be filled out',
                              fontSize: 14,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        } else if (sourceCity == destinationCity) {
                          Fluttertoast.showToast(
                              msg:
                                  'It isn\'t possible source city is the same of the destination city',
                              fontSize: 14,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        } else {
                          final journey = <String, dynamic>{
                            Consts.pathSourceCity: sourceCity,
                            Consts.pathDestinationCity: destinationCity,
                            Consts.pathTimeJourney:
                                Provider.of<ProviderController>(context,
                                        listen: false)
                                    .time
                                    .format(context),
                            Consts.pathDateJourney:
                                '${Provider.of<ProviderController>(context, listen: false).date}'
                                    .split(' ')[0],
                            Consts.pathPriceJourney: "${price.text} \$",
                          };
                          Consts.journeyRef
                              .child(Consts.pathJourneys)
                              .push()
                              .set(journey)
                              .then((_) => Fluttertoast.showToast(
                                  msg:
                                      'The journey has been successfully added',
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
                        customSnackBar(context, e.toString(), 3, Colors.white24,
                            Colors.brown, 17);
                      }
                    },
                    child: const Text(
                      'Add Journey',
                      style: TextStyle(fontSize: 22),
                    )))
          ],
        ),
      ),
    );
  }
}
