import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:starwars/components/appbar_main.dart';
import 'package:starwars/components/list_divider.dart';
import 'package:starwars/components/loading_error.dart';
import 'package:starwars/components/loading_more.dart';
import 'package:starwars/components/person_list_tile.dart';
import 'package:starwars/pages/person_detail.dart';
import 'package:starwars/provider/people_provider.dart'; // Import PeopleProvider

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // Access the provider and fetch initial data
    // Use addPostFrameCallback to ensure BuildContext is available and avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final peopleProvider = Provider.of<PeopleProvider>(context, listen: false);
      // Fetch only if there are no people loaded yet, to avoid refetching on hot reload or rebuilds
      if (peopleProvider.people.isEmpty) {
        peopleProvider.fetchPeople();
      }
    });

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        // Access provider and fetch more data
        Provider.of<PeopleProvider>(context, listen: false).fetchPeople();
      }
    });
  }

  @override
  void dispose() {
    // It's good practice to remove listeners, though _controller itself will be disposed.
    // _controller.removeListener(_scrollListener); // If you had a separate method
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(title: 'People of Star Wars'),
      // Use Consumer to listen to PeopleProvider changes
      body: Consumer<PeopleProvider>(
        builder: (context, peopleProvider, child) {
          if (peopleProvider.initialLoading && peopleProvider.people.isEmpty) {
            return const Center(child: CircularProgressIndicator()); // Show initial loading indicator
          } else if (peopleProvider.errorMessage != null && peopleProvider.people.isEmpty) {
            return RefreshIndicator(
              child: LoadingError(message: peopleProvider.errorMessage), // Show error if any
              onRefresh: () => peopleProvider.fetchPeople(isRefresh: true),
            );
          } else if (peopleProvider.people.isEmpty) {
            // This case might occur if fetch completes with no data and no error
            return RefreshIndicator(
              child: const Center(child: Text('No people found.')),
              onRefresh: () => peopleProvider.fetchPeople(isRefresh: true),
            );
          }

          // Main content list
          return RefreshIndicator(
            onRefresh: () => peopleProvider.fetchPeople(isRefresh: true),
            child: ListView.separated(
              controller: _controller,
              itemCount: peopleProvider.people.length + (peopleProvider.hasNextPage ? 1 : 0),
              itemBuilder: (_, index) {
                if (index == peopleProvider.people.length && peopleProvider.hasNextPage) {
                  // Show loading indicator at the end of the list if more data is being fetched
                  return peopleProvider.isLoading && !peopleProvider.initialLoading
                         ? const LoadingMore()
                         : Container(); // Or some other placeholder if not loading
                }
                if (index < peopleProvider.people.length) {
                  final person = peopleProvider.people[index];
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            PersonDetailScreen.routeName,
                            arguments: person.url);
                      },
                      child: PersonListTile(person: person));
                }
                return null; // Should not happen
              },
              separatorBuilder: (_, int index) => const ListDivider(),
            ),
          );
        },
      ),
    );
  }
}
