import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../widgets/carditem.dart';
import '../../widgets/searchitem.dart';

class GlobalData {
  static String datosusuario = '';
}

var busquedaquery = ValueNotifier<String>('');

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 20),
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);

                    //Navigator.popAndPushNamed(context, '/busqueda');
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 20,
              ),
              const Busqueda()
            ],
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: TextResult(),
            )),
        const SearchResult()
      ],
    ));
  }
}

class TextResult extends StatefulWidget {
  const TextResult({Key? key}) : super(key: key);

  @override
  _TextResultState createState() => _TextResultState();
}

class _TextResultState extends State<TextResult> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: busquedaquery,
        builder: (context, value, widget) {
          String text = '';
          if (value != '') {
            text = 'Search result for $value';
          }

          return Text(
            text,
            style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway'),
          );
        });
  }
}

class Busqueda extends StatefulWidget {
  const Busqueda({Key? key}) : super(key: key);

  @override
  _BusquedaState createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        onSubmitted: (value) async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('search', value);
          // ignore: use_build_context_synchronously
          Controls.searchController(context);
        },
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: _searchText.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchController.clearComposing();
                  },
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
        GlobalData.datosusuario = _searchController.text;
        busquedaquery.value = _searchController.text;
      });
    });
  }
}

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: context.watch<UiProvider>().isLoading
          ? CupertinoActivityIndicator(
              radius: 30,
              color: Colors.blue.shade900,
            )
          : Expanded(
              child: context.watch<UiProvider>().searchProd.isNotEmpty
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        context.watch<UiProvider>().searchProd.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 20.0, 0.0, 20.0),
                                child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.center,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                      ).createShader(rect);
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: const Image(
                                        image: AssetImage(
                                            'assets/images/splash.png'),
                                        fit: BoxFit.contain)))
                            : const SizedBox.shrink(),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 0, right: 0, top: 20),
                            child: StaggeredGridView.count(
                              crossAxisCount:
                                  Responsive.isDesktop(context) ? 9 : 4,
                              mainAxisSpacing: 4,
                              staggeredTiles: context
                                  .watch<UiProvider>()
                                  .searchProd
                                  .map(
                                    (e) => StaggeredTile.count(
                                        Responsive.isDesktop(context) ? 3 : 2,
                                       Responsive.isMobile(context) ||
                                       Responsive.isMobileLarge(context) ? 3  : 2),
                                  )
                                  .toList(),
                              children: context
                                  .watch<UiProvider>()
                                  .searchProd
                                  .map((e) => ProductItem(
                                        product: e,
                                      ))
                                  .toList(),
                            )),
                      ],
                    )
                  : Column(children: const <Widget>[
                      Center(
                        child: Image(
                            image:
                                AssetImage('assets/images/itemnotfound.png')),
                      ),
                      Center(
                        child: Text('Item Not Found',
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway')),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                              'Try a more generic search term or try looking for alternative products.',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Raleway'),
                              textAlign: TextAlign.center),
                        ),
                      )
                    ])),
    );
  }
}
