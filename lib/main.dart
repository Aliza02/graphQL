import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_practice/client.dart';
import 'package:graphql_practice/queries.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final graphqlClient = Client();
  String _selectedSegment = 'All';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GraphQLProvider(
          client: graphqlClient.clientNotifier,
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Text(
                'Films',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SegmentedButton<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(
                    value: 'All',
                    label: Text('All'),
                    icon: Icon(Icons.list),
                  ),
                  ButtonSegment<String>(
                    value: 'Titles',
                    label: Text('Titles'),
                    icon: Icon(Icons.title),
                  ),
                  ButtonSegment<String>(
                    value: 'Directors',
                    label: Text('Directors'),
                    icon: Icon(Icons.person),
                  ),
                ],
                selected: <String>{_selectedSegment},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _selectedSegment = newSelection.first;
                  });
                },
              ),
              _selectedSegment == 'All'
                  ? Query(
                      key: ValueKey(_selectedSegment), // Forces a rebuild.

                      options: QueryOptions(
                        document: Queries.getAllFilms,
                        fetchPolicy: FetchPolicy.networkOnly,
                      ),
                      builder: (
                        QueryResult result, {
                        Future<QueryResult> Function(FetchMoreOptions)?
                            fetchMore,
                        Future<QueryResult?> Function()? refetch,
                      }) {
                        if (result.hasException) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "Something caused error: Try Fetching Again"),
                                ElevatedButton(
                                  onPressed: () {
                                    if (refetch != null) {
                                      refetch().then((value) {
                                        setState(
                                            () {}); // This will ensure UI updates after data is refetched.
                                      });
                                    }
                                  },
                                  child: const Text('Try Again'),
                                ),
                              ],
                            ),
                          );
                        }
                        if (result.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final films = result.data?["allFilms"] ?? [];
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: films['films'].length,
                          itemBuilder: (context, index) {
                            final film = films['films'][index];
                            return ListTile(
                              title: Text(film['title']),
                              subtitle: Text(film['director']),
                            );
                          },
                        );
                      },
                    )
                  : _selectedSegment == 'Titles'
                      ? Query(
                          key: ValueKey(_selectedSegment), // Forces a rebuild.

                          options: QueryOptions(document: Queries.getTitles),
                          builder: (
                            QueryResult result, {
                            Future<QueryResult> Function(FetchMoreOptions)?
                                fetchMore,
                            Future<QueryResult?> Function()? refetch,
                          }) {
                            if (result.hasException) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "Something caused error: Try Fetching Again"),
                                    ElevatedButton(
                                      onPressed: refetch,
                                      child: Text('Try Again'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (result.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final films = result.data?["allFilms"] ?? [];

                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: films['films'].length,
                              itemBuilder: (context, index) {
                                final film = films['films'][index];
                                return ListTile(
                                  title: Text(film['title']),
                                );
                              },
                            );
                          },
                        )
                      : Query(
                          key: ValueKey(_selectedSegment), // Forces a rebuild.

                          options: QueryOptions(document: Queries.getDirectors),
                          builder: (
                            QueryResult result, {
                            Future<QueryResult> Function(FetchMoreOptions)?
                                fetchMore,
                            Future<QueryResult?> Function()? refetch,
                          }) {
                            if (result.hasException) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "Something caused error: Try Fetching Again"),
                                    ElevatedButton(
                                      onPressed: refetch,
                                      child: const Text('Try Again'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (result.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final films = result.data?["allFilms"] ?? [];
                            // print(films);
                            // return Text('directors');
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: films['films'].length,
                              itemBuilder: (context, index) {
                                final film = films['films'][index];

                                return ListTile(
                                  title: Text(film['director']),
                                  // subtitle: Text(film['director']),
                                );
                              },
                            );
                          },
                        )
            ],
          ),
        ),
      ),
    );
  }
}
