import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import 'NhiemVuController.dart';
import 'NhiemVuDetailsScreen.dart';

class NhiemVuScreen extends StatefulWidget {
  const NhiemVuScreen({Key? key}) : super(key: key);
  static const routeName = '/mission';

  @override
  State<NhiemVuScreen> createState() => _NhiemVuScreenState();
}

class _NhiemVuScreenState extends State<NhiemVuScreen> {
  late Future<void> _fetchNhiemVus;

  @override
  void initState() {
    super.initState();
    // _fetchNhiemVus = context.read<NhiemVuControler>().fetchNhiemVu();
    _fetchNhiemVus = context.read<NhiemVuControler>().fetchNhiemVuFinish();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    // FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your missions'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchNhiemVus,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)..pushNamed(MissionAddScreen.routeName);
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.add),
              ),
              body: Consumer<NhiemVuControler>(
                  builder: (context, nhiemVuControler, child) {
                return Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: nhiemVuControler.NhiemVuCount,
                        itemBuilder: (ctx, i) {
                          return (i < nhiemVuControler.nhiemVuIncompleteCount)
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          (i == 0)
                                              ? const Text(
                                                  'Chưa hoàn thành',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                )
                                              : (const SizedBox()),
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: (IsDeadline(
                                                        nhiemVuControler
                                                            .nhiemVuIncomplete[
                                                                i]
                                                            .finishDate,
                                                        nhiemVuControler
                                                            .nhiemVuIncomplete[
                                                                i]
                                                            .finishTime) <
                                                    0)
                                                ? const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 255, 0, 0),
                                                        Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ],
                                                    ),
                                                  )
                                                : const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 0, 255, 0),
                                                        Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ],
                                                    ),
                                                  ),
                                            child: ListTile(
                                                title: (IsDeadline(
                                                            nhiemVuControler
                                                                .nhiemVuIncomplete[
                                                                    i]
                                                                .finishDate,
                                                            nhiemVuControler
                                                                .nhiemVuIncomplete[
                                                                    i]
                                                                .finishTime) >
                                                        0)
                                                    ? Text(
                                                        nhiemVuControler
                                                            .nhiemVuIncomplete[
                                                                i]
                                                            .title,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    : Text(
                                                        '${nhiemVuControler.nhiemVuIncomplete[i].title} (Đã quá hạn)',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                subtitle: Text(
                                                  '${nhiemVuControler.nhiemVuIncomplete[i].startDate} ${nhiemVuControler.nhiemVuIncomplete[i].startTime} - ${nhiemVuControler.nhiemVuIncomplete[i].finishDate} ${nhiemVuControler.nhiemVuIncomplete[i].finishTime}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                onTap: () => {
                                                      Navigator.of(context)
                                                        ..pushNamed(
                                                            MissionDetailsScreen
                                                                .routeName,
                                                            arguments:
                                                                nhiemVuControler
                                                                    .nhiemVuIncomplete[i]),
                                                    }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          (i ==
                                                  nhiemVuControler
                                                      .nhiemVuIncompleteCount)
                                              ? const Text(
                                                  'Đã hoàn thành',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                )
                                              : (const SizedBox()),
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Colors.yellow,
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ],
                                                )),
                                            child: ListTile(
                                                title: Text(
                                                  nhiemVuControler
                                                      .nhiemVuCompleted[i -
                                                          nhiemVuControler
                                                              .nhiemVuIncompleteCount]
                                                      .title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                subtitle: Text(
                                                  '${nhiemVuControler.nhiemVuCompleted[i - nhiemVuControler.nhiemVuIncompleteCount].startDate} ${nhiemVuControler.nhiemVuCompleted[i - nhiemVuControler.nhiemVuIncompleteCount].startTime} - ${nhiemVuControler.nhiemVuCompleted[i - nhiemVuControler.nhiemVuIncompleteCount].finishDate} ${nhiemVuControler.nhiemVuCompleted[i - nhiemVuControler.nhiemVuIncompleteCount].finishTime}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                onTap: () => {
                                                      Navigator.of(context)
                                                        ..pushNamed(
                                                            MissionDetailsScreen
                                                                .routeName,
                                                            arguments: nhiemVuControler
                                                                    .nhiemVuCompleted[
                                                                i -
                                                                    nhiemVuControler
                                                                        .nhiemVuIncompleteCount]),
                                                    }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ],
                );
              }),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
  // else {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: const <Widget>[
  //       Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //     ],
  //   );
  // }
//         },
//       ),
//     );
//   }

  int IsDeadline(String date, String time) {
    return DateFormat('dd/MM/yyyy HH:mm')
        .parse('${date} ${time}')
        .compareTo(DateTime.now());
  }
}
