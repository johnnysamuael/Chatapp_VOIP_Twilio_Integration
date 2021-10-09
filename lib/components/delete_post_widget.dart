import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeletePostWidget extends StatefulWidget {
  DeletePostWidget({
    Key key,
    this.postParameters,
  }) : super(key: key);

  final UserPostsRecord postParameters;

  @override
  _DeletePostWidgetState createState() => _DeletePostWidgetState();
}

class _DeletePostWidgetState extends State<DeletePostWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.primaryDark,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FFButtonWidget(
              onPressed: () async {
                setState(() => _loadingButton1 = true);
                try {
                  await widget.postParameters.reference.delete();
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 220),
                      reverseDuration: Duration(milliseconds: 220),
                      child: NavBarPage(initialPage: 'homePage'),
                    ),
                  );
                } finally {
                  setState(() => _loadingButton1 = false);
                }
              },
              text: 'Delete Post',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60,
                color: Color(0xFFE06666),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 40,
              ),
              loading: _loadingButton1,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  setState(() => _loadingButton2 = true);
                  try {
                    Navigator.pop(context);
                  } finally {
                    setState(() => _loadingButton2 = false);
                  }
                },
                text: 'Cancel',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60,
                  color: FlutterFlowTheme.dark600,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 40,
                ),
                loading: _loadingButton2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
