RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');
RegExp passRexExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$');

RegExp nameRegExp = RegExp('[a-z A-Z]');

RegExp specialCharRexExp =
    RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])');
RegExp phoneRexExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');