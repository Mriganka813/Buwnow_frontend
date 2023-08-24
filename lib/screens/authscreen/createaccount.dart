import 'package:flutter/material.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/custtomscreens/textfild.dart';
import 'package:buynow/services/auth_services.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  static const routeName = '/create-account';
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late ColorNotifier notifier;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  final authServices = AuthServices();

  bool isChecked = false;
  bool isLoading = false;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    addressController.dispose();
  }

  void signUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim().toLowerCase();
    final phoneNo = phoneController.text.trim();
    final password = passwordController.text.trim();
    final address = addressController.text.trim();

    // validation
    if (name.isEmpty || name.length < 4) {
      showSnackBar('Invalid name');
      return;
    } else if (email.isEmpty || !email.contains('@')) {
      showSnackBar('Invalid Email');
      return;
    } else if (phoneNo.isEmpty) {
      showSnackBar('Invalid phone number');
      return;
    } else if (password.isEmpty || password.length < 8) {
      showSnackBar('Password is too short.');
      return;
    } else if (address.isEmpty) {
      showSnackBar('Please enter your correspondence address');
      return;
    }
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // user registration
    authServices
        .signUpUser(
      name: name,
      email: email,
      phoneNo: phoneNo,
      password: password,
      context: context,
      address: address,
    )
        .then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/signup.png"),
                Column(
                  children: [
                    SizedBox(height: height / 12),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          LanguageEn.signin,
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 25,
                            fontFamily: 'GilroyBold',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          LanguageEn.welcometogofoods,
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 42,
                            fontFamily: 'GilroyMedium',
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.fanme,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 50),

            // enter your name
            Customtextfild.textField(
                LanguageEn.enteryourfullname,
                notifier.getblackcolor,
                width / 1.13,
                Icons.person,
                notifier.getbgfildcolor,
                nameController,
                false),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.emailadress,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 50),

            // enter your email
            Customtextfild.textField(
                LanguageEn.enteryouremail,
                notifier.getblackcolor,
                width / 1.13,
                Icons.email,
                notifier.getbgfildcolor,
                emailController,
                false),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.phonenumbers,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 50),

            // enter your phone number
            Customtextfild.textField(
                LanguageEn.enteryourphonenumber,
                notifier.getblackcolor,
                width / 1.13,
                Icons.call,
                notifier.getbgfildcolor,
                phoneController,
                false),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.password,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 50),

            // enter your password
            Customtextfild.textField(
                LanguageEn.enteryourpassword,
                notifier.getblackcolor,
                width / 1.13,
                Icons.lock,
                notifier.getbgfildcolor,
                passwordController,
                true),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.address,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 50),

            // enter address for cute registration
            Customtextfild.textField(
                LanguageEn.enteryouraddress,
                notifier.getblackcolor,
                width / 1.13,
                Icons.location_city,
                notifier.getbgfildcolor,
                addressController,
                false),
            SizedBox(height: height / 15),

            // signup button
            GestureDetector(
              onTap: () {
                signUp();
              },
              child: isLoading
                  ? CircularProgressIndicator()
                  : button(
                      notifier.getred,
                      notifier.getwhite,
                      LanguageEn.createaccount,
                      width / 1.1,
                    ),
            ),
            SizedBox(height: height / 30),

            // already have an account, sign in
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LanguageEn.alredyhaveaccount,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontFamily: 'GilroyMedium',
                    fontSize: height / 55,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    LanguageEn.signin,
                    style: TextStyle(
                      color: const Color(0xff3a71d5),
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 30,
            )
          ],
        ),
      ),
    );
  }

  Widget authbutton(buttoncolor, buttontextcolor, txt, w, image) {
    return Container(
      height: height / 14,
      width: w,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: height / 35),
            SizedBox(width: width / 30),
            Text(
              txt,
              style: TextStyle(
                  color: buttontextcolor,
                  fontSize: height / 50,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
