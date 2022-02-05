import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Repoositories/category_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Presentation/Widgets/category_selector.dart';

class ShirtList extends StatefulWidget {
  @override
  State<ShirtList> createState() => _ShirtListState();
}

class _ShirtListState extends State<ShirtList> {
  final ShirtRepository shirtRepository = ShirtRepository();

  @override
  void initState() {
    // context.read<ShirtBloc>().add(FetchShirts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
            ),
            title: Text(
              'Altrue Tees',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
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
        body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (_) => context.read<ShirtRepository>(),
            ),
            RepositoryProvider(
                create: (_) => context.read<CategoryRepository>()),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              BlocConsumer<ShirtBloc, ShirtState>(
                  buildWhen: (p, c) => p.shirtlist != c.categoryShirtList,
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state.categoryShirtList.isNotEmpty) {
                      return buildShirtListByCateogory(state);
                    } else if (state.categoryShirtList.isEmpty &&
                        state.shirtlist.isNotEmpty) {
                      return buildShirtList(state);
                    }
                    {
                      return buildShirtList(state);
                    }
                  })
            ],
          ),
        ));
  }

  Expanded buildShirtList(ShirtState state) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: GridView.builder(
              itemCount: state.shirtlist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 27,
                  mainAxisSpacing: 13,
                  childAspectRatio: .75,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => ShirtCard(
                  shirt: state.shirtlist[index],
                  press: () => Navigator.of(context).pushNamed('/ShirtDetail',
                      arguments: state.shirtlist[index])))),
    );
  }

  Expanded buildShirtListByCateogory(ShirtState state) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: GridView.builder(
              itemCount: state.categoryShirtList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 27,
                  mainAxisSpacing: 13,
                  childAspectRatio: .75,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => ShirtCard(
                  shirt: state.categoryShirtList[index],
                  press: () => Navigator.of(context).pushNamed('/ShirtDetail',
                      arguments: state.categoryShirtList[index])))),
    );
  }
}

class ShirtCard extends StatelessWidget {
  final Shirt shirt;
  final Function press;

  ShirtCard({required this.shirt, required this.press});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(
              shirt.shirtImage!,
              scale: .7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              shirt.name!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            shirt.price.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
