import 'dart:math';

import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:YouOweMe/resources/extensions.dart';

class IOwePageElement extends StatelessWidget {
  final Seva$Query$User$Owe owe;
  IOwePageElement({@required this.owe});

  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    void showOweDetails() {
      Widget builder(BuildContext context, ScrollController scrollController) =>
          IOwePageBottomSheet(
            scrollController: scrollController,
            owe: owe,
          );
      if (platform == TargetPlatform.iOS) {
        showCupertinoModalBottomSheet(context: context, builder: builder);
      } else {
        showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: builder);
      }
    }

    return GestureDetector(
      onTap: showOweDetails,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints(minHeight: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            YomAvatar(
              text: owe.issuedBy.shortName,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                owe.title,
                style: Theme.of(context).textTheme.headline3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              constraints: BoxConstraints(minWidth: 65),
              child: CupertinoButton(
                  color: Theme.of(context).accentColor,
                  minSize: 20,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    owe.amount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
