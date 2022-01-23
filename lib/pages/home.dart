import 'package:flutter/material.dart';
import 'package:starwars/components/appbar_main.dart';
import 'package:starwars/components/list_divider.dart';
import 'package:starwars/components/loading_error.dart';
import 'package:starwars/components/loading_more.dart';
import 'package:starwars/components/person_list_tile.dart';
import 'package:starwars/models/payload_people.dart';
import 'package:starwars/pages/person_detail.dart';
import 'package:starwars/services/sw_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;
  late Future<dynamic> _future;
  final List<Person> _people = [];
  late Payload _payload;
  final ScrollController _controller = ScrollController();

  Future<dynamic> _getPeople(int page) async {
    var data = await SwApi().getData('people', page);
    _payload = payloadFromJson(data);
    _people.addAll(_payload.results);
    if (_payload.next != null) _page++;
    return _payload;
  }

  Future<void> _refreshPeople() async {
    setState(() {
      _future = _getPeople(1);
    });
  }

  @override
  void initState() {
    _future = _getPeople(_page);
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          if (_payload.next != null) _future = _getPeople(_page);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(title: 'People of Star Wars'),
      body: FutureBuilder<dynamic>(
        future: _future,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              controller: _controller,
              itemCount:
                  _payload.next != null ? _people.length + 1 : _people.length,
              itemBuilder: (_, index) {
                if (index == _people.length && _payload.next != null) {
                  return const LoadingMore();
                }
                return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          PersonDetailScreen.routeName,
                          arguments: _people[index].url);
                    },
                    child: PersonListTile(person: _people[index]));
              },
              separatorBuilder: (_, int index) => const ListDivider(),
            );
          } else if (snapshot.hasError) {
            return RefreshIndicator(
                child: const LoadingError(), onRefresh: () => _refreshPeople());
          } else {
            return const LoadingMore();
          }
        },
      ),
    );
  }
}
