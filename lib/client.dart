import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Client {
  final GraphQLClient client = GraphQLClient(
    link:
        HttpLink('https://swapi-graphql.netlify.app/.netlify/functions/index'),
    cache: GraphQLCache(),
  );

  late final ValueNotifier<GraphQLClient> clientNotifier =
      ValueNotifier<GraphQLClient>(client);
}
