import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/layout/cubit/cubit/cubit.dart';
import 'package:news_app_am/layout/cubit/states/states.dart';
import 'package:news_app_am/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit, NewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list= NewCubit.get(context).business;
       return articleBuilder(list,context);
    });
  }
}
