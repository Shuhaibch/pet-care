import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/screens/add/widget/bottom_sheet.dart';

ValueNotifier<String> selectedCatagaries = ValueNotifier("Select Catagories");
ValueNotifier<bool> isUploadImage = ValueNotifier(true);

class AddScreen extends StatelessWidget {
  static const String routeName = '/add';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AddScreen(),
    );
  }

  AddScreen({super.key});
  final List<String> catagories = [
    'Missing',
    'Adoption',
    'Forage',
  ];
  final bool show = false;
  // String selectedCatagaries = 'Select Catagories';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vetinary",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            kheight20,

            //* Drop Down List
            SizedBox(
              width: double.infinity,
              child: Center(
                child: ValueListenableBuilder(
                    valueListenable: selectedCatagaries,
                    //Nthappo ante vicharam?
                    builder: (context, value, child) {
                      return DropdownButton(
                        alignment: AlignmentDirectional.center,
                        dropdownColor: Colors.black,
                        hint: Text(
                          selectedCatagaries.value,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        style: Theme.of(context).textTheme.displayMedium,
                        underline: Divider(color: Colors.grey[700]),
                        items: catagories.map((String value) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedCatagaries.value = value;
                            },
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          selectedCatagaries; //Categaries aathre ayyyyy CategOries aada pothe
                        },
                      );
                    }),
              ),
            ),
            kheight10,

            //* Text form field
            ValueListenableBuilder(
              valueListenable: isUploadImage,
              builder: (context, value, child) {
                return isUploadImage.value == false
                    ? TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey[900],
                          filled: true,
                          //Ante show okke malapporth mathi
                          hintText: "What's happening?",
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(
                                20,
                                20,
                              ),
                            ),
                            // CircularExterminator
                          ),
                        ),
                        maxLines: 8,
                      )

                    //* Photo Or Video  Button
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              showBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return CustomBottomSheet(
                                    height: height,
                                    width: width,
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: width * .35,
                              height: height * .20,
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
                                  Icons.image,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return CustomBottomSheet(
                                    height: height,
                                    width: width,
                                    isVedio: true,
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: width * .35,
                              height: height * .20,
                              decoration: BoxDecoration(
                                //Ivde vann kalichanda, ith area verenu
                                color: Colors.grey[900],
                                borderRadius: const BorderRadius.all(
                                  Radius.elliptical(
                                    20,
                                    20,
                                  ),
                                ),
                              ),
                              // ForHalloween
                              child: const Center(
                                child: Icon(
                                  Icons.video_library,
                                  size: 40,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
              },
            ),
            kheight20,
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      isUploadImage.value = !isUploadImage.value;
                    },
                    child: Center(
                      child: ValueListenableBuilder(
                          valueListenable: isUploadImage,
                          builder: (context, value, child) {
                            return Text(
                              isUploadImage.value == false
                                  ? "Upload Media"
                                  : "Upload text",
                              style: Theme.of(context).textTheme.displaySmall,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            kheight20,

            //* Uplaod Button
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: width * .39,
                      height: height * .08,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: const BorderRadius.all(
                              Radius.elliptical(20, 20))),
                      child: Center(
                        child: Text(
                          "Report",
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
      ),
    );
  }
}
