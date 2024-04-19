import "dart:async";

import "package:flutter/material.dart";
import "package:like_button/like_button.dart";
import "package:logging/logging.dart";
import "package:photos/core/configuration.dart";
import "package:photos/generated/l10n.dart";
import 'package:photos/models/file/file.dart';
import "package:photos/services/favorites_service.dart";
import "package:photos/ui/common/loading_widget.dart";
import "package:photos/utils/toast_util.dart";

class FavoriteWidget extends StatefulWidget {
  final EnteFile file;

  const FavoriteWidget(
    this.file, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  late Logger _logger;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _logger = Logger("_FavoriteWidgetState");
  }

  Future<bool> _fetchData() async {
    return FavoritesService.instance.isFavorite(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _fetchData(),
      builder: (context, snapshot) {
        final bool isLiked = snapshot.data ?? false;
        return _isLoading
            ? const EnteLoadingWidget(
                size: 12,
              ) // Add this line
            : LikeButton(
                size: 24,
                isLiked: isLiked,
                onTap: (oldValue) async {
                  if (widget.file.uploadedFileID == null ||
                      widget.file.ownerID !=
                          Configuration.instance.getUserID()!) {
                    setState(() {
                      _isLoading = true; // Add this line
                    });
                  }
                  final isLiked = !oldValue;
                  bool hasError = false;
                  if (isLiked) {
                    try {
                      await FavoritesService.instance.addToFavorites(
                        context,
                        widget.file,
                      );
                    } catch (e, s) {
                      _logger.severe(e, s);
                      hasError = true;
                      showToast(
                          context, S.of(context).sorryCouldNotAddToFavorites);
                    }
                  } else {
                    try {
                      await FavoritesService.instance
                          .removeFromFavorites(context, widget.file);
                    } catch (e, s) {
                      _logger.severe(e, s);
                      hasError = true;
                      showToast(
                        context,
                        S.of(context).sorryCouldNotRemoveFromFavorites,
                      );
                    }
                  }
                  setState(() {
                    _isLoading = false; // Add this line
                  });
                  return hasError ? oldValue : isLiked;
                },
                likeBuilder: (isLiked) {
                  debugPrint(
                      "File Upload ID ${widget.file.uploadedFileID} & collection ${widget.file.collectionID}");
                  return Icon(
                    isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isLiked
                        ? Colors.pinkAccent
                        : Colors.white, //same for both themes
                    size: 24,
                  );
                },
              );
      },
    );
  }
}
