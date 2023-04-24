import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';




class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: SizedBox(
          height: 50,
          child: ListView.builder(
              itemCount: context.watch<UiProvider>().shopYouCategory.length,
              padding: const EdgeInsets.only(right: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext cont, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FilterChip(
                      backgroundColor: Colors.blue.shade900,
                      elevation: 20,
                      shadowColor: kPrimaryColor.withOpacity(0.5),
                      checkmarkColor: Colors.white,
                      side: BorderSide(
                          color: context
                                      .watch<UiProvider>()
                                      .homeSelectedCategory ==
                                  context
                                      .watch<UiProvider>()
                                      .shopYouCategory[index]
                                      .toString()
                              ? Colors.blue.shade900
                              : Colors.blue.shade900,
                          width: 2.0,
                          style: BorderStyle.solid),
                      label: Text(
                        context
                            .watch<UiProvider>()
                            .shopYouCategory[index]
                            .toString(),
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700),
                      ),
                      onSelected: (val) async  {
                        Provider.of<UiProvider>(context, listen: false)
                            .addHomeSelected(
                                Provider.of<UiProvider>(context, listen: false)
                                    .shopYouCategory[index]);
                                    if (Provider.of<UiProvider>(context, listen: false)
                                    .shopYouCategory[index] == 'All Category')
                                    {await Controls.getHomeProduct(context, false );}else{await Controls.getHomeProduct(context, true );}
                      
                      },
                      selected:
                          context.watch<UiProvider>().homeSelectedCategory ==
                              context
                                  .watch<UiProvider>()
                                  .shopYouCategory[index]
                                  .toString(),
                      selectedColor: Colors.green),
                );
              })),
    );
 
  }
}