import 'package:flutter/material.dart';
import '../footer.dart';
import '../header.dart';

class PostingPage extends StatefulWidget {

  @override
  _PostingState createState() => _PostingState();

}
class _PostingState extends State<PostingPage> {
  //final List<String> _dropdownItems = <String>['症状なし', 'USA'];
  //String _dropdownValue = 'India';

  double _value = 0.0;
  double _startValue = 0.0;
  double _endValue = 0.0;

  void _changeSlider(double e) => setState(() { _value = e; });
  void _startSlider(double e) => setState(() { _startValue = e; });
  void _endSlider(double e) => setState(() { _endValue = e; });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 10,
                  decoration: InputDecoration(
                    icon: Icon(Icons.set_meal),
                    labelText: '料理名',
                    helperText: 'Helper text',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
                Slider(
                  label: '${_value}',
                  min: 0,
                  max: 5,
                  value: _value,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.blueAccent,
                  divisions: 5,
                  onChanged: _changeSlider,
                  onChangeStart: _startSlider,
                  onChangeEnd: _endSlider,
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 10,
                  initialValue: "無症状",
                  decoration: InputDecoration(
                    icon: Icon(Icons.emoji_food_beverage),
                    labelText: '症状',
                    helperText: 'Helper text',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 10,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: '場所',
                    helperText: 'Helper text',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  maxLength: 20,
                  decoration: InputDecoration(
                    icon: Icon(Icons.food_bank),
                    labelText: '備考',
                    helperText: 'Helper text',
                    errorText: 'Error message',
                    suffixIcon: Icon(
                      Icons.error,
                    ),
                  ),
                ),
                TextFormField(
                  maxLength: 140,
                  maxLines: 5,
                  autocorrect: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                    labelText: 'Label text',
                    helperText: 'Helper text',
                    hintText: 'Enter Your Email Here...',
                    prefixIcon: Icon(Icons.email),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                ),
                // FormField(
                //   builder: (FormFieldState state) {
                //     return DropdownButtonHideUnderline(
                //       child: new Column(
                //         crossAxisAlignment: CrossAxisAlignment.stretch,
                //         children: <Widget>[
                //           new InputDecorator(
                //             decoration: InputDecoration(
                //               filled: false,
                //               hintText: 'Choose Country',
                //               prefixIcon: Icon(Icons.location_on),
                //               labelText: 'Where are you from',
                //               errorText: "",
                //             ),
                //             //isEmpty: _dropdownValue == null,
                //             child: new DropdownButton<String>(
                //               value: _dropdownValue,
                //               isDense: true,
                //               onChanged: (String newValue) {
                //                 print('value change');
                //                 print(newValue);
                //
                //                 setState(() {
                //                   _dropdownValue = newValue;
                //                 });
                //
                //               },
                //               items: _dropdownItems.map((String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // )
              ],
            ),
          ),
        )
    );
  }
}
