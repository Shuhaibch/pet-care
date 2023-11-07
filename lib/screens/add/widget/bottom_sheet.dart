import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.elliptical(30, 30),
          topRight: Radius.elliptical(30, 30),
        ),
        color: Colors.grey[800],
      ),
      height: height * .50,
      width: double.infinity,
      child: Column(
        children: [
          //Thettokke eythyechkkand on vallyeee vaappa aavaan nokknu
          Text('Choose the Location',),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: width * .35,
                  height: height * .20,
                  decoration: BoxDecoration(
                    //Onte vicharam on vallye vaappa aanunna
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(
                        20,
                        20,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Container(
                width: width * .35,
                height: height * .20,
                //neech poda
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(
                      20,
                      20,
                    ),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.video_library,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
