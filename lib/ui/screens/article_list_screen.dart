import 'package:article_finder/bloc/article_list_bloc/article_list_bloc.dart';
import 'package:article_finder/bloc/article_list_item_detail_bloc/article_list_item_detail_bloc.dart';
import 'package:article_finder/bloc/bloc_provider.dart';
import 'package:article_finder/data/article.dart';
import 'package:article_finder/ui/article_list_item.dart';
import 'package:flutter/material.dart';

import 'article_detail_screen.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArticleListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
      ),
      body: Column(
        children:[
          Padding(
            padding:EdgeInsets.all(8),
            child: TextField(
              onChanged: (String query){
                print(query);
                bloc.searchBlocSink.add(query);
              },
              decoration: const InputDecoration(
                hintText: "Search..",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _buildResults(bloc),
          ),
        ]
      ),
    );
  }

  Widget _buildResults(ArticleListBloc bloc){
    return StreamBuilder<List<Article>?>(
      stream: bloc.articleStream,
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return const Center(
            child: CircularProgressIndicator()
          );
        }else if(snapshot.data!.isEmpty){
          return const Center(
            child:Text("Empty feed"),
          );
        }
        return _buildSearchResults(snapshot.data!);
      }
    );
  }

  Widget _buildSearchResults(List<Article> results){
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index];
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // 1
            child: ArticleListItem(article: article),
          ),
          // 2
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return BlocProvider<ArticleListItemDetailBloc>(
                    bloc: ArticleListItemDetailBloc(id: article.id),
                    child: ArticleDetailScreen(
                    ),
                  );
                }
              ),
            );
          },
        );
      },
    );
  }
}
