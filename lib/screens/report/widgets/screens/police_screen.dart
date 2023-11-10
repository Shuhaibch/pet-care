import 'package:flutter/material.dart';
import 'package:pet_care/config/width.dart';

class PoliceScreen extends StatelessWidget {
  static const String routeName = '/police';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => PoliceScreen(),
    );
  }

  PoliceScreen({super.key});

  final List<String> catagories = [
    'Missing',
    'Adoption',
    'Forage',
  ];

  final ValueNotifier<String> selectedCatagaries =
      ValueNotifier("Select Catagories");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_outlined,
          ),
        ),
        titleSpacing: .01,
        title: Text(
          'Police',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                        selectedCatagaries;
                      },
                    );
                  },
                ),
              ),
            ),
            kheight10,
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Explain Breifly What's Reporting",
                hintStyle: Theme.of(context).textTheme.displaySmall,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(
                      20,
                      20,
                    ),
                  ),
                ),
              ),
              maxLines: 8,
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
                        const Center(
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
                    // Detainer
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
                      const Icon(
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
          ],
        ),
      ),
    );
  }
}
