import 'package:flutter/material.dart';
import 'package:pet_care/config/width.dart';

class TypeChatWidget extends StatelessWidget {
  const TypeChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            kwidth10,
            Expanded(
              child: TextField(
                textAlign:
                    TextAlign.left, // Aligns text horizontally to the center
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),

                  //* add Button
                  prefixIcon: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Write message...",
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            kwidth10,
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue[200],
              elevation: 0,
              child: const Icon(
                Icons.send,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
