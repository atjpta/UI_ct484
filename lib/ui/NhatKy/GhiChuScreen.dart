import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';
import 'GhiChuAddScreen.dart';

import '../shared/app_drawer.dart';
import 'GhiChuDetailsScreen.dart';

class GhiChuScreen extends StatefulWidget {
  const GhiChuScreen({Key? key}) : super(key: key);

  @override
  State<GhiChuScreen> createState() => _GhiChuScreenState();
}

class _GhiChuScreenState extends State<GhiChuScreen> {
  late Future<void> _fetchGhichus;

  @override
  void initState() {
    super.initState();
    _fetchGhichus = context.read<GhiChuControler>().fetchGhiChu();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Diary'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchGhichus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)..pushNamed(GhiChuAddScreen.routeName);
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.add),
              ),
              body: Consumer<GhiChuControler>(
                  builder: (context, nhatKyControler, child) {
                return ListView.builder(
                  itemCount: nhatKyControler.NhatKyCount,
                  itemBuilder: (ctx, i) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.blue,
                                    Color.fromARGB(255, 255, 255, 255),
                                  ],
                                )),
                            child: ListTile(
                                title: Text(
                                  nhatKyControler.nhatKys[i].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  nhatKyControler.nhatKys[i].content,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () => {
                                      Navigator.of(context)
                                        ..pushNamed(
                                            GhiChuDetailsScreen.routeName,
                                            arguments:
                                                nhatKyControler.nhatKys[i]),
                                    }),
                          ),
                        ),
                      ],
                    );
                  },
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
        },
      ),
    );
  }
}
