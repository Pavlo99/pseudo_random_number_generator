import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final numberCountController = TextEditingController();
  final comparisonModuleController = TextEditingController();
  final multiplierController = TextEditingController();
  final increaseController = TextEditingController();
  final initialNumberController = TextEditingController();
  final allNumberTextController = TextEditingController();

  int period = 0;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    numberCountController.text = 900.toString();

    comparisonModuleController.text = 1023.toString();
    multiplierController.text = 32.toString();
    increaseController.text = 0.toString();
    initialNumberController.text = 2.toString();

    comparisonModuleController.text = 2047.toString();
    multiplierController.text = 243.toString();
    increaseController.text = 1.toString();
    initialNumberController.text = 4.toString();
    //
    // multiplierController.text = 2197.toString();
    // increaseController.text = 1597.toString();
    // comparisonModuleController.text = 67108863.toString();
    // initialNumberController.text = 13.toString();

    // multiplierController.text = 2744.toString();
    // increaseController.text = 2584.toString();
    // comparisonModuleController.text = 134217727.toString();
    // initialNumberController.text = 17.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getForm(node),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white),
                child: ElevatedButton(
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {
                      generateButtonClick();
                    }
                  },
                  child: Text('Generate'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white),
                child: ElevatedButton(
                  onPressed: (){
                    cleanArea();
                  },
                  child: Text('Clean'),
                ),
              ),
              Text('Period = $period'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white),
                child: TextField(
                  controller: allNumberTextController,
                  maxLines: null,
                  readOnly: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'There will be your numbers here',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getForm(FocusScopeNode node) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              var numValue = int.tryParse(value!);
              if (numValue == null || numValue < 1) {
                return 'Please enter number count(n > 0)';
              }
              return null;
            },
            onEditingComplete: () => node.nextFocus(),
            textInputAction: TextInputAction.next,
            controller: numberCountController,
            autofocus: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'N',
              border: InputBorder.none,
              hintText: 'Enter number count',
            ),
          ),
          Divider(
            height: 2,
          ),
          TextFormField(
            validator: (value) {
              var numValue = int.tryParse(value!);
              if (numValue == null || numValue < 1) {
                return 'Please enter comparison module(m > 0)';
              }
              return null;
            },
            onEditingComplete: () => node.nextFocus(),
            textInputAction: TextInputAction.next,
            controller: comparisonModuleController,
            autofocus: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'm',
              border: InputBorder.none,
              hintText: 'Enter comparison module',
            ),
          ),
          Divider(
            height: 2,
          ),
          TextFormField(
            validator: (value) {
              var numValue = int.tryParse(value!);
              var comparisonModule =
                  int.tryParse(comparisonModuleController.text) ?? 0;
              if (numValue == null ||
                  numValue < 1 ||
                  numValue >= comparisonModule) {
                return 'Please enter multiplier(0 <= a < m)';
              }
              return null;
            },
            onEditingComplete: () => node.nextFocus(),
            textInputAction: TextInputAction.next,
            controller: multiplierController,
            autofocus: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'a',
              border: InputBorder.none,
              hintText: 'Enter multiplier',
            ),
          ),
          Divider(
            height: 2,
          ),
          TextFormField(
            validator: (value) {
              var numValue = int.tryParse(value!);
              var comparisonModule =
                  int.tryParse(comparisonModuleController.text) ?? 0;
              if (numValue == null ||
                  numValue < 0 ||
                  numValue >= comparisonModule) {
                return 'Please enter increase(0 <= c < m)';
              }
              return null;
            },
            onEditingComplete: () => node.nextFocus(),
            textInputAction: TextInputAction.next,
            controller: increaseController,
            autofocus: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'c',
              border: InputBorder.none,
              hintText: 'Enter increase',
            ),
          ),
          Divider(
            height: 2,
          ),
          TextFormField(
            validator: (value) {
              var numValue = int.tryParse(value!);
              var comparisonModule =
                  int.tryParse(comparisonModuleController.text) ?? 0;
              if (numValue == null ||
                  numValue < 1 ||
                  numValue >= comparisonModule) {
                return 'Please enter initial number(0 <= Xo < m)';
              }
              return null;
            },
            onEditingComplete: () => node.nextFocus(),
            textInputAction: TextInputAction.next,
            controller: initialNumberController,
            autofocus: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Xo',
              border: InputBorder.none,
              hintText: 'Enter initial number',
            ),
          ),
        ],
      ),
    );
  }

  generateButtonClick() {
    cleanArea();
    print('generate');
    int n = int.tryParse(numberCountController.text) ?? 0;
    allNumberTextController.text += initialNumberController.text + '  ';
    int x = getNumber(int.tryParse(initialNumberController.text) ?? 0);

    var firstX = x;
    for (int i = 0; i < n; i++) {
      allNumberTextController.text += x.toString() + '  ';
      x = getNumber(x);
      if (firstX == x && period == 0)
        setState(() {
          period = i+1;
        });
    }
    _write(allNumberTextController.text);
    print('generate finish');
  }

  cleanArea() {
    print('clean');
    setState(() {
      period = 0;
    });
    allNumberTextController.text = '';
  }

  int getNumber(int x) {
    var m = int.tryParse(comparisonModuleController.text) ?? 0;
    var a = int.tryParse(multiplierController.text) ?? 0;
    var c = int.tryParse(increaseController.text) ?? 0;
    return (x * a + c) % m;
  }

  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(text);
  }
}
