import 'package:flutter/material.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';




class InputText extends StatelessWidget {
  
  final double taille;
  final int width = 300;
  @required final String hint;
  final TextEditingController controller; 

  InputText({
     @required this.taille,
     @required this.hint,
    this.controller, 
  }

  );


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: taille,

        decoration: BoxDecoration(
          color: MyColor.colorEditProfile,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration.collapsed(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 12,
              color: Color(0xFFC7C7CC),
              ),

            ),
        ),
        );
  }
    
  }
