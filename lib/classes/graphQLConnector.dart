import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:shopping_list/classes/listItem.dart';

class GraphQLConnector{
  GraphQLClient getGraphQlClient() {
    
    final HttpLink httpLink = HttpLink("http://192.168.178.65:3000/graphql");

    final WebSocketLink wsLink = WebSocketLink(
      "ws://192.168.178.65:3000/graphql",
      config: const SocketClientConfig(autoReconnect: true)
      );

    final Link link = Link.split((request) => request.isSubscription, wsLink, httpLink);

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

  Future<bool> addItem(ListItem item) async {
    
    GraphQLClient client = getGraphQlClient();

    String mutation = r'''
      mutation($name: String!){
        addItem(description: $name){
          description
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'name': item.name
      }
    );

    final result = await client.mutate(options);

    if(result.hasException){
      print("Fehler!");
      print(result.exception);
      return false;
    }
    else{
      return true;
    }
  }

  Future<void> applyNewItemSubscription(Function callback) async {

    GraphQLClient client = getGraphQlClient();

    final String subscription = '''
      subscription{
        itemAdded{
          description
        }
      }
    ''';

    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(subscription)
    );

    final Stream<QueryResult> stream = client.subscribe(options);

    stream.listen((result) {
      
      if(result.hasException){
        print("There was a Stream Error!");
        print("Exception");
      }
      else{
        callback();
      }
      
      print("New remote event!");
      print(result);
    });

  }
}