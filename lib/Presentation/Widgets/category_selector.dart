import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';

import 'package:mobile/Data_Layer/Models/category_model.dart';

class CategorySelector extends StatefulWidget {
  final List<Category> categoryList;
  final bool? isNonProfit;
  final bool? isCompany;
  final bool? isAtrocity;
  final bool? isShirt;

  const CategorySelector(
      {Key? key,
      required this.isShirt,
      required this.categoryList,
      required this.isNonProfit,
      required this.isAtrocity,
      required this.isCompany})
      : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          itemBuilder: (context, index) => buildCategory(index),
          itemCount: widget.categoryList.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => context.read<ShirtBloc>(),
        ),
        BlocProvider(
          create: (context) => context.read<NonprofitBloc>(),
        ),
        BlocProvider(create: (context) => context.read<AtrocityBlocBloc>()),
        BlocProvider(create: (context) => context.read<CompanyListBloc>())
      ],
      child: GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            if (widget.isNonProfit == true) {
              context.read<NonprofitBloc>().add(FetchNonProfitsByCategory(
                  category: widget.categoryList[index]));
            } else if (widget.isAtrocity == true) {
              context.read<AtrocityBlocBloc>().add(
                  AtrocityListFetchedByCategory(
                      category: widget.categoryList[index]));
            } else if (widget.isShirt == true) {
              context.read<ShirtBloc>().add(
                  FetchShirtByCategory(category: widget.categoryList[index]));
            } else if (widget.isCompany == true) {
              context.read<CompanyListBloc>().add(FetchCompanyListByCategory(
                  category: widget.categoryList[index]));
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.categoryList[index].name!,
                  style: TextStyle(
                      fontSize: 22,
                      color:
                          selectedIndex == index ? Colors.black : Colors.amber),
                ),
                Container(
                  height: 2,
                  width: 28,
                  color: selectedIndex == index
                      ? Colors.black
                      : Colors.transparent,
                  margin: EdgeInsets.only(top: 1.25),
                )
              ],
            ),
          )),
    );
  }
}
