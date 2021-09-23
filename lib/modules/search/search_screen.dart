import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/layout/cubit/cubit/cubit.dart';
import 'package:news_app_am/layout/cubit/states/states.dart';
import 'package:news_app_am/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController =TextEditingController();
    return BlocConsumer<NewCubit,NewStates>(
      listener: (context,state){},
      builder: (context , state) {
        var list = NewCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
          ),
          body: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormFiled(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  onChange: (value){
                    NewCubit.get(context).getSearch(value);
                  },
                  validate: (String value){
                    if(value.isEmpty){
                      return 'Search Must Be Not Empty';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch : true,)),
            ],
          ),
        );
      }

    );
  }
}
