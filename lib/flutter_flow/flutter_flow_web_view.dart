import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class FlutterFlowWebView extends StatefulWidget {
  const FlutterFlowWebView({
    @required this.url,
    this.width,
    this.height,
    this.bypass = false,
    this.horizontalScroll = false,
    this.verticalScroll = false,
    Key key,
  }) : super(key: key);

  final bool bypass;
  final bool horizontalScroll;
  final bool verticalScroll;
  final double height;
  final double width;
  final String url;

  @override
  _FlutterFlowWebViewState createState() => _FlutterFlowWebViewState();
}

class _FlutterFlowWebViewState extends State<FlutterFlowWebView> {
  @override
  Widget build(BuildContext context) => WebViewX(
        key: webviewKey,
        width: widget.width,
        height: widget.height,
        ignoreAllGestures: false,
        initialContent: widget.url,
        initialMediaPlaybackPolicy:
            AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        initialSourceType:
            widget.bypass ? SourceType.URL_BYPASS : SourceType.URL,
        javascriptMode: JavascriptMode.unrestricted,
        webSpecificParams: const WebSpecificParams(
          webAllowFullscreenContent: true,
        ),
        mobileSpecificParams: MobileSpecificParams(
          debuggingEnabled: false,
          gestureNavigationEnabled: true,
          mobileGestureRecognizers: {
            if (widget.verticalScroll)
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
              ),
            if (widget.horizontalScroll)
              Factory<HorizontalDragGestureRecognizer>(
                () => HorizontalDragGestureRecognizer(),
              ),
          },
          navigationDelegate: (_) => NavigationDecision.navigate,
        ),
      );

  Key get webviewKey => Key(
        [
          widget.url,
          widget.width,
          widget.height,
          widget.bypass,
          widget.horizontalScroll,
          widget.verticalScroll,
        ].map((s) => s?.toString() ?? '').join(),
      );
}
