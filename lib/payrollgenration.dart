import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class PayrollGen extends StatefulWidget {
  const PayrollGen({Key? key}) : super(key: key);

  @override
  State<PayrollGen> createState() => _PayrollGenState();
}

class _PayrollGenState extends State<PayrollGen> {
  TextEditingController name = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController orderno = new TextEditingController();


  String classid="";
  String studentid="";
  String? _selectedCity;
  final TextEditingController _typeAheadControllerclass = TextEditingController();
  final TextEditingController _typeAheadControllerfees = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController paytype = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final TextEditingController _typeAheadControllerregno = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController _typeAheadControllerstudent = TextEditingController();

  static final List<String> regno = [];
  static final List<String> student = [];



  static List<String> getSuggestionsregno(String query) {
    List<String> matches = <String>[];
    matches.addAll(regno);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsstudent(String query) {
    List<String> matches = <String>[];
    matches.addAll(student);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static final List<String> classes = ["Select Option"];
  static final List<String> fees = ["Select Option"];
  static final List<String> typeclass = ["Select Option","Designation","Staff","General(For All)"];
  static final List<String> paytypelist = ["Select Option","Monthly","Admission Time","Custom",];


  static List<String> getSuggestionsclass(String query) {
    List<String> matches = <String>[];
    matches.addAll(classes);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionstype(String query) {
    List<String> matches = <String>[];
    matches.addAll(typeclass);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionstypepay(String query) {
    List<String> matches = <String>[];
    matches.addAll(paytypelist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static List<String> getSuggestionsfees(String query) {
    List<String> matches = <String>[];
    matches.addAll(fees);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  @override
  void initState() {
    adddropdownvalue();
    setState(() {
      _typeAheadControllerfees.text="Select Option";
      _typeAheadControllerclass.text="Select Option";
      type.text="Select Option";
      paytype.text="Select Option";
    });
    // TODO: implement initState
    super.initState();
  }
  adddropdownvalue() async {
    setState(() {
      classes.clear();
      fees.clear();
      regno.clear();
      student.clear();
    });
    var document = await  FirebaseFirestore.instance.collection("DesignationMaster").get();
    var document2 = await  FirebaseFirestore.instance.collection("FeesMaster").get();
    setState(() {
      classes.add("Select Option");
      fees.add("Select Option");
    });
    for(int i=0;i<document.docs.length;i++) {
      setState(() {
        classes.add(document.docs[i]["name"]);
      });

    }
    for(int i=0;i<document2.docs.length;i++) {
      setState(() {
        fees.add(document2.docs[i]["name"]);
      });

    }
    var document3 = await  FirebaseFirestore.instance.collection("Students").orderBy("timestamp").get();
    var document4 = await  FirebaseFirestore.instance.collection("Students").orderBy("stname").get();
    for(int i=0;i<document3.docs.length;i++) {
      setState(() {
        regno.add(document3.docs[i]["regno"]);
      });

    }
    for(int i=0;i<document4.docs.length;i++) {
      setState(() {
        student.add(document4.docs[i]["stname"]);
      });

    }
  }

  TextEditingController basicpay= new TextEditingController();
  TextEditingController hra= new TextEditingController();
  TextEditingController da= new TextEditingController();
  TextEditingController other= new TextEditingController();
  TextEditingController gross= new TextEditingController();

  getpay(){
    setState(() {
      hra.text= (int.parse(basicpay.text)* (20/100.00)).toString();
      da.text= (int.parse(basicpay.text)* (40/100.00)).toString();
      if(other.text=="") {
        gross.text = (int.parse(basicpay.text) + int.parse(hra.text) +
            int.parse(da.text)).toString();
      }
      else{
        gross.text = (int.parse(basicpay.text) + int.parse(hra.text) +
            int.parse(da.text)+int.parse(other.text)).toString();
      }
    });
  }
  bool view= false;
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 1000,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 718.0,top: 20,bottom: 10,left: 40),
                    child: Container(child: Text("Payroll Generation",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),

                      height: height/25.269,

//decoration: BoxDecoration(color: Color(0xffF5F5F5),borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 40,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff3786F1),
                        child: Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                                color:Color(0xffE8F0FB)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0,bottom:0 ),
                                child: Text("Total Staffs",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xff3786F1),fontSize: 22),),
                              ),
                              Container(
                                width: 80,
                                height: 2,
                                child: Divider(color: Color(0xff3786F1),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, ),
                                child: Row(
                                  children: [
                                    Text("13",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xff3786F1),fontSize: 38),),
                                    SizedBox(width: 50,),
                                    Icon(Icons.person,size: 38,color: Color(0xff3786F1))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 40,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffEE61CF),
                        child: Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                                color:Color(0xffFDEBF9)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0,bottom:0 ),
                                child: Text("Designations",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xffEE61CF),fontSize: 22),),                    ),
                              Container(
                                width: 80,
                                height: 2,
                                child: Divider(color: Color(0xffEE61CF),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, ),
                                child: Row(
                                  children: [
                                    Text("07",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xffEE61CF),fontSize: 38),),
                                    SizedBox(width: 60,),
                                    Icon(Icons.leaderboard,size: 38,color: Color(0xffEE61CF))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 40,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffFF5151),
                        child: Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:Color(0xffFFEFE7)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0,bottom:0 ),
                                child: Text("Working Days",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xffFF5151),fontSize: 22),),                    ),
                              Container(
                                width: 80,
                                height: 2,
                                child: Divider(color: Color(0xffFF5151),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, ),
                                child: Row(
                                  children: [
                                    Text("26",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xffFF5151),fontSize: 38),),
                                    SizedBox(width: 60,),
                                    Icon(Icons.calendar_month,size: 38,color: Color(0xffFF5151))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 40,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        color:  Color(0xff53B175),
                        child: Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:Color(0xffEBFDEF)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0,bottom:0 ),
                                child: Text("Payrolls",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xff53B175),fontSize: 22),),                    ),
                              Container(
                                width: 80,
                                height: 2,
                                child: Divider(color: Color(0xff53B175),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, ),
                                child: Row(
                                  children: [
                                    Text("06",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Color(0xff53B175),fontSize: 38),),
                                    SizedBox(width: 60,),
                                    Icon(Icons.payments_rounded,size: 38,color: Color(0xff53B175))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          view==false?   Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 1000,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 718.0,top: 20,bottom: 10,left: 40),
                    child: Container(child: Text("Create Payroll",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),

                      height: height/25.269,

//decoration: BoxDecoration(color: Color(0xffF5F5F5),borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0),
                    child: Container(
                      width: width/1.050,

                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Assign Payroll By :",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: Container(width: width/6.83,
                                  height: height/16.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint:  Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select Option',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items:
                                      typeclass.map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:  GoogleFonts.poppins(
                                              fontSize: 15
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value:  type.text,
                                      onChanged: (String? value) {
                                        setState(() {
                                          type.text = value!;
                                        });

                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),

                                          color: Color(0xffDDDEEE),
                                        ),

                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: width/5.464,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Color(0xffDDDEEE),
                                        ),

                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(7),
                                          thickness: MaterialStateProperty.all<double>(6),
                                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                                        ),
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                              type.text !="Select Option"?
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 25),
                                child: GestureDetector(
                                  onTap:(){
                                    setState(() {
                                      view=true;
                                    });

                                  },
                                  child: Container(child:
                                  Center(child: Text("View Payrolls",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                    width: width/5.902,
                                    height: height/16.425,
                                    //color: Color(0xffDDDEEE),
                                    decoration: BoxDecoration(color: const Color(0xffFFA002),borderRadius: BorderRadius.circular(5)),

                                  ),
                                ),
                              ) :Container(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top:8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                type.text!="Select Option"?  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    type.text!="Select Option"?     Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right:0.0),
                                          child: Text("Select Designation *",style: GoogleFonts.poppins(fontSize: 15,)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0,right: 25),
                                          child: Container(width: width/6.83,
                                            height: height/16.42,
                                            //color: Color(0xffDDDEEE),
                                            decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                hint:  Row(
                                                  children: [
                                                    Icon(
                                                      Icons.list,
                                                      size: 16,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        'Select Option',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                items: classes
                                                    .map((String item) => DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style:  GoogleFonts.poppins(
                                                        fontSize: 15
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ))
                                                    .toList(),
                                                value:  _typeAheadControllerclass.text,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _typeAheadControllerclass.text = value!;
                                                  });
                                                  //getstaffbyid();

                                                },
                                                buttonStyleData: ButtonStyleData(
                                                  height: 50,
                                                  width: 160,
                                                  padding: const EdgeInsets.only(left: 14, right: 14),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),

                                                    color: Color(0xffDDDEEE),
                                                  ),

                                                ),
                                                iconStyleData: const IconStyleData(
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios_outlined,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor: Colors.black,
                                                  iconDisabledColor: Colors.grey,
                                                ),
                                                dropdownStyleData: DropdownStyleData(
                                                  maxHeight: 200,
                                                  width: width/5.464,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    color: Color(0xffDDDEEE),
                                                  ),

                                                  scrollbarTheme: ScrollbarThemeData(
                                                    radius: const Radius.circular(7),
                                                    thickness: MaterialStateProperty.all<double>(6),
                                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                  ),
                                                ),
                                                menuItemStyleData: const MenuItemStyleData(
                                                  height: 40,
                                                  padding: EdgeInsets.only(left: 14, right: 14),
                                                ),
                                              ),
                                            ),

                                          ),
                                        ),
                                      ],
                                    ):

                                    SizedBox(height: 10,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:0.0),
                                              child: Text("Basic Pay *",style: GoogleFonts.poppins(fontSize: 15,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 25),
                                              child: Container(child:
                                              TextField(controller: basicpay,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                              ),
                                                width: width/5.902,
                                                height: height/16.425,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                              ),
                                            ),

                                          ],

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0,right: 25),
                                          child: GestureDetector(
                                            onTap:(){
                                              getpay();
                                            },
                                            child: Container(child:
                                            Center(child: Text("Generate Payroll",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                                            ),
                                              width: width/5.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: const Color(0xff00A0E3),borderRadius: BorderRadius.circular(5)),

                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:0.0),
                                              child: Text("HRA *",style: GoogleFonts.poppins(fontSize: 15,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 10),
                                              child: Container(
                                                width: width/5.902,
                                                height: height/16.425,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                child:  TextField(controller: hra,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                ),


                                              ),
                                            ),

                                          ],

                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:0.0),
                                              child: Text("DA *",style: GoogleFonts.poppins(fontSize: 15,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 10),
                                              child: Container(
                                                width: width/5.902,
                                                height: height/16.425,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                child:  TextField(controller: da,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                ),


                                              ),
                                            ),

                                          ],

                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:0.0),
                                              child: Text("Other Allowance  *",style: GoogleFonts.poppins(fontSize: 15,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 10),
                                              child: Container(
                                                width: width/5.902,
                                                height: height/16.425,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                child:  TextField(controller: other,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                ),


                                              ),
                                            ),

                                          ],

                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:0.0),
                                              child: Text("Gross Salary *",style: GoogleFonts.poppins(fontSize: 15,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0,right: 10),
                                              child: Container(
                                                width: width/5.902,
                                                height: height/16.425,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(color: const Color(0xffDDDEEE),borderRadius: BorderRadius.circular(5)),

                                                child:  TextField(controller: gross,decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10,bottom: 8),),style: GoogleFonts.poppins(
                                                    fontSize: 15
                                                ),
                                                ),


                                              ),
                                            ),

                                          ],

                                        ),
                                        SizedBox(width: 450,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0,right: 25),
                                          child: GestureDetector(
                                            onTap:(){
                                              Svaepayroll();
                                              Successdialog();
                                            },
                                            child: Container(child:
                                            Center(child: Text("Save Payroll",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                                            ),
                                              width: width/5.902,
                                              height: height/16.425,
                                              //color: Color(0xffDDDEEE),
                                              decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],

                                ) :Container()
                              ,


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


            ),
          ) :
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 1000,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 20,bottom: 10,left: 40),
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right:600),
                          child: Container(child: Text("Payroll for ${type.text}",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
                            width:20,
                            height: height/25.269,

//decoration: BoxDecoration(color: Color(0xffF5F5F5),borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              setState(() {
                                view=false;
                              });
                            },

                            child: Icon(Icons.cancel,color: Colors.red,))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0),
                    child: Container(
                      width: width/1.050,

                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height/13.14,
                              width: width/1.55333,

                              decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 20.0),
                                    child: Text("Si.no",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Text("Designation",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  SizedBox(width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Text("Basic Pay",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  SizedBox(width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Text("HRA",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  SizedBox(width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Text("DA",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  SizedBox(width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Text("Others",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                  SizedBox(width: 50,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Text("Gross Pay",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                                  ),
                                ],
                              ),

                            ),
                          ),
                          Container(
                            height:200,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("PayrollMaster").orderBy("timestamp").snapshots(),

                                builder: (context,snapshot){
                                  if(!snapshot.hasData)
                                  {
                                    return   Center(
                                      child:  CircularProgressIndicator(),
                                    );
                                  }
                                  if(snapshot.hasData==null)
                                  {
                                    return   Center(
                                      child:  CircularProgressIndicator(),
                                    );
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context,index){
                                        var value = snapshot.data!.docs[index];
                                        return
                                          value["assignto"]==type.text?
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height/ 21.9,
                                            width: width/1.55333,

                                            decoration: BoxDecoration(color:Colors.white60,borderRadius: BorderRadius.circular(12)

                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 30.0),
                                                  child: Text((index+1).toString().padLeft(3,"0"),style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color:  Colors.black),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20,right: 8.0),
                                                  child: Text(value["Designations"],style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color:   Colors.black),),
                                                ),
                                                SizedBox(width: 50,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 45.0,right: 8.0),
                                                  child: Text(value["basic"],style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color:  Colors.black),),
                                                ),
                                                SizedBox(width: 50,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                  child: Text(value["hra"],style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color:  Colors.black),),
                                                ),
                                                SizedBox(width: 50,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                  child: Text(value["da"],style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color:  Colors.black),),
                                                ),
                                                SizedBox(width: 50,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                                  child: Text(value["other"],style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color:  Colors.black),),
                                                ),
                                                SizedBox(width: 50,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                                                  child: Text(value["gross"],style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xff53B175)),),
                                                ),
                                              ],
                                            ),

                                          ),
                                        ) : Container();
                                      });

                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


            ),
          )

        ],
      ),
    );
  }
  Svaepayroll(){
    FirebaseFirestore.instance.collection("PayrollMaster").doc().set({
      "assignto":type.text,
      "Designations":_typeAheadControllerclass.text,
      "basic":basicpay.text,
      "hra":hra.text,
      "da":da.text,
      "other":other.text,
      "gross":gross.text,
      "timestamp":DateTime.now().microsecondsSinceEpoch
    });
  }
  Successdialog(){
    return AwesomeDialog(
      width: 450,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Payroll generated Successfully',


      btnOkOnPress: () {
         basicpay.clear();
         hra.clear();
         da.clear();
         other.clear();
         gross.clear();

      },
    )..show();
  }
}
