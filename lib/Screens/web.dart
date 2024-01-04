
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:movies/data.dart';


class Web_Page extends StatefulWidget {
  const Web_Page({Key? key}) : super(key: key);

  @override
  State<Web_Page> createState() => _Web_PageState();
}

class _Web_PageState extends State<Web_Page> {
  final GlobalKey webviewkey = GlobalKey();

  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  String url = "";
  final urlcontroller = TextEditingController();

  late final String web;

  List allbookmarks = [];

  @override
  void initState() {
    super.initState();
    web = Globals.currentweb["website"];
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        await inAppWebViewController?.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await inAppWebViewController?.goBack();
            setState(() {});
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 28,
          ),
        ),
        title: Text("${Globals.currentweb['name']}"),
        actions: [
          IconButton(
            onPressed: () async {
              await inAppWebViewController?.reload();
            },
            icon: Icon(
              Icons.refresh,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () async{
              Uri? uri = await inAppWebViewController?.getUrl();

              String url = uri.toString();
              allbookmarks.add(url);
              Globals.bookmark.add(url);
              Globals.bookmark = Globals.bookmark.toSet().toList();
            },
            icon: Icon(
              Icons.bookmark_border,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () async {
              await inAppWebViewController?.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(web),
                ),
              );
            },
            icon: Icon(
              Icons.home,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () async {
              await inAppWebViewController?.goBack();
            },
            icon: Icon(
              Icons.arrow_forward_rounded,
              size: 28,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Center(
                child: Text("BookMarks"),
              ),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: allbookmarks
                      .map((e) => GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();

                      await inAppWebViewController?.loadUrl(
                        urlRequest: URLRequest(
                          url: Uri.parse(e),
                        ),
                      );
                    },
                    child: Text(e),
                  )).toList()),
            ),
          );
        },
        child: Icon(
          Icons.bookmark,
          size: 28,
        ),
      ),
      body: Center(
        child: InAppWebView(
          key: webviewkey,
          initialUrlRequest: URLRequest(
            url: Uri.parse("${Globals.currentweb['website']}"),
          ),
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            inAppWebViewController = controller;
          },
          onLoadStop: (controller, url) {
            pullToRefreshController.endRefreshing();
            setState(
                  () {
                this.url = url.toString();
                urlcontroller.text = this.url;
              },
            );
          },
        ),
      ),
    );
  }
}