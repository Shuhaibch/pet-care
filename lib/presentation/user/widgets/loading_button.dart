import 'package:flutter/material.dart';
import '../../../app_view.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(20, 20))),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.grey,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
