import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class WithdrawReq extends StatefulWidget {
  const WithdrawReq({Key? key}) : super(key: key);

  @override
  State<WithdrawReq> createState() => _WithdrawReqState();
}

class _WithdrawReqState extends State<WithdrawReq> {

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw Requests"),
        centerTitle: true,
        elevation: 0.00,
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        height: h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('withDrawRequests')
                      .where('status', isEqualTo: 0)
                      .snapshots(),

                  builder: (context, snapshot) {
                    print(snapshot.error);
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                      return Text("Empty");
                    } else {
                      List<DocumentSnapshot> data = snapshot.data!.docs;
                      int len = data.length;
                      return Container(
                        height: h,
                        child: ListView.builder(
                            itemCount: len,
                            itemBuilder: (context,index){
                              DocumentSnapshot doc = data[index];
                              return ListTile(
                                leading: Text(doc['withdrawAmount'].toString()),
                                trailing: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(onPressed: (){
                                      doc.reference.update({'status':1});
                                      setState(() {});
                                    } , icon: Icon(Icons.check)),
                                    IconButton(onPressed: () {
                                      doc.reference.update({'status':2}).then((value) async => {
                                      await FirebaseFirestore.instance.collection('stations').doc(doc['userId']).update({
                                      'balance':FieldValue.increment(doc['withdrawAmount'] ?? 0)})
                                      });

                                      setState(() {});
                                    } , icon: Icon(Icons.delete))
                                  ],
                                ),
                                title: Text(doc['name']),
                                subtitle: Text(DateFormat('dd-MMM-yyyy').format(doc['date'].toDate())),
                              );
                            }
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
