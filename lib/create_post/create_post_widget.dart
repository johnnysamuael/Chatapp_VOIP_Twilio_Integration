import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import '../flutter_flow/upload_media.dart';
import '../main.dart';
import 'dart:io';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostWidget extends StatefulWidget {
  CreatePostWidget({Key key}) : super(key: key);

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController;
  var placePickerValue = FFPlace();
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.background,
        automaticallyImplyLeading: false,
        title: Text(
          'Create Post',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: Color(0xFF95A1AC),
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 350,
                                child: Stack(
                                  children: [
                                    Visibility(
                                      visible: !(functions.hasUploadedMedia(
                                              uploadedFileUrl) ??
                                          false),
                                      child: InkWell(
                                        onTap: () async {
                                          final selectedMedia =
                                              await selectMediaWithSourceBottomSheet(
                                            context: context,
                                            allowPhoto: true,
                                            allowVideo: true,
                                            backgroundColor:
                                                FlutterFlowTheme.dark600,
                                            textColor:
                                                FlutterFlowTheme.tertiaryColor,
                                            pickerFontFamily: 'Lexend Deca',
                                          );
                                          if (selectedMedia != null &&
                                              validateFileFormat(
                                                  selectedMedia.storagePath,
                                                  context)) {
                                            showUploadMessage(
                                                context, 'Uploading file...',
                                                showLoading: true);
                                            final downloadUrl =
                                                await uploadData(
                                                    selectedMedia.storagePath,
                                                    selectedMedia.bytes);
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            if (downloadUrl != null) {
                                              setState(() => uploadedFileUrl =
                                                  downloadUrl);
                                              showUploadMessage(
                                                  context, 'Success!');
                                            } else {
                                              showUploadMessage(context,
                                                  'Failed to upload media');
                                              return;
                                            }
                                          }
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 350,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF1F5F8),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/emptyPost@2x.png',
                                              ).image,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                color: Color(0x2D000000),
                                                offset: Offset(0, 1),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: functions.hasUploadedMedia(
                                              uploadedFileUrl) ??
                                          true,
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: FlutterFlowMediaDisplay(
                                          path: uploadedFileUrl,
                                          imageBuilder: (path) => Image.network(
                                            path,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          videoPlayerBuilder: (path) =>
                                              FlutterFlowVideoPlayer(
                                            path: path,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            autoPlay: false,
                                            looping: true,
                                            showControls: true,
                                            allowFullScreen: true,
                                            allowPlaybackSpeedMenu: false,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: textController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Comment....',
                                          hintStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF8B97A2),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.gray200,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.gray200,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 12),
                                        ),
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF090F13),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 4,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterFlowPlacePicker(
                        iOSGoogleMapsApiKey: '',
                        androidGoogleMapsApiKey: '',
                        webGoogleMapsApiKey: '',
                        onSelect: (place) =>
                            setState(() => placePickerValue = place),
                        defaultText: 'Location',
                        icon: Icon(
                          Icons.place,
                          color: FlutterFlowTheme.grayIcon,
                          size: 24,
                        ),
                        buttonOptions: FFButtonOptions(
                          width: 300,
                          height: 60,
                          color: Colors.white,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFDBE2E7),
                            width: 2,
                          ),
                          borderRadius: 8,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
              child: FFButtonWidget(
                onPressed: () async {
                  setState(() => _loadingButton = true);
                  try {
                    final userPostsCreateData = createUserPostsRecordData(
                      postPhoto: uploadedFileUrl,
                      postDescription: textController.text,
                      postUser: currentUserReference,
                      postTitle: '',
                      timePosted: getCurrentTimestamp,
                      postOwner: true,
                    );
                    await UserPostsRecord.collection
                        .doc()
                        .set(userPostsCreateData);
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 250),
                        reverseDuration: Duration(milliseconds: 250),
                        child: NavBarPage(initialPage: 'homePage'),
                      ),
                    );
                  } finally {
                    setState(() => _loadingButton = false);
                  }
                },
                text: 'Create Post',
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 8,
                ),
                loading: _loadingButton,
              ),
            ),
          )
        ],
      ),
    );
  }
}
