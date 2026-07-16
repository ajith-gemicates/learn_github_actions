import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'firebase_home_page_state.dart';

class FirebaseHomePageCubit extends Cubit<FirebaseHomePageState> {
  FirebaseHomePageCubit() : super(FirebaseHomePageInitial());
}
