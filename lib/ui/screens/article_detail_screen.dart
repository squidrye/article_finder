import 'package:article_finder/bloc/article_list_item_detail_bloc/article_list_item_detail_bloc.dart';

import 'package:article_finder/bloc/bloc_provider.dart';
import 'package:article_finder/data/article.dart';
import 'package:article_finder/ui/article_detail.dart';
import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final bloc = BlocProvider.of<ArticleListItemDetailBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Detail")
      ),
      body: RefreshIndicator(
        onRefresh: bloc.refresh,
        child: Center(
          child: _buildContent(bloc),
        ),
      ),
    );
  }

  Widget _buildContent(ArticleListItemDetailBloc bloc){
    return StreamBuilder<Article?>(
      stream: bloc.articleStream,
      builder: (context, snapshot){
        final article = snapshot.data;
        if(article == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return ArticleDetail(article);
        }
      },
    );
  }
}