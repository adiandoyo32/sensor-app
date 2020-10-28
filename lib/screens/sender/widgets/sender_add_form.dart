import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/senders.dart';
import 'package:sensor_app/screens/sender/widgets/sender_pick_location.dart';
import 'package:sensor_app/screens/widgets/buttons/primary_button.dart';
import 'package:sensor_app/utils/mixins/form_validation.dart';

class SenderAddForm extends StatefulWidget {
  @override
  _SenderAddFormState createState() => _SenderAddFormState();
}

class _SenderAddFormState extends State<SenderAddForm> with Validation {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _locationFieldController = TextEditingController();

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => SenderPickLocation(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _locationFieldController.text =
        '${selectedLocation.latitude} ${selectedLocation.longitude}';
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    Provider.of<Senders>(context, listen: false)
        .createSender(_nameFieldController.text, _locationFieldController.text)
        .then((res) {
      if (res) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Text("Location"),
              SizedBox(height: 4),
              TextFormField(
                controller: _locationFieldController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Choose on map",
                  isDense: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      _selectOnMap();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: validateLocation,
              ),
              SizedBox(height: 40),
              PrimaryButton(
                text: "Submit",
                onPress: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
  }
}
