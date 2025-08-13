import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/connect_request/presentation/screens/widgets/request_button.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  final List<Map<String, dynamic>> requests = List.generate(12, (index) {
    return {
      "name": "David Silbia",
      "image": "https://i.pravatar.cc/150?img=${index + 3}",
      "live": index % 2 == 0,
    };
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          // title: Text("Connect Requests"),
          // leading: BackButton(),
          centerTitle: false,
          onTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Connect Requests',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Approve or deny your requests',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const Divider(height: 32),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    itemCount: requests.length,
                    separatorBuilder: (_, __) => SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = requests[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        item['image'],
                                      ),
                                      radius: 24,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                if (item['live'])
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.appGreen.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "LIVE AT SAME EVENT",
                                      style: context.text.labelSmall!.copyWith(
                                        color: Color(0xFF027A48),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      // style: TextStyle(color: Colors.green, fontSize: 10),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: 6),
                          RequestButton(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
