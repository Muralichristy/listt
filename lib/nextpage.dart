import 'dart:ui';
import 'package:flutter/material.dart';
class pagenext extends StatefulWidget {
  final String numbers ;
  final  Function onEdit;
  final VoidCallback onDelete;
  pagenext({required this.numbers,required this.onEdit, required this.onDelete});

  @override
  State<pagenext> createState() => _pagenextState();
}
class _pagenextState extends State<pagenext> {
  TextEditingController controller = TextEditingController();

  @override
  void initState(){
    super.initState();
     controller.text = widget.numbers.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Next screen',
        style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20),)),
        backgroundColor: Color(0xffa9d6b5)
      ),
      body: Column(
        children: [
          Text("The number is ${widget.numbers}"),
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
                },
                  child: Text("EDIT"),

                ),
              ),

              SizedBox(height: 10,),
              Center(
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    widget.onEdit(null);
                    Navigator.pop(context);
                  });
                }, child: Text("DELETE")),
              ),

            ],
          )],


      ),
    );
  }
}
