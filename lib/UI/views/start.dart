import 'package:teukoo_code/UI/widgets/my_material.dart';
import 'package:teukoo_code/viewmodels/start_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class StartView extends StatelessWidget {
  const StartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartViewModel>.withConsumer(
      viewModel: StartViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor:MyColor.primaryBackground,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation(
                  MyColor.nextCamera,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}