import 'dart:async';
import 'package:csn_tv_display/models/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }
  SocketService._internal();

  io.Socket? socket;

  final StreamController<TicketModel> _tickerModeStream =
      StreamController.broadcast();

  Stream<TicketModel> get tickerModeStream => _tickerModeStream.stream;

  void conntectToSocket({required String indentity}) async {
    // Disconnect any existing socket before reconnecting
    if (socket != null) {
      disConnect();
    }
    try {
      socket = io.io(
        'http://socket.csndev.com',
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({"identifier": indentity})
            .enableForceNew()
            .build(),
      );
      socket?.connect();
    } catch (e) {
      debugPrint(e.toString());
    }

    // Register socket events
    socket?.onConnect((_) {
      debugPrint('Socket connected with identifier: $indentity');
    });

    socket?.on('ticket-add', (data) {
      debugPrint('ticket event triggeredd: ${data['ticket']}');
      try {
        final ticketMap = Map<String, dynamic>.from(data['ticket']);
        final ticket = TicketModel.fromMap(ticketMap);
        _tickerModeStream.add(ticket);
      } catch (e) {
        debugPrint('error: $e');
        rethrow;
      }
    });

    socket?.on('ticket-remove', (data) {
      debugPrint('ticket event triggeredd: $data');
      try {
        final ticketMap = Map<String, dynamic>.from(data['ticket']);
        final ticket = TicketModel.fromMap(ticketMap);
        _tickerModeStream.add(ticket);
      } catch (e) {
        debugPrint('error: $e');
        rethrow;
      }
    });

    socket?.onDisconnect((data) {
      socket?.disconnect();
      debugPrint('Socket disconnected ${data.toString()}');
    });

    socket?.onError((error) {
      debugPrint('Socket error: $error');
    });
  }

  void disConnect() {
    if (socket != null) {
      debugPrint('Disconnecting socket');
      socket?.clearListeners();
      socket?.close();
      socket?.disconnect();
      socket?.dispose();
      socket = null; // Ensure the socket is cleared
    }
  }
}
