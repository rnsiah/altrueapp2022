import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Repoositories/category_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Presentation/Widgets/category_selector.dart';

class ShirtsList extends StatefulWidget {
  const ShirtsList({Key? key}) : super(key: key);

  @override
  _ShirtsListState createState() => _ShirtsListState();
}

class _ShirtsListState extends State<ShirtsList> {
  final ShirtRepository shirtRepository = ShirtRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => context.read<ShirtRepository>(),
        ),
        RepositoryProvider(create: (_) => context.read<CategoryRepository>()),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                ),
                title: Text(
                  'Altrue Tees',
                  style: TextStyle(fontSize: 22, color: Colors.amber),
                ),
                floating: true,
                expandedHeight: 80.0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                ]),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Global Causes',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return CategorySelector(
                    isNonProfit: false,
                    isShirt: true,
                    isAtrocity: false,
                    isCompany: false,
                    categoryList: state.categoryList,
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
