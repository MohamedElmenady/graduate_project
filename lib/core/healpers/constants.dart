//import 'package:graduate_project/feature/profile/data/userModel.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

bool isLoggedInUser = false;
const String baseUrlLogin = 'http://192.168.1.5:5237/api/Auth/login';
const String baseUrlRegister = 'http://192.168.1.5:5237/api/Auth/register';
const String baseUrlProfile = 'http://192.168.1.5:5237/api/UserProfile';
const String baseUrlUpdateProfile =
    'http://192.168.1.5:5237/api/UserProfile/update';
const String baseUrlSpeciality = 'http://192.168.1.5:5237/api/Specialization';
const String baseUrlHomePage = 'http://192.168.1.5:5237/api/HomePage';
const String baseUrlBooking = 'http://192.168.1.5:5237/api/Appointment/book';
const String baseUrlPayment = 'http://192.168.1.5:5237/api/payment';
const String baseUrlEvent =
    'http://192.168.1.5:5237/api/Appointment/my?Status=upcoming';
const String baseUrl = 'http://192.168.1.5:5237/api';
const String baseUrlConfirmEmail =
    'http://192.168.1.5:5237/api/Auth/confirm-email';
//String name=UserMod;
String? token;
String? name;
String? appointment1Id;
/*const String t =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMjQ4MjZmNS03YWRhLTQ5NGQtN2Y1Ni0wOGRkYWYzMmU0YjQiLCJlbWFpbCI6Im1vNEBnbWFpbC5jb20iLCJ1c2VybmFtZSI6Ik1vaGFtZWQgUmVkYSIsImp0aSI6ImEyN2NlMTA1LTFkZGItNGIzYi04YTQyLWZjZTJjN2JkMjkzNCIsImV4cCI6MTc1MDk3OTAxNiwiaXNzIjoiaHR0cDovLzAuMC4wLjA6NTIzNyIsImF1ZCI6Imh0dHA6Ly8wLjAuMC4wOjUyMzcifQ.XLKJdaaE6FmYcCPDU2EHdBYDFi-1KehaxEwPug2dRb4";
*/
Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

String userType = decodedToken[
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"];
