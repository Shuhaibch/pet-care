import 'package:flutter/material.dart';

class CustCircularProgress extends StatelessWidget {
  const CustCircularProgress({
    super.key, this.color= Colors.white,
  });
 final Color ?color ;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
