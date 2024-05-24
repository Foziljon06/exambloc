import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class GetNews extends Equatable {
  const GetNewsEvent();
}

class GetNewsEvent extends GetNews {
  BuildContext context;


  GetNewsEvent({required this.context});

  @override
  List<Object> get props => [];
}