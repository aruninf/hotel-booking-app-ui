import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/connect_request/presentation/screens/request_detail_screen.dart';
import 'package:nudge/features/connect_request/presentation/screens/widgets/request_button.dart';

class ConnectionRequest {
  final String name;
  final String avatarUrl;
  final bool isLiveAtSameEvent;
  final bool isConnectionRequest;
  final String timestamp;

  ConnectionRequest({
    required this.name,
    required this.avatarUrl,
    this.isLiveAtSameEvent = false,
    this.isConnectionRequest = true,
    this.timestamp = 'Just now',
  });
}

class ConnectRequestScreen extends StatelessWidget {
  const ConnectRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the connect requests
    final List<ConnectionRequest> requests = [
      ConnectionRequest(
        name: 'David Silbia',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        isConnectionRequest: true,
      ),
      ConnectionRequest(
        name: 'Speed Connections',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        isConnectionRequest: false,
        timestamp: '10 mins',
      ),
      ConnectionRequest(
        name: 'David Silbia',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        isConnectionRequest: true,
      ),
      ConnectionRequest(
        name: 'Speed Connections',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
        isConnectionRequest: false,
        timestamp: '10 mins',
      ),
      ConnectionRequest(
        name: 'David Silbia',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        isConnectionRequest: true,
      ),
      ConnectionRequest(
        name: 'Speed Connections',
        avatarUrl: 'https://i.pravatar.cc/150?img=6',
        isConnectionRequest: false,
        timestamp: '10 mins',
      ),
      ConnectionRequest(
        name: 'Speed Connections',
        avatarUrl: 'https://i.pravatar.cc/150?img=7',
        isConnectionRequest: false,
        timestamp: '10 mins',
      ),
      ConnectionRequest(
        name: 'David Silbia',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        isConnectionRequest: true,
      ),
    ];
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          title: 'Notifications',
          onTap: () => Navigator.pop(context),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Get.to(RequestDetailScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Connect Requests',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Approve or deny your requests',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppColors.foundation500,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(color: AppColors.transparent),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(request.avatarUrl),
                              radius: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: request.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          request.isConnectionRequest
                                              ? ' wants to connect with you.'
                                              : ' starting now. Check In!',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 27.0),
                              child: Text(
                                request.timestamp,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        request.isConnectionRequest
                            ? RequestButton()
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
