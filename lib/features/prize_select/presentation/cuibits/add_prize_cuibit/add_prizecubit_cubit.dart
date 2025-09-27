import 'dart:async';
import 'dart:typed_data';

import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/repos/update_client_repo.dart';
import 'package:bingo_with_coca/core/repos/upload_image_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as img;

part 'add_prizecubit_state.dart';

class AddPrizeCubit extends Cubit<AddPrizeState> {
  UpdateClientRepo updateClientRepo;
  UploadImageRepo uploadImageRepo;
  AddPrizeCubit(this.updateClientRepo,this.uploadImageRepo) : super(AddPrizeInitial());
  static AddPrizeCubit get(context) => BlocProvider.of(context);

  PlatformFile? myImageFile;

  Position? myLocation;

  Future<Position> getLatLngOrThrow() async {
    // 1) Services enabled?
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'من فضلك قم بتشغيل خدمة الموقع';
    }

    // 2) Permission flow
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw 'من فضلك قم باعطاء اذن الوصول للموقع';
    }

    if (permission == LocationPermission.deniedForever) {
      throw kIsWeb
          ? 'Location is blocked in the browser. Allow location for this site (padlock → Site settings → Location → Allow), then reload.'
          : 'من فضلك قم باعطاء اذن الوصول للموقع';
    }

    // 3) Single fix with a hard timeout
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 12));
    } on TimeoutException {
      throw 'هناك مشكلة بالانترنت من فضلك اعد المحاولة';
    } catch (e) {
      throw 'هناك مشكلة بالانترنت من فضلك اعد المحاولة';
    }
  }
  Future<void> takeAndProcessWebImage() async {
    emit(PickImageLoading());
    final ImagePicker picker = ImagePicker();


    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo == null) {
        emit(PickImageFailure('لم يتم اختيار صورة'));

        return; // خروج من الدالة لأنها void
      }

      final Uint8List photoBytes = await photo.readAsBytes();
      PlatformFile? resultFile;

      const int maxSizeInBytes = 1000000; // 1MB
      if (photoBytes.length > maxSizeInBytes) {
        print('Image is large, compressing...');
        img.Image? originalImage = img.decodeImage(photoBytes);
        if (originalImage == null) return;

        img.Image resizedImage = img.copyResize(originalImage, width: 1024);
        final List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 75);

        resultFile = PlatformFile(
          name: '${photo.name.split('.').first}_compressed.jpg',
          size: compressedBytes.length,
          bytes: Uint8List.fromList(compressedBytes),
        );
      } else {
        resultFile = PlatformFile(
          name: photo.name,
          bytes: photoBytes,
          size: photoBytes.length,
        );
      }


      myImageFile = resultFile;
      try{
        var location=await getLatLngOrThrow();
        myLocation=location;
        emit(PickImageSuccess());
      }
      catch(e){
        emit(PickImageFailure(e.toString()));
      }


    } catch (e) {
      // في حالة حدوث خطأ، يمكنك اختيار جعل المتغير null
      myImageFile = null;
      emit(PickImageFailure('حدث خطأ أثناء التقاط الصورة'));
    }




  }











  Future<void> addPrize(ClientEntity clientEntity,PlatformFile image, int index)async{
    emit(AddPrizeLoading());
    var storage=await uploadImageRepo.uploadImage(image);
    storage.fold(

        (l){
          emit(AddPrizeFailure('هناك مشكلة في الانترنت من فضلك اعد المحاولة'));
        }
        ,(r) async{
          clientEntity.prizes![index].image=r;
          clientEntity.prizes![index].longitude=myLocation!.longitude.toString();
          clientEntity.prizes![index].latitude=myLocation!.latitude.toString();
      var result=await updateClientRepo.updateClient(clientEntity);
      result.fold((failure) {
        emit(AddPrizeFailure(failure.message));
      }, (success) {
        emit(AddPrizeSuccess());
      });

    }
    );

  }

}
