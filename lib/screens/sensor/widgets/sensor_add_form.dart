import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/senders.dart';
import 'package:sensor_app/utils/mixins/form_validation.dart';

class SensorAddForm extends StatefulWidget {
  @override
  _SensorAddFormState createState() => _SensorAddFormState();
}

class _SensorAddFormState extends State<SensorAddForm> with Validation {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name"),
              SizedBox(height: 4),
              TextFormField(
                controller: _nameFieldController,
                decoration: InputDecoration(
                  hintText: "Name",
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: validateName,
              ),
              SizedBox(height: 16),
              Text("Sender"),
              SizedBox(height: 4),
              Consumer<Senders>(
                builder: (_, sender, __) => DropdownButton(
                  hint: Text('Select Sender'),
                  items: sender.senders
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
