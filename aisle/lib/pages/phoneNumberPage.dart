import 'package:aisle/pages/mainRoutes/NavBarPage.dart';
import 'package:aisle/pages/otpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aisle/style.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key key}) : super(key: key);

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var country_code = "+91";
  var phone_number = "";
  var isLoading = false;

  getNextStep() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(await prefs.getString("token") != "" && await prefs.getString("token") != null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavBarPage()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    getNextStep();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: SetColors.background,
        body:isLoading ? Loader : Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(child: Text("Get OTP",style: TextTypes.light(Colors.black,18.0),)),
                    Container(child: Text("Enter Your\nPhone Number",style: TextTypes.main(Colors.black,36.0),)),
                    SizedBox(height: 16,),
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: country_code,
                                style: TextTypes.input(Colors.black, 18.0),
                                validator: (val) {
                                  if (val != "") {
                                    return null;
                                  } else {
                                    return "Cannot be empty";
                                  }
                                },
                                onSaved: (val) => country_code = val,
                                keyboardType: TextInputType.number,
                                onChanged: (val) => {
                                  this.setState(() {
                                    country_code = val;
                                  }),

                                },
                                decoration: InputDecoration(
                                  hintText: "+91",
                                  hintStyle: TextStyle(
                                    color: Colors.black12
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: SetColors.borderColor,width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: SetColors.borderColor, width: 1)),
                                  fillColor: SetColors.background,
                                  filled: true,
                                )),
                          ),
                          SizedBox(width: 16,),
                          Flexible(
                            flex: 5,
                            child: TextFormField(
                                style: TextTypes.input(Colors.black, 18.0),
                                initialValue: phone_number,
                                validator: (val) {
                                  if (val == "" || val.length < 10) {
                                    return "Fill In properly";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => phone_number = val,
                                keyboardType: TextInputType.number,
                                onChanged: (val) => {
                                  this.setState(() {
                                    phone_number = val;
                                  })
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 16),
                                  hintText: "9876543212",
                                  hintStyle: TextStyle(
                                      color: Colors.black12
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: SetColors.borderColor,width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: SetColors.borderColor, width: 1)),
                                  fillColor: SetColors.background,
                                  filled: true,
                                )),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                        color: SetColors.buttonBackground,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: (){
                          if(_formKey.currentState.validate())
                          {
                            FocusScope.of(context).unfocus();
                            void getHttp() async {
                              this.setState(() {
                                isLoading = true;
                              });
                              try {
                                var formData = FormData.fromMap({
                                  "number":country_code+phone_number
                                });
                                var response = await Dio().post('https://testa2.aisle.co/V1/users/phone_number_login',data: formData);
                                if(response.data['status'] == false)
                                {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Couldn't Authenticate")));
                                }
                                else{
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OtpPage(phone_number: phone_number,country_code: country_code,)), (route) => false);
                                }
                                this.setState(() {
                                  isLoading = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            }
                            getHttp();
                          }
                          else{
                            print("Not Validated");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                          child: Text("Continue",style: TextTypes.main(Colors.black,15.0),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
