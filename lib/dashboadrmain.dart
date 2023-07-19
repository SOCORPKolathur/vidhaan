import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vidhaan/profile.dart';

import 'demo2.dart';


class Dashboard2 extends StatefulWidget {
  const Dashboard2({Key? key}) : super(key: key);

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {

  int total=0;
  int present=0;
  int absent=0;

  int selectedvalue=0;
  int selectedvalue2=0;
  int selectedvalue3=0;
  int selectedvalue4=0;

  int cyear = 0;
  String cmonth = "";
  String day = "";
  int currentDate = 0;
  String getMonth(int currentMonthIndex) {
    return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
  }
  DateTime _chosenDate = DateTime.now();
  String  _chosenDay ="";
  bool dateselected=false;
  String formattedDate='';
  Date() {
    setState(() {
      day = DateFormat('EEEE').format(DateTime.now());

      cyear = DateTime.now().year;
      cmonth = getMonth(DateTime.now().month);

      currentDate = DateTime.now().day;

    });

    print(day);
    print(currentDate);
  }
  @override
  void initState() {
    getvalue();
    Date();
    getadmin();

    // TODO: implement initState
    super.initState();
  }
  String schoolname="";
  String schooladdress="";
  String schoollogo="";
  String idcarddesign="";
  String solgan="";
  String imgurl="";
  getadmin() async {
    var document = await FirebaseFirestore.instance.collection("Admin").get();
    setState(() {
       schoolname=document.docs[0]["schoolname"];
       schooladdress=
       "${document.docs[0]["area"]} ${document.docs[0]["city"]} ${document.docs[0]["pincode"]}";
       schoollogo=document.docs[0]["logo"];
       idcarddesign=document.docs[0]["idcard"].toString();
       solgan=document.docs[0]["solgan"];
       imgurl=document.docs[0]["logo"];
    });
  }


   _showPopupMenu()  {
    return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(900, 80, 0, 100),
      items: [
        PopupMenuItem<String>(
          onTap: () async {
            print("Okkkk");
            final navigator = Navigator.of(context);
            await Future.delayed(Duration.zero);
            navigator.push(
              MaterialPageRoute(builder: (_) => Profile()),
            );

          },
            child:  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.person),
                ),
                Text('Profile'),
              ],
            ), value: 'Doge'),
        PopupMenuItem<String>(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.logout_rounded),
                ),
                 Text('Log out'),
              ],
            ), value: 'Lion'),


      ],

      elevation: 8.0,
    );
  }
  int students= 0;
  int staffs= 0;
  int classes= 0;
  int amount= 0;

  getvalue() async {
    var doucment = await FirebaseFirestore.instance.collection("Students").get();
    var doucment2 = await FirebaseFirestore.instance.collection("Staffs").get();
    var doucment3 = await FirebaseFirestore.instance.collection("ClassMaster").get();

    setState(() {
      students=doucment.docs.length;
      staffs=doucment2.docs.length;
      classes=doucment3.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Container(
        width: width/1.707,


        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset("assets/Hello Admin 👋🏼,.png"),
                  ),

                 Container(
                   width: 400,
                   height: 100,

                   decoration: BoxDecoration(
                     color: Color(0xff00A0E3),
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(120),
                       bottomLeft: Radius.circular(120),
                     ),

                   ),
                   child: Row(
                     children: [
                       SizedBox(width: 20,),
                      Container(
                         width: 70,
                         height: 70,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(70)
                           

                         ),
                        child: Image.network(imgurl),
                       ),
                       SizedBox(width: 12,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                               width:220,
                               child: Text(schoolname,style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.white),)),
                           SizedBox(height: 5,),
                           Text(schooladdress,style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white),),
                         ],
                       ),
                       SizedBox(width: 30,),
                       InkWell(
                         onTap: (){
                           _showPopupMenu();
                         },

                           child: Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.white,size: 25,))

                     ],
                   )
                 )


                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,left:8),
                child: Row(
                  children:[
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.calendar_month),
                  ),
                    Text("${currentDate} ${cmonth} , ${cyear}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: width/34.15, top: height/32.85),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(12),
                  shadowColor:  Color(0xff53B175).withOpacity(0.20),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top:height/131.4, left: width/50.592),
                              child: Container(
                                child: Image.asset("assets/students 1.png"),
                                width: width / 17.07,
                                height: height / 8.2,
                                //color: Color(0xffD1F3E0),
                                decoration: BoxDecoration(
                                    color: Color(0xffD1F3E0),
                                    borderRadius: BorderRadius.circular(52)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height/36.5, left:width/85.375,right:width/75.888,),
                              child: Image.asset("assets/Line.png"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(
                                      top: height/32.85, right: width/136.6),
                                  child: Text(
                                    "Students",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffA3A3A3), fontSize:width/105.076),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right:width/75.88),
                                  child: Text(
                                    students.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize:width/85.375, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top:height/36.5, right:width/75.888),
                              child: Image.asset("assets/Line 2.png"),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height/131.4, right:width/75.888),
                              child: Container(
                                child: Image.asset("assets/staffs.png"),
                                width: width / 17.05,
                                height: height / 8.2,
                                //color: Color(0xffD1F3E0),
                                decoration: BoxDecoration(
                                    color: Color(0xffE1F1FF),
                                    borderRadius: BorderRadius.circular(52)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(right:width/75.888, top:height/34.578),
                              child: Image.asset(
                                "assets/Line.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top:height/23.464),
                                  child: Text(
                                    "Staffs",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffA3A3A3), fontSize:width/105.076),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right:width/20.088),
                                  child: Text(
                                    staffs.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize:width/85.375, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top:height/36.5, left: width/683, right: width/170.75),
                              child: Image.asset("assets/Line 2.png"),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height/131.4, left:width/91.06),
                              child: Container(
                                child: Image.asset("assets/classes.png",scale: 1.50,),
                                width: width / 17.0,
                                height: height / 8,
                                //color: Color(0xffD1F3E0),
                                decoration: BoxDecoration(
                                    color: Color(0xffFFF2D8),
                                    borderRadius: BorderRadius.circular(52)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(
                                  top: height/54.75, left: width/47.103, right: width/273.2),
                              child: Image.asset(
                                "assets/Line.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [

                                Padding(
                                  padding:  EdgeInsets.only(left: width/97.571),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top:height/23.464),
                                        child: Text(
                                          "Classes",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xffA3A3A3), fontSize:width/105.076),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(
                                            bottom: height/82.125, right:width/75.888),
                                        child: Text(
                                          classes.toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize:width/85.375,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top: height/109.5, left: width/37.94),
                                  child: Container(
                                    child: Image.asset("assets/accounts.png"),
                                    width: width / 17,
                                    height: height / 8.2,
                                    //color: Color(0xffD1F3E0),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFEAEA),
                                        borderRadius: BorderRadius.circular(52)),
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(
                                      right:width/75.888, top:height/34.578, left:width/75.888),
                                  child: Image.asset(
                                    "assets/Line.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top:height/23.464),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Accounts",
                                        style: GoogleFonts.poppins(
                                            color: Color(0xffA3A3A3), fontSize:width/105.076),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(right: width/48.785),
                                        child: Text(
                                          "\$${customtotal.toString()}",
                                          style: GoogleFonts.poppins(
                                              fontSize:width/85.375,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    width:width/1.1,
                    height: height / 6.57,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: width/34.15, top: height/32.85),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(12),
                  shadowColor:  Color(0xff53B175).withOpacity(0.20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Today Staff Reports",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 18),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: Row(
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 15.0,top:8,bottom: 8),
                                child:  Column(
                                  children: [
                                    CircularPercentIndicator(
                                      circularStrokeCap: CircularStrokeCap.round,
                                      radius: 50.0,
                                      lineWidth: 12.0,
                                      percent: total ==0? 0.70: (present/total*100)/100,
                                      center:  Text("70%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                      progressColor: Colors.green,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                      child:  ChoiceChip(

                                        label: Text("  Present  ",style: TextStyle(color: Colors.white),),


                                        onSelected: (bool selected) {

                                          setState(() {

                                          });
                                        },
                                        selectedColor: Color(0xff53B175),
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Color(0xff53B175))),
                                        backgroundColor: Colors.white,
                                        labelStyle: TextStyle(color: Colors.black),

                                        elevation: 1.5, selected: true,),

                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,top: 8,bottom: 8.0),
                                child:  Column(
                                  children: [
                                    CircularPercentIndicator(
                                      circularStrokeCap: CircularStrokeCap.round,
                                      radius: 50.0,
                                      lineWidth: 12.0,
                                      percent: total ==0? 0.30: (absent/total*100)/100,
                                      center:  Text("30%",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500)),
                                      progressColor: Colors.red,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 12),
                                      child: ChoiceChip(

                                        label: Text("  Absent  ",style: TextStyle(color: Colors.white),),


                                        onSelected: (bool selected) {

                                          setState(() {

                                          });
                                        },
                                        selectedColor: Colors.red,
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.red)),
                                        backgroundColor: Colors.white,
                                        labelStyle: TextStyle(color: Colors.black),

                                        elevation: 1.5, selected: true,),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width:20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Staffs on leave Today",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 15),),
                                  ),
                                  Container(
                                    height: height / 5.57,
                                    width: 500,

                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection("Staffs").orderBy("timestamp",descending: true).snapshots(),
                                        builder: (context,snapshot) {
                                          if(snapshot.hasData==null){
                                            return Container();
                                          }
                                          if(!snapshot.hasData){
                                            return Container();
                                          }
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (context,index){
                                                var val = snapshot.data!.docs[index];
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(width: width/136.6,),

                                                        //radio button
                                                        Radio(
                                                            value: 1,
                                                            activeColor: Color(0xff263646),
                                                            groupValue:selectedvalue,
                                                            onChanged:(value){
                                                              setState(() {
                                                                value=selectedvalue;
                                                                selectedvalue=1;
                                                                selectedvalue2=0;
                                                                selectedvalue3=0;
                                                                selectedvalue4=0;
                                                              });
                                                            }),
                                                        //text1
                                                        Text("Staff Name : ${val["stname"]} ",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 14),),
                                                        Text("- ID ${val["regno"]} ",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.grey),),

                                                        SizedBox(width:width/15.87),




                                                      ],
                                                    ),




                                                  ],);
                                              });
                                        }
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                    width:width/1.1,
                    height: height / 2.87,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,right: 12),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor:  Color(0xff53B175).withOpacity(0.20),
                      child: Container(
                        width: 500,
                        height: 420,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2010,10,20),
                            lastDay: DateTime.utc(2040,10,20),
                            focusedDay: _chosenDate,
                            headerVisible: true,
                            daysOfWeekVisible: true,
                            sixWeekMonthsEnforced: true,
                            shouldFillViewport: false,
                            headerStyle: HeaderStyle(titleTextStyle: GoogleFonts.montserrat(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800)),
                            calendarStyle: CalendarStyle(todayTextStyle: GoogleFonts.montserrat(fontSize:12, color: Colors.white, fontWeight: FontWeight.bold )),
                            onDaySelected: (date,e){
                              setState((){
                                _chosenDate=e;
                                dateselected=true;
                                formattedDate = DateFormat('ddMyyyy').format(_chosenDate);
                              });
                              print(formattedDate);
                              print(_chosenDate);
                              print(dateselected);

                            },
                            onDisabledDayTapped: (date){
                              setState((){

                                _chosenDay=date as String;
                              });
                              print(_chosenDay);

                            },
                            currentDay: _chosenDate,
                            pageJumpingEnabled: true,
                            pageAnimationCurve: Curves.decelerate,
                            pageAnimationEnabled: true,
                            pageAnimationDuration: Duration(milliseconds: 800),

                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,right: 12),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor:  Color(0xff53B175).withOpacity(0.20),
                      child: Container(
                          width: 500,
                          height: 420,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:Border.all(color: Color(0xff53B175).withOpacity(0.20))
                          ),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:20.0,left: 15),
                                child: Text("Remainders",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17),),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }





  int customtotal=0;
}