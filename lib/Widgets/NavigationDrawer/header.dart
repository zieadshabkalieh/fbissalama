import 'package:flutter/material.dart';

Widget headerWidget() {
  const url = 'https://lovee.cc/wp-content/uploads/2019/08/3760.jpg';
  return SingleChildScrollView(
    child: Container(
      color: Colors.blue,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Person Name',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text('person@gmail.com',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    ),
  );
}
