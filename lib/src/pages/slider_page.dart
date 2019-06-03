import 'package:flutter/material.dart';

class SlidersPage extends StatefulWidget {
  @override
  _SlidersPageState createState() => _SlidersPageState();
}

class _SlidersPageState extends State<SlidersPage> {
  double _sliderValue = 100.0;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders Page'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _createSlider(),
            _checkBox(),
            _createSwitch(),
            Expanded(child: _createImage()),
          ],
        ),
      ),
    );
  }

  Widget _createSlider() {
    return Slider(
      activeColor: Colors.blue,
      label: 'Image Size',
      divisions: 20,
      value: _sliderValue,
      min: 10.0,
      max: 400.0,
      onChanged: (_isChecked)
          ? null
          : (value) {
              setState(() {
                _sliderValue = value;
              });
            },
    );
  }

  Widget _createImage() {
    return Image(
      image: NetworkImage('http://pngimg.com/uploads/batman/batman_PNG111.png'),
      width: _sliderValue,
      fit: BoxFit.contain,
    );
  }

  Widget _checkBox() {
    return CheckboxListTile(
      title: Text('Block Image Slider'),
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          _isChecked = value;
        });
      },
    );

    // return Checkbox(
    //   value: _isChecked,
    //   onChanged: (value) {
    //     setState(() {
    //       _isChecked = value;
    //     });
    //   },
    // );
  }

  Widget _createSwitch() {
    return SwitchListTile(
      title: Text('Switch Image Slider'),
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          _isChecked = value;
        });
      },
    );
  }
}
