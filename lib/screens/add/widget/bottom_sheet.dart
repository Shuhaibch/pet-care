import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.height,
    required this.width,
    this.isVedio = false,
  });

  final double height;
  final double width;
  final bool isVedio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
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
          Text(
            'Choose the Location',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          kheight20,

          //* Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //* From Gallery
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isVedio
                          ? const Center(
                              child: Icon(
                                Icons.browse_gallery_outlined,
                                size: 40,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.browse_gallery,
                                size: 40,
                              ),
                            ),
                      kheight10,
                      Text(
                        "From Gallery",
                        style: Theme.of(context).textTheme.displaySmall,
                      )
                    ],
                  ),
                ),
              ),

              //* From Camera
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isVedio
                        ? const Icon(
                            CupertinoIcons.video_camera,
                            size: 40,
                          )
                        : const Icon(
                            Icons.camera_outlined,
                            size: 40,
                          ),
                    kheight10,
                    Text(
                      "From Camera",
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
              ),
            ],
          ),
          //* Cancel Button
          kheight30,
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: width * .39,
                    height: height * .08,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius:
                            const BorderRadius.all(Radius.elliptical(20, 20))),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
