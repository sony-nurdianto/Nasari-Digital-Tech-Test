import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoListCard extends StatelessWidget {
  final String taskName;
  final String description;
  final String dueDate;
  final String status;
  // final String image;

  const TodoListCard(
      {required this.taskName,
      required this.description,
      required this.dueDate,
      required this.status,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.blue[500],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 170, 61, 189),
                      borderRadius: BorderRadius.circular(10)),
                  child:  Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // color: Colors.blue[300],
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                 SizedBox(
                  height: 2.h,
                ),
                 Text(
                  dueDate,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 67, 65, 65), fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
