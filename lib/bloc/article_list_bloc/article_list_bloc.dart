import 'dart:async';

import 'package:article_finder/data/article.dart';
import 'package:article_finder/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class ArticleListBloc implements Bloc{
  final _client = RWClient();

  final _stringQueryController = StreamController<String?>();

  late Stream<List<Article>?> articleStream;
  ArticleListBloc(){
    print("NEW INSTANCE IS CREATED");
      articleStream = _stringQueryController.stream.startWith(null).debounceTime(const Duration(milliseconds:100)).switchMap((queryString){
        var output =  _client.fetchArticles(queryString).asStream().startWith(null);
        return output;
      });
  }
  @override
  void dispose(){
    print("Dispose main bloc");
    _stringQueryController.close();
  }

  //Now we need to interact to this bloc using ui so we'll create a sink as an entry point
  Sink<String?> get searchBlocSink => _stringQueryController.sink;
}