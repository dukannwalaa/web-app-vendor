
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/constant/color.dart';
import 'package:vendor/utils/utility.dart';

Widget loadSvgAsset({fileName, width, height, subFolder}) {
  return SvgPicture.asset(
    getAssetFile(name: fileName, subFolder: subFolder),
    height: height ?? 20.h,
    width: width ?? 20.w,
  );
}

Widget loadPngAsset({fileName, width, height}) {
  return Image.asset(
    getAssetFile(name: fileName, type: 'png'),
    height: height ?? 20.h,
    width: width ?? 20.w,
  );
}

Widget loadSvgAssetTint({file, tintColor = MyColor.black}) {
  return SvgPicture.asset(
    file,
    colorFilter: ColorFilter.mode(tintColor, BlendMode.srcIn),
  );
}

Widget loadNetworkImage({required String url, BoxFit? boxFit, width, height}) {
  return Image.network(
    url,
    height: height,
    width: width,
    fit: boxFit,
    frameBuilder: (BuildContext context, Widget child, int? frame,
        bool wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded) {
        return child; // Image loaded synchronously, return it directly
      } else {
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1, // Fade in as frames become available
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      }
    },
    errorBuilder: (context, error, stackTrace) => Center(
      child: SizedBox(
          height: height, width: width, child: const Icon(Icons.error)),
    ),
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child; // Loading complete, return the image
      } else {
        return SizedBox(
          height: height,
          width: width,
          child: Center(
            // Display a loading indicator while loading
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      }
    },
  );
}

Widget loadLottieAsset(fileName, {width, height}) {
  return SizedBox(
      width: width,
      height: height,
      child: Lottie.asset(getAssetFile(name: fileName, type: 'json')));
}
