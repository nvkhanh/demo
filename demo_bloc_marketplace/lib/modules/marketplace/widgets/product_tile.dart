import 'package:demo_bloc_marketplace/extensions/num_extension.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {
  ProductTile(
      {Key? key,
      required this.name,
      required this.price,
      this.imgUrl,
      this.imgHeight,
      this.onItemClicked})
      : super(key: key);

  final String? imgUrl;
  final String name;
  final double price;
  final double? imgHeight;
  Function? onItemClicked;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onItemClicked?.call(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.imgUrl ?? "",
              height: widget.imgHeight ?? 100,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(widget.price.convertToCurrency()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
