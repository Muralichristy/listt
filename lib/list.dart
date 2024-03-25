import 'package:flutter/material.dart';
import 'package:lists/nextpage.dart';

class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  TextEditingController controller = TextEditingController();
  List<int> numbers = [];
  int? minValue;
  int? maxValue;
  bool ascendingOrder = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateMinMax() {
    if (numbers.isNotEmpty) {
      minValue = numbers.reduce((value, element) => value < element ? value : element);
      maxValue = numbers.reduce((value, element) => value > element ? value : element);
    } else {
      minValue = null;
      maxValue = null;
    }
  }

  Future<void> showAlertDialog(String title, String content, {bool isFilter = false}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content),
              if (isFilter) ...[
                Text("Minimum Value: ${minValue ?? ''}"),
                Text("Maximum Value: ${maxValue ?? ''}"),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void sortNumbers(bool ascending) {
    setState(() {
      ascendingOrder = ascending;
      if (ascendingOrder) {
        numbers.sort();
      } else {
        numbers.sort((a, b) => b.compareTo(a));
      }
    });
  }

  void filterNumbers(bool greaterThan) {
    List<int> filteredNumbers = numbers.where((number) =>
    greaterThan ? number > 5 : number < -5).toList();
    if (filteredNumbers.isNotEmpty) {
      minValue = filteredNumbers.reduce((value, element) =>
      value < element ? value : element);
      maxValue = filteredNumbers.reduce((value, element) =>
      value > element ? value : element);
    } else {
      minValue = null;
      maxValue = null;
    }
    showAlertDialog(
      greaterThan ? 'Greater than 5' : 'Lesser than -5',
      'Numbers filtered ${greaterThan ? 'greater than 5' : 'lesser than -5'}',
      isFilter: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'Enter a number',
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    var input = int.tryParse(controller.text);
                    if (input != null) {
                      numbers.add(input);
                      updateMinMax();
                      controller.clear();
                    } else {
                      showAlertDialog(
                          'Invalid Input', 'Please enter a valid number.');
                    }
                  });
                },
                child: Text("ADD"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.clear();
                },
                child: Text("Clear"),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  sortNumbers(true);
                },
                child: Text("Ascending"),
              ),
              ElevatedButton(
                onPressed: () {
                  sortNumbers(false);
                },
                child: Text("Descending"),
              ),
            ],
          ),
          SizedBox(height: 50),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(numbers[index].toString()),
                  onTap: () async {
                    final editedNumber = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pagenext(
                          numbers: numbers[index].toString(),
                          onEdit: (editedNumber) {
                            if (editedNumber != null) {
                              setState(() {
                                numbers[index] = int.parse(editedNumber);
                              });
                            }else{
                              setState(() {
                                numbers.removeAt(index);
                              });
                            }
                          },
                          onDelete: (){
                            setState(() {
                              numbers.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                    if (editedNumber != null) {
                      setState(() {
                        numbers[index] = int.parse(editedNumber);
                      });
                    }
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => filterNumbers(true),
                child: Text("greater > 5"),
              ),
              ElevatedButton(
                onPressed: () => filterNumbers(false),
                child: Text("lesser < -5"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


