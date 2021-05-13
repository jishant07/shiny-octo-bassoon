import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aisle/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aisle/pages/mainRoutes/NavBarPage.dart';
import 'dart:async';

class OtpPage extends StatefulWidget {
  final phone_number;
  final country_code;
  const OtpPage({Key key,this.phone_number,this.country_code}) : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var isLoading = false;
  var OTP = "";
  var time = 15;
  bool showResendButton = false;
  Timer _timer;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(time>0)
        {
          this.setState(() {
            time = time - 1;
          });
          print(time);
        }
      else{
        _timer.cancel();
        showResendButton = true;
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SetColors.background,
        key: _scaffoldKey,
        body:isLoading? Loader :Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(child: Text(widget.country_code+widget.phone_number,style: TextTypes.light(Colors.black,18.0),)),
                        SizedBox(width: 8,),
                        Icon(Icons.edit,size: 18,)
                      ],
                    ),
                    Container(child: Text("Enter Your\nOTP",style: TextTypes.main(Colors.black,36.0),)),
                    SizedBox(height: 16,),
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                                style: TextTypes.input(Colors.black, 18.0),
                                initialValue: OTP,
                                validator: (val) {
                                  print(val);
                                  if (val == "" || val.length < 4) {
                                    return "Fill In properly";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => OTP = val,
                                keyboardType: TextInputType.number,
                                onChanged: (val) => {
                                  this.setState(() {
                                    OTP = val;
                                  })
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 16),
                                  hintText: "Enter OTP",
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
                    Row(
                      children: [
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
                                      "number":widget.country_code+widget.phone_number,
                                      "otp":OTP
                                    });
                                    var response = await Dio().post('https://testa2.aisle.co/V1/users/verify_otp',data: formData);
                                    // print(response.data['status'] == false);
                                    if(response.data['token'] != "" && response.data['token'] != null)
                                    {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('token',response.data['token']);
                                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>NavBarPage()), (route) => false);
                                    }
                                    else{
                                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Couldn't Verify OTP")));
                                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OtpPage(phone_number: phone_number,country_code: country_code,)), (route) => false);
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
                        ),
                        SizedBox(width:16),
                        time > 0 ?Text(time>=10? "00:$time":"00:0$time",style: TextTypes.main(Colors.black, 18),) :Container(
                          decoration: BoxDecoration(
                            color: SetColors.buttonBackground,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: InkWell(
                            onTap: (){
                              if(true)
                              {
                                FocusScope.of(context).unfocus();
                                void getHttp() async {
                                  this.setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    var formData = FormData.fromMap({
                                      "number":widget.country_code+widget.phone_number,
                                    });
                                    var response = await Dio().post('https://testa2.aisle.co/V1/users/phone_number_login',data: formData);
                                    if(response.data['status'] == true){
                                      this.setState(() {
                                        time = 15;
                                        _startTimer();
                                      });
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
                              child: Text("Resend",style: TextTypes.main(Colors.black,15.0),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
      );
  }
}
