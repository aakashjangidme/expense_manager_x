import 'package:expense_manager_x/app/features/home/domain/providers/txn_repository_provider.dart';
import 'package:expense_manager_x/app/features/home/presentation/providers/sms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onLeadingTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu), // You can use a custom icon here
          onPressed: onLeadingTap,
        ),
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .read(transactionRepositoryProvider)
                  .deleteAllTransactions();
              // await transactionRepository.deleteAllTransactions();
              return await ref.refresh(transactionListFromSMSIsolateProvider);
            },
            icon: const Icon(Icons.refresh, fill: 1.0),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            minRadius: 16,
            maxRadius: 16,
            // You can set the image for the avatar here
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
