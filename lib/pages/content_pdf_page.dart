import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../bloc/content_bloc.dart';

class ContentPdfPage extends StatefulWidget {
  const ContentPdfPage({Key? key, required this.currentPdfPage})
      : super(key: key);
  final int currentPdfPage;

  @override
  State<ContentPdfPage> createState() => _ContentPdfPageState();
}

class _ContentPdfPageState extends State<ContentPdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContentBloc>(context).add(GetContentEvent());
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.jumpToPage(widget.currentPdfPage);
  }

  late final PdfViewerController _pdfViewerController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _pdfViewerController.pageNumber);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff0F0F29),
        appBar: AppBar(
          backgroundColor: const Color(0xff0F0F29),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pop(context, _pdfViewerController.pageNumber),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ContentBloc, ContentState>(
            builder: (context, state) {
              if (state is ContentInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ContentLoaded) {
                // print(state.contents.pdf);
                return SfPdfViewer.network(
                  onPageChanged: (details) {
                    details.newPageNumber;
                    // print(details.newPageNumber);
                    // print("page number ${_pdfViewerController.pageNumber}");
                  },
                  controller: _pdfViewerController,
                  canShowScrollHead: true,
                  canShowPaginationDialog: true,
                  state.contents.pdf,
                  key: _pdfViewerKey,
                );
              }
              if (state is ContentError) {
                return const Center(
                  child: Text('failed to fetch data'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
