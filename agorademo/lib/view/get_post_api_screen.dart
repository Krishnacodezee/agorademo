import 'package:flutter/material.dart';
import 'package:untitled/api/get_post_api.dart';
import 'package:untitled/apiProvider/get_post_api_provider.dart';
import 'package:untitled/modal/get_post_api_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class GetPostApiDataScreen extends StatefulWidget {
  const GetPostApiDataScreen({Key? key}) : super(key: key);

  @override
  State<GetPostApiDataScreen> createState() => _GetPostApiDataScreenState();
}

class _GetPostApiDataScreenState extends State<GetPostApiDataScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Future<List<GetPostApiData>>? futureGetPostApiData;

  bool loading = true;
  @override
  void initState() {
    super.initState();

    getData();

    // debugPrint('movieTitle: ');
    // print('movieTitle: ');
    // log("----log--log--${response?.statusCode} ");
    // stdout.writeln("This log is using stdout");
    // stderr.writeln("This log is using stderr");
  }

  List<GetPostApiData> getApiData = [];

  getData() async {
    getApiData = await getApiController(context);
    loading = false;
    setState(() {});

    final getApiModal =
        Provider.of<GetPostApiDataProvider>(context, listen: false);
    getApiModal.getApiData(context);
    print(getApiModal);
  }

  List<GetPostApiData> getValueVar = [];
  Future<List<GetPostApiData>> getValue() async {
    getValueVar = await getApiController(context);
    return getValueVar;
  }

  @override
  Widget build(BuildContext context) {
    final getApiModal = Provider.of<GetPostApiDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Country Screen',
          textAlign: TextAlign.center,
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              //todo: post api data to api
              controller: idController,
              decoration: const InputDecoration(hintText: 'Enter Id'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter Name'),
            ),
            ElevatedButton(
              //todo: send data back to previous screen
              onPressed: () {
                String data = getApiData[0].name.toString();
                Navigator.pop(context, data);
                setState(() {});
              },
              child: const Text('send Data back to screen2'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  futureGetPostApiData = postApiController(
                      context,
                      int.parse(idController.text),
                      nameController.text,
                      'acount.123@gmail.com',
                      'female',
                      'inactive');
                });
              },
              child: const Text('Create Data'),
            ),
            // FutureBuilder(
            //   // todo: api data with future  builder
            //   future: getValue(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: Text('Please wait its loading...'));
            //     } else {
            //       if (snapshot.hasError)
            //         return Center(child: Text('Error: ${snapshot.error}'));
            //       else {
            //         GetPostApiData newData = snapshot.data[0];
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text('${newData.id}'),
            //             Text('${newData.name}'),
            //             Text('${newData.status}'),
            //             Text('${newData.id}'),
            //           ],
            //         );
            //       } // snapshot.data  :- get your object which is pass from your downloadData() function
            //     }
            //   },
            // ),
            //todo : fetch data with
            getApiModal.loading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: getApiModal.getPostApiData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Id : ' +
                                        getApiModal.getPostApiData[index].id
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.teal),
                                  ),
                                  // Text(
                                  //   getApiModal.getPostApiData[index].name
                                  //       .toString(),
                                  //   textAlign: TextAlign.center,
                                  //   style: const TextStyle(
                                  //       fontSize: 24, color: Colors.orangeAccent),
                                  // ),
                                  // Text(
                                  //   getApiModal.getPostApiData[index].gender
                                  //       .toString(),
                                  //   textAlign: TextAlign.center,
                                  //   style: const TextStyle(
                                  //       fontSize: 24, color: Colors.orangeAccent),
                                  // ),
                                  // Text(
                                  //   getApiModal.getPostApiData[index].status
                                  //       .toString(),
                                  //   textAlign: TextAlign.center,
                                  //   style: const TextStyle(
                                  //       fontSize: 24, color: Colors.orangeAccent),
                                  // ),
                                  const Divider(color: Colors.teal)
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
            Text('----------------------------'),

            //
            //todo: list of api data using provider data loading and displaying
            //
            loading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: getApiData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Id : ' + getApiData[index].id.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.teal),
                                  ),
                                  Text(
                                    getApiData[index].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.orangeAccent),
                                  ),
                                  Text(
                                    getApiData[index].gender.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.orangeAccent),
                                  ),
                                  Text(
                                    getApiData[index].status.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.orangeAccent),
                                  ),
                                  const Divider(color: Colors.teal)
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
