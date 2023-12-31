import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign in
  signInWithGoogle() async {
    // mở cửa sổ tương tác để User chọn tài khoản Google và Login. Trả về thằng GoogleSignInAccount chứa
    // thông tin về tài khoản Google của User đã chọn
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Sau khi User đã chọn tài khoản đăng nhập, lấy thông tin xác thực từ request bằng cách
    // gọi ‘.authentication’ trên GoogleSignInAccount
    // thông tin xác thực bao gồm accessToken và idToken
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // tạo credential của GoogleAuthProvider bằng cách truyền vào accessToken và idToken lấy từ bước trên
    // credential được sử dụng để xác thực người dùng với FireBase Authentication
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // sử dụng credential để đăng nhập vào FirebaseAuthentication bằng cách gọi signInWithCredential
    // trả về một User
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
