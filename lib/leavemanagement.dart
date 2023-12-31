import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Leave extends StatefulWidget {
  const Leave({Key? key}) : super(key: key);

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {

  Future<void> rejectdialog(String docid, String staffRegNo) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you sure of rejecting this application',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

                    child:  Lottie.asset("assets/thinking.json")),
                //child:  Lottie.asset("assets/file choosing.json")),
                actions: <Widget>[
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cancel,color: Colors.white,),
                          ),
                          Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                   InkWell(
                    onTap: () async {
                      FirebaseFirestore.instance.collection('Leave').doc(docid).update({
                        "status" : 'Denied'
                      });
                      String staffDocId = '';
                      var staffs = await FirebaseFirestore.instance.collection('Staffs').get();
                      for (var element in staffs.docs) {
                        if(element.get("regno") == staffRegNo){
                          staffDocId = element.id;
                        }
                      }
                      FirebaseFirestore.instance.collection('Staffs').doc(staffDocId).collection('Leave').doc(docid).update({
                        "status" : 'Denied'
                      });
                      Navigator.pop(context);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.error,color: Colors.white,),
                          ),
                          Text("Reject",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                ],
              );
            }
        );
      },
    );
  }
  Future<void> approvedialog(String docid, String staffRegNo) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        double width=MediaQuery.of(context).size.width;
        double height=MediaQuery.of(context).size.height;
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                title:  Text('Are you sure of approving this application',style: GoogleFonts.poppins(
                    color: Colors.black, fontSize:18,fontWeight: FontWeight.w600),),
                content:  Container(
                    width: 350,
                    height: 250,

                    child:  Lottie.asset("assets/approve.json")),
                //child:  Lottie.asset("assets/file choosing.json")),
                actions: <Widget>[
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.cancel,color: Colors.white,),
                          ),
                          Text("Cancel",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.red,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                   InkWell(
                    onTap: () async {
                      FirebaseFirestore.instance.collection('Leave').doc(docid).update({
                        "status" : 'Approved'
                      });
                      String staffDocId = '';
                      var staffs = await FirebaseFirestore.instance.collection('Staffs').get();
                      for (var element in staffs.docs) {
                        if(element.get("regno") == staffRegNo){
                          staffDocId = element.id;
                        }
                      }
                      FirebaseFirestore.instance.collection('Staffs').doc(staffDocId).collection('Leave').doc(docid).update({
                        "status" : 'Approved'
                      });
                      Navigator.pop(context);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 7,
                      child: Container(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.done,color: Colors.white,),
                          ),
                          Text("Approve",style: GoogleFonts.poppins(color:Colors.white),),
                        ],
                      )),
                        width: width/10.507,
                        height: height/20.425,
                        // color:Color(0xff00A0E3),
                        decoration: BoxDecoration(color:  Colors.green,borderRadius: BorderRadius.circular(5)),

                      ),
                    ),
                  ),
                ],
              );
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Leave').orderBy("timestamp",descending: true).snapshots(),
        builder: (ctx, snap){
          if(snap.hasData){
            List newLeaveRequests = [];
            List approvedLeavesRequests = [];
            List deniedLeaveRequests = [];
            snap.data!.docs.forEach((element) {
              if(element.get("status").toString().toLowerCase() == "approved"){
                approvedLeavesRequests.add(element);
              }else if(element.get("status").toString().toLowerCase() == "denied"){
                deniedLeaveRequests.add(element);
              }else if(element.get("status").toString().toLowerCase() == "pending"){
                newLeaveRequests.add(element);
              }
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //card design1
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                      child:
                      Container(
                        height: height/4.69,
                        width: width/4.017,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors:[Color(0xff6BAAFC),Color(0xff305FEC)])
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left:width/136.6,
                                      top: height/65.7
                                  ),

                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("New Leave Requests",style: GoogleFonts.poppins(
                                          fontSize:width/75.88,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),),
                                      Container(
                                        child: Text(
                                          newLeaveRequests.length.toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: width/22.76),),
                                        margin: EdgeInsets.only(right: width/68.3),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                    top: height/32.85,
                                    right:width/68.3,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    //card design2
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                      child: Container(
                        height: height/4.69,
                        width: width/4.017,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors:[Color(0xff5cb80d),Color(0xff078513)])
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(left:10,top: 10),

                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Approved Leave Requests",style: GoogleFonts.poppins(fontSize: 18,
                                          fontWeight: FontWeight.w700,color: Colors.white),),
                                      Container(
                                        child: Text(
                                          approvedLeavesRequests.length.toString(),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,fontSize: 60),),
                                        margin: EdgeInsets.only(right: 20),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(top: 20,right: 20,),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    //card design3
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                      child: Container(
                        height: height/4.69,
                        width: width/4.017,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors:[Color(0xffEF5E7A),Color(0xffD35385)])

                        ),
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(left:10,top: 10),

                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Denied Leave Requests",style: GoogleFonts.poppins(fontSize: 18,
                                          fontWeight: FontWeight.w700,color: Colors.white),),
                                      Container(
                                        child: Text(
                                          deniedLeaveRequests.length.toString(),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,fontSize: 60),),
                                        margin: EdgeInsets.only(right: 20),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(top: 20,right: 20,),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("New Leave Requests,",style: GoogleFonts.poppins(
                    fontSize:width/75.88,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height:height/13.14,
                    width: width/1.366,
                    decoration: BoxDecoration(color:Color(0xff00A0E3),borderRadius: BorderRadius.circular(12)

                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, right: 40),
                          child: Text(
                            "Reg NO",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        Text(
                          "Staff Name",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40,),
                          child: Text(
                            "Date Applied",
                            style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                        Text(
                          "Leave Date",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Phone Number",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 150.0),
                          child: Text(
                            "Actions",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    //color: Colors.pink,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: newLeaveRequests.length,
                    itemBuilder: (context,index){
                      var value = newLeaveRequests[index];
                      return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width/1.366,
                          child: Row(
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 0),
                                child: Container(
                                  width: width/13.66,
                                  alignment: Alignment.center,
                                  child: Text(
                                    value["regno"],
                                    style:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Container(
                                  width: width/11.757,
                                  child: Text(
                                    value["staffname"],
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, right: 0),
                                child: Container(
                                  width: width/15.766,

                                  child: Text(
                                    value["date"],
                                    style:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Container(
                                  width:width/15.766,

                                  alignment: Alignment.center,
                                  child: Text(
                                    value["leaveon"],
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:50.0),
                                child: Container(
                                  width: width/9.7571,
                                  child: Text(
                                    value["phoneno"],
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color:Colors.indigoAccent),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  approvedialog(value.id,value["regno"]);
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 45.0),
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                          "Approve",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        )),
                                    width: width/18.76,
                                    height: height/21.9,
                                    //color: Color(0xffD60A0B),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: Color(0xff53B175),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  rejectdialog(value.id,value["regno"]);
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 45.0),
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                          "Deny",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        )),
                                    width: width/18.76,
                                    height: height/21.9,
                                    //color: Color(0xffD60A0B),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //color: Colors.pink,


                        ),
                      );
                    })
              ],
            );
          }return Container();
        },
      ),
    );
  }
}
