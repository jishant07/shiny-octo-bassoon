import 'dart:ui';

import 'package:aisle/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Discover extends StatefulWidget {
  const Discover({Key key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {

  bool isLoading = true;
  var currentYear;
  void getHttp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Dio _dio = new Dio();
      //print(await prefs.getString("token"));
      _dio.options.headers["Authorization"] = prefs.getString("token");
      var response = await _dio.get("https://testa2.aisle.co/V1/users/test_profile_list");
      this.setState(() {
        isLoading = false;
        userData = response.data;
      });
      print(userData);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.setState(() {
      currentYear = DateTime.parse(DateTime.now().toString()).year;
      print(currentYear);
    });
    if(toLoad)
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
          primary: true,
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
                        child: Image(image: NetworkImage(userData['invites']['profiles'][0]['photos'][0]['photo']),height: MediaQuery.of(context).size.height*0.50,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(userData['invites']['profiles'][0]['general_information']['first_name'] +" , "+ (currentYear - int.parse(userData['invites']['profiles'][0]['general_information']['date_of_birth'].split('-')[0])).toString(),style: TextTypes.light(Colors.white,24),),
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
                  GridView.count(crossAxisCount: 2,shrinkWrap: true,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 12/17,
                    primary: false,
                    children: userData['likes']['profiles'].map<Widget>((profile) => SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(image: NetworkImage(profile['avatar']),fit: BoxFit.cover,)),
                          userData['likes']['can_see_profile'] == false ? ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                              child: Container(
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                          ):null,
                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(profile['first_name'],style: TextTypes.main(Colors.white,24),),
                            ),
                          )
                        ],
                      ),
                    ),).toList(),),
                ],
              ),
            ),
          ),
        )),
    );
  }
}
