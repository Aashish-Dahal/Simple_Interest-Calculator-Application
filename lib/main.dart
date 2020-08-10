import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest",
    home: MyApp(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      
    ),
  ));
}
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _formKey=GlobalKey<FormState>();
  TextEditingController principalController=TextEditingController();
   TextEditingController roiController=TextEditingController();
    TextEditingController termController=TextEditingController();
  var _currencies=['Rupees','Dollars','Pounds',];
  var _SelectedItem='Rupees';
  var _displayResult="";

  @override
  Widget build(BuildContext context) {
      TextStyle textStyle=Theme.of(context).textTheme.headline6;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body:Form(
        key: _formKey,
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
             
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               getImage(),
               SizedBox(height: 10,),
               TextFormField(

                 style: textStyle,
                 validator: (String value){
                   if(value.isEmpty){
                     return 'Please enter principal amount ';
                   }
                 },
                 controller: principalController,
         decoration: InputDecoration(
           
           labelText: "Principal",
           hintText: "Enter Principal e.g. 12000",
           labelStyle: textStyle,
           errorStyle: TextStyle(
             color: Colors.yellowAccent,
             fontSize: 15.0
           ),
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(5.0),
           )
         ),
         keyboardType: TextInputType.number,
               ),
               SizedBox(height: 10,),
         TextFormField(
           style: textStyle,
           validator: (String value){
                   if(value.isEmpty){
                     return 'Please enter rate of interest ';
                   }
                 },
           keyboardType: TextInputType.number,
           controller: roiController,
         decoration: InputDecoration(
           labelText: "Rate of Interest",
           hintText: "In percent",
           errorStyle: TextStyle(
             color: Colors.yellowAccent,
             fontSize: 15.0
           ),
           labelStyle: textStyle,
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(5.0),
           )
         ),
         
               ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
             child: TextFormField(
               style: textStyle,
               validator: (String value){
                   if(value.isEmpty){
                     return 'Please enter time ';
                   }
                 },
           keyboardType: TextInputType.number,
           controller: termController,
         decoration: InputDecoration(
           labelStyle: textStyle,
           labelText: "Term",
           errorStyle: TextStyle(
             color: Colors.yellowAccent,
             fontSize: 15.0
           ),
           hintText: "Time in years",
           border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(5.0),
           )
         ),
         
               ),
            ),
        SizedBox(width: 10,),
        Expanded(
             child: DropdownButton<String>(
            items: _currencies.map((String dropdrownStringItem){
              return DropdownMenuItem(
                value: dropdrownStringItem,
                child: Text(dropdrownStringItem),
              );
            }).toList(),
            onChanged: (String newSelectedValueItem){
                setState(() {
                  _SelectedItem=newSelectedValueItem;
                });
            },
            value: _SelectedItem,
          ),
        )
          ],
        ),
        SizedBox(height: 10,),
        Row(children: [
          Expanded(
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).primaryColorDark,
              child: Text('Calculate',textScaleFactor: 1.3,),
              onPressed: (){
              this. _displayResult=_calculateTotalReturns();
              },
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              child: Text('Reset',textScaleFactor: 1.3,),
              onPressed: (){
                _reset();
              },
            ),
          )
        ],),
        SizedBox(height: 10,),
        Text(this._displayResult,style: textStyle,)
              ],
            ),
          ),
      ),
    );
  }
  Widget getImage(){
    AssetImage assestImage=AssetImage('images/money.png');
    Image image=Image(image: assestImage,width: 125.0,height: 125.0,);
    return Container(child: image,);
  }
  String _calculateTotalReturns(){
    double principle=double.parse(principalController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);
    double totalAmount=principle+(principle*roi*term)/100;
    String result='After $term years,your investment will be worth $totalAmount';
    return result;

  }
  void _reset(){
    principalController.text='';
    roiController.text='';
    termController.text='';
    _displayResult='';
    _SelectedItem=_currencies[0];
  }
}
