import 'package:caf_flutter_ui/caf_flutter_ui.dart';
import 'package:dio/dio.dart';
import 'package:dio_cancel_token_poc/api_client.dart';
import 'package:dio_cancel_token_poc/api_service.dart';
import 'package:dio_cancel_token_poc/second_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final ApiService apiService = ApiService(
      ApiClient.instance!.getDio('https://jsonplaceholder.typicode.com/'));

  CancelToken? cancelToken;

  int? postNo;

  @override
  void initState() {
    super.initState();
    cancelToken = CancelToken();
  }

  @override
  void dispose() {
    cancelToken?.cancel();
    debugPrint('Dispose ${cancelToken?.requestOptions?.path}');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  4,
                  (index) => InkWell(
                      onTap: () {
                        setState(() {
                          postNo = index + 1;
                        });
                        onMakeNetowrkCall(index + 1);
                      },
                      child: Chip(label: Text('Item ${index + 1}')))).toList()),
          Text(responseData ?? ""),
          Text("Selected Post $postNo")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return SecondPage();
          }));
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  String? responseData;

  onMakeNetowrkCall(int postNo) {
    cancelToken?.cancel();
    cancelToken ??= CancelToken();

    apiService
        .getPost(postNo.toString(), RequestOptions(cancelToken: cancelToken!))
        .then((value) {
      setState(() {
        responseData = "${value.data['id']} -- ${value.data['title']}";
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
