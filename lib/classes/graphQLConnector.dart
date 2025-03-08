import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:shopping_list/classes/listItem.dart';

class GraphQLConnector{
  GraphQLClient getGraphQlClient() {
    final HttpLink link = HttpLink("http://192.168.178.65:3000/graphql");

    return GraphQLClient(
      link: link,
      cache: GraphQLCache()
    );
  }

  Future<List<ListItem>> allItems() async {
    
    GraphQLClient client = getGraphQlClient();
    
    const String query = '''
    query{
	    items{
        id,
        description,
        isChecked
      }
    }
    ''';
    
    final QueryOptions options = QueryOptions(
      document: gql(query)
    );
   
    final QueryResult result = await client.query(options);
   
    if(result.hasException){
      print("Fehler!");
      print(result.exception);
    }
    
    dynamic data = result.data?["items"];
    List<ListItem> resultList = [];
  
    for(int i = 0; i < data.length; i++){
      resultList.add(ListItem(data[i]["description"], int.parse(data[i]["id"]), data[i]["isChecked"]));
    }

    return resultList;
  }
}