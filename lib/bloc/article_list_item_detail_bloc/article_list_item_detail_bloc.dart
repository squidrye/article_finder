import 'dart:async';

import 'package:article_finder/bloc/bloc.dart';
import 'package:article_finder/data/article.dart';
import 'package:article_finder/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';

class ArticleListItemDetailBloc implements Bloc{
  final client = RWClient();
  final String id;

  final _refreshController = StreamController<void>();
  late Stream<Article?> articleStream;

  ArticleListItemDetailBloc({
    required this.id,
}){
    articleStream = _refreshController.stream.startWith({}).mapTo(id).switchMap((id){
      return client.getDetailArticle(id).asStream();
    }).asBroadcastStream();

    print(articleStream);
  }

  Future refresh(){
    final future = articleStream.first;
    _refreshController.sink.add({});
    return future;
  }
  @override
  void dispose(){
    print("disposing article");
    _refreshController.close();
  }
}