import 'package:csn_tv_display/models/ticket_model.dart';
import 'package:csn_tv_display/service/app_repository_Imp.dart';
import 'package:csn_tv_display/service/socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'serving_ticket_controller.g.dart';

@riverpod
class ServingTicket extends _$ServingTicket {
  @override
  AsyncValue<List<TicketModel>> build() {
    SocketService().tickerModeStream.listen((event) {
      if (event.type == "add_in_serving") {
        addData(event);
      }
      if (event.type == "remove_in_serving") {
        removeData(event);
      }
    });
    return const AsyncData([]);
  }

  Future<List<TicketModel>> servingTicket() async {
    state = const AsyncLoading();
    try {
      final res = await ref.read(appRepositoryImpProvider).servingTicket();
      if (res.statusCode == 200) {
        final List<dynamic> ticketList = res.data['data']['tickets'];
        final List<TicketModel> tickets =
            ticketList.map((e) => TicketModel.fromMap(e)).toList();
        state = AsyncData(tickets);
        return tickets;
      }
      state = AsyncError('Failed to fetch tickets', StackTrace.current);
      return [];
    } catch (e, st) {
      state = AsyncError(e, st);
      return [];
    }
  }

  void removeData(TicketModel ticket) {
    final currentList = state.asData?.value;
    if (currentList == null || currentList.isEmpty) {
      return;
    }
    final updatedList = currentList.where((t) => t.id != ticket.id).toList();
    state = AsyncData(updatedList);
  }

  void addData(TicketModel ticket) {
    state = AsyncData([...state.value ?? [], ticket]);
  }
}
