import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care/models/all_post.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepo _postRepo;
  final UserRepository _userRepository;
  // late final StreamSubscription<Post?> _postSubscription;

  final _postsController = StreamController<List<Post>>();
  Stream<List<Post>> get posts => _postsController.stream;

  PostBloc({required PostRepo postRepo, required UserRepository userRepository})
      : _postRepo = postRepo,
        _userRepository = userRepository,
        super(PostInitial()) {
    List<Post> allPostList = [];
    List<MyUser> allUserList = [];
    List<AllPost> postList = [];
    AllPost post = AllPost.empty;
    //* Get All Post
    on<GetAllPost>((event, emit) async {
      emit(GetAllPostLoading());
      try {
        allPostList = await _postRepo.getAllPost();
        allUserList = await _userRepository.getAllUser();
        // log(allUserList.toString());
        postList = [];

        for (var postElement in allPostList) {
          for (var userElement in allUserList) {
            if (postElement.userId == userElement.id) {
              post = post.copyWith(
                post: postElement,
                user: userElement,
              );
              postList.add(post);
            }
          }
        }
        // log(postList.length.toString());
        postList.sort(
          (a, b) => b.post.postDate.compareTo(a.post.postDate),
        );
        // _postsController.add(allPostList);
        // log(postList.toString());

        emit(GetAllPostSuccess(allPost: postList));
      } catch (e) {
        log(e.toString());
        emit(GetAllPostFailed(errorMsg: e.toString()));
      }
    });

    //* Create Post
    on<CreatePost>((event, emit) async {
      emit(CreatePostLoading());
      try {
        await _postRepo.createPost(event.post, event.image);
        emit(CreatePostSuccess());
      } catch (e) {
        log(e.toString());
        emit(CreatePostFailed(errorMsg: e.toString()));
      }
    });
    //* delete Post
    on<DeletePost>((event, emit) async {
      emit(DeletePostLoading());
      try {
        log('test', name: 'in delete');
        _postRepo.deletePost(event.postId);
        emit(DeletePostSuccess());
      } catch (e) {
        log(e.toString());
        emit(DeletePostFailed(errorMsg: e.toString()));
      }
    });
  }
}
 
//  allPostList = await _postRepo.getAllPost();
//         allUserList = await _userRepository.getAllUser();
//         // log(allUserList.toString());
//         postList = [];

//         for (var postElement in allPostList) {
//           for (var userElement in allUserList) {
//             if (postElement.userId == userElement.id) {
//               post = post.copyWith(
//                 post: postElement,
//                 user: userElement,
//               );
//               postList.add(post);
//             }
//           }
//         }
//         // log(postList.length.toString());
//         postList.sort(
//           (a, b) => b.post.postDate.compareTo(a.post.postDate),
//         );
//         // _postsController.add(allPostList);
//         // log(postList.toString());

//         emit(GetAllPostSuccess(allPost: postList));