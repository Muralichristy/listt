import 'package:flutter/material.dart';
class   pageview  extends StatefulWidget {
   final String numbers;
  final Function (String)onEdit;
  pageview({Key? key,required this.numbers,required this.onEdit}):super(key: key);

  @override
  State<  pageview > createState() => _pageviewState();
}

class _pageviewState extends State<pageview > {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Values",style: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 20,
        ),),
        backgroundColor: Color(0xff705958),
      ),
      body: Column(
        children: [SizedBox(height: 50,),
        AlertDialog(
          title: Text("The number is:${widget.numbers}"),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Edit"
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(onPressed: (){
                setState(() {
                  widget.onEdit(controller.text);
                  Navigator.pop(context);
                });
              }, child: Text("Edit")),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(onPressed: (){
                setState(() {
                  Navigator.pop(context);
                });
              }, child: Text("cancel")),
            )
          ],
        )],
      ),
    );
  }
}
