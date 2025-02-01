import 'package:flutter_bloc/flutter_bloc.dart';

part 'home__state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);


}
