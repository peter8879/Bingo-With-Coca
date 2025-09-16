
import 'package:bingo_with_coca/core/repos/upload_image_repo.dart';
import 'package:dartz/dartz.dart';

import '../cubits/errors/faliures.dart';
import '../services/storage_service.dart';
import '../utils/backend_end_points.dart';

class UploadImageRepoImpl implements UploadImageRepo
{
  StorageService storageService;
  UploadImageRepoImpl(this.storageService);
  @override
  Future<Either<Failure, String>> uploadImage(image) async{
  try{
    var result=await storageService.uploadFile(file: image, path: BackendEndPoints.uploadImage);
    return Right(result);
  }
  catch(e){
    return Left(ServerFailure(e.toString()));
  }
  }
  
}