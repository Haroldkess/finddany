import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class ModalClass {
  static void CategoryChange(BuildContext cont) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: cont,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ))
                ],
              ),
              Expanded(

                  // height: context.watch<SizeProvider>().screenHeight /  2.5,
                  child: context.watch<UiProvider>().shopYouCategory.isNotEmpty
                      ? ListView.builder(
                          itemCount: context
                              .watch<UiProvider>()
                              .shopYouCategory
                              .length,
                          itemBuilder: (BuildContext context, index) {
                            return selectState(
                                context
                                    .watch<UiProvider>()
                                    .shopYouCategory[index],
                                context,
                                cont);
                          })
                      : const Center(
                          child: CupertinoActivityIndicator(
                            color: Color(0xff5956E9),
                            radius: 20,
                          ),
                        )),
            ],
          ),
        );
      },
    );
  }
}

Widget selectState(String cat, BuildContext context, cont) {
  return GestureDetector(
    onTap: () async {
      Provider.of<UiProvider>(context, listen: false).changeCategory(cat);
      Navigator.pop(context);
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: onlyAllPadding),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: onlyAllPadding),
            child: Center(
              child: Text(
                cat,
                textScaleFactor: 1.2,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: context.watch<UiProvider>().selectedCategory == cat
                        ? Colors.red
                        : kPrimaryColor),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 1,
            color: Colors.grey.shade400,
          )
        ],
      ),
    ),
  );
}
