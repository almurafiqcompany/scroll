import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return
      PDFViewerScaffold(
          appBar:AppBar(
            centerTitle: true,
            title: Text('text_document'.tr),
            actions: [
              // StreamBuilder<String>(
              //     stream: Stream.fromFuture(getIsLogIn()),
              //     builder: (context, snapshotToken) {
              //       print(snapshotToken.hasData);
              //       if (snapshotToken.hasData) {
              //         return GestureDetector(
              //           onTap: () {
              //             print('not');
              //             Get.to(NotificationScreen());
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 8),
              //             child: const Icon(
              //               Icons.notifications,
              //               size: 30,
              //             ),
              //           ),
              //         );
              //       } else {
              //         return GestureDetector(
              //           onTap: () async {
              //             await showModalBottomSheet<void>(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return ShowCheckLoginDialog();
              //               },
              //             );
              //           },
              //           child: const Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 8),
              //             child: Icon(
              //               Icons.notifications,
              //               size: 30,
              //             ),
              //           ),
              //         );
              //       }
              //     }),
            ],
            elevation: 0,
            flexibleSpace: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF03317C),
                          Color(0xFF05B3D6),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 6,
                  color: Colors.lime,
                ),
              ],
            ),
          ),
        path: widget.path);
    //   Scaffold(
    //   appBar:AppBar(
    //     centerTitle: true,
    //     title: Text('text_document'.tr),
    //     actions: [
    //       // StreamBuilder<String>(
    //       //     stream: Stream.fromFuture(getIsLogIn()),
    //       //     builder: (context, snapshotToken) {
    //       //       print(snapshotToken.hasData);
    //       //       if (snapshotToken.hasData) {
    //       //         return GestureDetector(
    //       //           onTap: () {
    //       //             print('not');
    //       //             Get.to(NotificationScreen());
    //       //           },
    //       //           child: Padding(
    //       //             padding: const EdgeInsets.symmetric(horizontal: 8),
    //       //             child: const Icon(
    //       //               Icons.notifications,
    //       //               size: 30,
    //       //             ),
    //       //           ),
    //       //         );
    //       //       } else {
    //       //         return GestureDetector(
    //       //           onTap: () async {
    //       //             await showModalBottomSheet<void>(
    //       //               context: context,
    //       //               builder: (BuildContext context) {
    //       //                 return ShowCheckLoginDialog();
    //       //               },
    //       //             );
    //       //           },
    //       //           child: const Padding(
    //       //             padding: EdgeInsets.symmetric(horizontal: 8),
    //       //             child: Icon(
    //       //               Icons.notifications,
    //       //               size: 30,
    //       //             ),
    //       //           ),
    //       //         );
    //       //       }
    //       //     }),
    //     ],
    //     elevation: 0,
    //     flexibleSpace: Column(
    //       children: <Widget>[
    //         Flexible(
    //           child: Container(
    //             decoration: const BoxDecoration(
    //               gradient: LinearGradient(
    //                 colors: <Color>[
    //                   Color(0xFF03317C),
    //                   Color(0xFF05B3D6),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           width: double.maxFinite,
    //           height: 6,
    //           color: Colors.lime,
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: Stack(
    //     children: <Widget>[
    //       PDFView(
    //         filePath: widget.path,
    //         autoSpacing: true,
    //         enableSwipe: true,
    //         pageSnap: true,
    //         swipeHorizontal: true,
    //         nightMode: false,
    //
    //         onError: (e) {
    //           print(e);
    //         },
    //         onRender: (_pages) {
    //           setState(() {
    //             _totalPages = _pages;
    //             pdfReady = true;
    //           });
    //         },
    //         onViewCreated: (PDFViewController vc) {
    //           _pdfViewController = vc;
    //         },
    //         onPageChanged: (int page, int total) {
    //           setState(() {});
    //         },
    //         onPageError: (page, e) {},
    //       ),
    //       !pdfReady
    //           ? Center(
    //         child: CircularProgressIndicator(),
    //       )
    //           : Offstage()
    //     ],
    //   ),
    //   floatingActionButton: Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: <Widget>[
    //       if (_currentPage > 0) Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 5),
    //         child: FloatingActionButton.extended(
    //           backgroundColor: Colors.red,
    //           label: Text('text_go'.tr +'${_currentPage - 1}'),
    //           onPressed: () {
    //             _currentPage -= 1;
    //             _pdfViewController.setPage(_currentPage);
    //           },
    //         ),
    //       ) else Offstage(),
    //       if (_currentPage+1 < _totalPages) Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 5),
    //         child: FloatingActionButton.extended(
    //           backgroundColor: Colors.green,
    //           label: Text('text_go'.tr+' ${_currentPage + 1}'),
    //           onPressed: () {
    //             _currentPage += 1;
    //             _pdfViewController.setPage(_currentPage);
    //           },
    //         ),
    //       ) else Offstage(),
    //     ],
    //   ),
    // );
  }
}