import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordWidget extends StatefulWidget {
  ChangePasswordWidget({Key key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  TextEditingController phoneNumberController;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.dark600,
            size: 32,
          ),
        ),
        title: Text(
          'Change Password',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: phoneNumberController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                labelStyle: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: FlutterFlowTheme.grayIcon,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.gray200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.gray200,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.tertiaryColor,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Lexend Deca',
                color: FlutterFlowTheme.primaryDark,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'We will send you an email with a link to reset your password, please enter the email associated with your account above.',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                setState(() => _loadingButton = true);
                try {
                  if (phoneNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Email required!',
                        ),
                      ),
                    );
                    return;
                  }
                  await resetPassword(
                    email: phoneNumberController.text,
                    context: context,
                  );
                } finally {
                  setState(() => _loadingButton = false);
                }
              },
              text: 'Send Reset Link',
              options: FFButtonOptions(
                width: 200,
                height: 50,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: FlutterFlowTheme.tertiaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 30,
              ),
              loading: _loadingButton,
            ),
          )
        ],
      ),
    );
  }
}
