import 'dart:typed_data';

import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/repos/update_client_repo.dart';
import 'package:bingo_with_coca/core/repos/upload_image_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(PickImageSuccess());


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
