import 'package:flutter/material.dart';
import 'package:hymate_tech_task/app/constants/constants.dart';
import 'package:hymate_tech_task/shared/extensions/extensions.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    required this.message,
    this.onPressed,
    this.child,
    this.height,
    super.key,
  });

  final String message;
  final VoidCallback? onPressed;
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    final screenAreaHeight = deviceHeight - padding.top - kToolbarHeight;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: height ?? screenAreaHeight - (deviceHeight / 4),
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              verticalMargin12,
              if (child == null)
                SizedBox(
                  height: screenAreaHeight * 0.2,
                  child: Image.asset(
                    AppAssets.error404,
                    fit: BoxFit.cover,
                  ),
                )
              else
                child!,
              verticalMargin12,
              Visibility( // TODO(Joshua): Update this to maybe give pages the option to send in the widget to be used alongside the onPressed method
                visible: onPressed != null,
                child: IconButton(
                  color: context.theme.colorScheme.error,
                  icon: const Icon(Icons.refresh, size: 30),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
