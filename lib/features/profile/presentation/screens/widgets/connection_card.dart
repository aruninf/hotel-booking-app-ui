import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';

enum ConnectionType { connect, requestSent, remove }

class ConnectionCard extends StatefulWidget {
  final Connection connection;
  final ConnectionType? connectionType;
  final ValueChanged<ConnectionType>? onConnectionTypeChanged;

  final Widget? trailing; // Optional trailing widget (button/icon/etc.)

  const ConnectionCard({
    super.key,
    required this.connection,
    this.connectionType,
    this.onConnectionTypeChanged,
    this.trailing,
  });

  @override
  State<ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  late ConnectionType _currentType;

  @override
  void initState() {
    super.initState();
    _currentType = widget.connectionType ?? ConnectionType.remove;
  }

  // void _toggleConnection() {
  //   setState(() {
  //     _currentType = _currentType == ConnectionType.connect
  //         ? ConnectionType.requestSent
  //         : ConnectionType.connect;
  //   });
  //   widget.onConnectionTypeChanged?.call(_currentType);
  // }

  String getButtonLabel() {
    switch (_currentType) {
      case ConnectionType.connect:
        return 'Connect';
      case ConnectionType.requestSent:
        return 'Request Sent';
      case ConnectionType.remove:
        return 'Remove';
      // default:
      //   return 'Removed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppCachedImage(
                imgUrl:
                    widget.connection.imagePath.isEmpty
                        ? ''
                        : widget.connection.imagePath,
                height: 45,
                width: 45,
                errorWid: Image.asset(
                  widget.connection.imagePath,
                  height: 45,
                  width: 45,
                ),
              ),
              HorizontalSpacing(11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.connection.name,
                    style: context.text.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.neutral900,
                    ),
                  ),
                  VerticalSpacing(4),
                  Text(
                    widget.connection.location,
                    style: context.text.titleMedium!.copyWith(
                      fontSize: 13,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // GestureDetector(
          //   onTap: _currentType == ConnectionType.connect
          //       ? _toggleConnection
          //       : null,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          //     decoration: BoxDecoration(
          //       color: _currentType == ConnectionType.requestSent
          //           ? AppColors.foundationPrimary500
          //           : AppColors.foundationPrimary50,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Text(
          //       getButtonLabel(),
          //       style: context.text.titleSmall!.copyWith(
          //         color: _currentType == ConnectionType.requestSent
          //             ? AppColors.white
          //             : AppColors.foundationPrimary500,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),

          /// If trailing widget is provided, show it
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}
