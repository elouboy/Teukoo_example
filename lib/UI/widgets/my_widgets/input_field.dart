import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teukoo/UI/shared/shared_styles.dart';
import 'package:teukoo/UI/shared/ui_helpers.dart';
import 'package:teukoo/UI/widgets/my_material.dart';

import 'note_text.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;
  final bool password;
  final bool age;
  final bool isReadOnly;
  final String placeholder;
  final String validationMessage;
  final Function enterPressed;
  final int maxLines;
  final bool smallVersion;
  final FocusNode fieldFocusNode;
  final FocusNode nextFocusNode;
  final TextInputAction textInputAction;
  final String additionalNote;
  final Function(String) onChanged;
  final TextInputFormatter formatter;
  
  InputField(
      {@required this.controller,
      @required this.placeholder,
      this.enterPressed,
      this.fieldFocusNode,
      this.maxLines,
      this.nextFocusNode,
      this.additionalNote,
      this.onChanged,
      this.validator,
      this.formatter,
      this.validationMessage,
      this.textInputAction = TextInputAction.next,
      this.textInputType,
      this.password = false,
      this.age=false,
      this.isReadOnly = false,
      this.smallVersion = false});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isPassword;
  double fieldHeight = 55;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: widget.smallVersion ? 40 : fieldHeight,
          alignment: Alignment.centerLeft,
          padding: fieldPadding,
          decoration:
              widget.isReadOnly ? disabledFieldDecortaion : fieldDecortaion,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  maxLines: widget.maxLines,
                  keyboardType: widget.textInputType,
                  focusNode: widget.fieldFocusNode,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  validator: widget.validator,
                  
                  inputFormatters:
                      widget.formatter != null ? [widget.formatter] : null,
                  onEditingComplete: () {
                    if (widget.enterPressed != null) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      widget.enterPressed();
                    }
                  },
                  onFieldSubmitted: (value) {
                    if (widget.nextFocusNode != null) {
                      widget.nextFocusNode.requestFocus();
                    }
                  },
                  obscureText: isPassword,
                  readOnly: widget.isReadOnly,
                  style:TextStyle(
                  color: Color(0xFFFFFFFF),),
                  decoration: InputDecoration.collapsed(
                      hintText: widget.placeholder,
                      hintStyle:
                          TextStyle(fontSize: widget.smallVersion ? 12 : 15, color: Color(0xFFFFFFFF),),
                          ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  isPassword = !isPassword;
                }),
                child: widget.password
                    ? Container(
                        width: fieldHeight,
                        height: fieldHeight,
                        alignment: Alignment.center,
                        child: Icon(isPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                            color: Color(0xFFFFFFFF) ))
                    : Container(),
              ),
            ],
          ),
        ),
        if (widget.validationMessage != null)
          NoteText(
            widget.validationMessage,
            color: Colors.red,
          ),
        if (widget.additionalNote != null) verticalSpace(5),
        if (widget.additionalNote != null) NoteText(widget.additionalNote),
        verticalSpaceSmall
      ],
    );
  }
}