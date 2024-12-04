import 'package:graphql_flutter/graphql_flutter.dart';

class Queries {
  static final getAllFilms = gql(r'''
   query Query {
  allFilms {
    films {
      title
      director
      releaseDate
      speciesConnection {
        species {
          name
          classification
          homeworld {
            name
          }
        }
      }
    }
  }
}
  ''');

  static final getTitles = gql(r'''
query Query {
  allFilms {
    films {
      title
    }
  }
}
''');

  static final getDirectors = gql(r'''
query Query {
  allFilms {
    films {
      director
    }
  }
}
''');
}
