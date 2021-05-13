import 'dart:ui';

import 'package:aisle/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Discover extends StatefulWidget {
  const Discover({Key key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {

  bool isLoading = true;
  void getHttp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Dio _dio = new Dio();
      print(await prefs.getString("token"));
      _dio.options.headers["Authorization"] = await prefs.getString("token");
      var response = await _dio.get("https://testa2.aisle.co/V1/users/test_profile_list");
      print(response.data);
      this.setState(() {
        isLoading = false;
        userData = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    if(userData == {})
    {
      getHttp();
    }
    else{
      this.setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.background,
      body: isLoading ? Loader : Scaffold(body:
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  Align(alignment: Alignment.center,child: Text("Notes",style: TextTypes.main(Colors.black,28.0),)),
                  SizedBox(height: 8,),
                  Align(alignment: Alignment.center,child: Text("Personal messages to you",style: TextTypes.light(Colors.black, 18),)),
                  SizedBox(height: 8,),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(image: AssetImage("lib/assets/photo_1.png"),height: MediaQuery.of(context).size.height*0.50,width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text("Meena, 23",style: TextTypes.light(Colors.white,24),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Text("Tap to review 50+ notes",style: TextTypes.light(Colors.white,20),),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16,),
                                Text("Interested In You",style: TextTypes.main(Colors.black,22),),
                                Text("Premium members can\nview all their likes at on",style: TextTypes.light(SetColors.disabled, 15),)
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: SetColors.buttonBackground,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                              child: InkWell(
                                onTap: (){
                                  print("Tapped");
                                },
                                child: Text("Upgrade",style: TextTypes.main(Colors.black, 15),),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(flex: 1,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.3,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(image: AssetImage("lib/assets/photo_2.png"),
                                    height: MediaQuery.of(context).size.height*0.3,
                                    width:MediaQuery.of(context).size.width*0.5,
                                    fit: BoxFit.cover,)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                  child: Container(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Teena",style: TextTypes.main(Colors.white,24),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),),
                      Flexible(flex: 1,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.3,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(image: AssetImage("lib/assets/photo_3.png"),
                                    height: MediaQuery.of(context).size.height*0.3,
                                    width:MediaQuery.of(context).size.width*0.5,
                                    fit: BoxFit.cover,)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                  child: Container(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Beena",style: TextTypes.main(Colors.white,24),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
    );
  }
}
