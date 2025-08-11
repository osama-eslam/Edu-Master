import 'teacher_model.dart';

const String basePath = "assets/image/Teachers_image/";

List<TeacherModel> teachersList = [
  TeacherModel(
    name: "مستر لطفي",
    subject: "الرياضيات",
    info: "المهندس لطفي زهران، معلم أول رياضيات.",
    image: "${basePath}Mr_Lotfy.png",
  ),
  TeacherModel(
    name: "مستر محمد صلاح",
    subject: "اللغة العربية",
    info: "من أشهر وأفضل مدرسي اللغة العربية في الوطن العربي.",
    image: "${basePath}mo_sala.png",
  ),
  TeacherModel(
    name: "مس مي",
    subject: "اللغة الإنجليزية",
    info: "خبرة تزيد عن 15 عامًا في تدريس اللغة الإنجليزية.",
    image: "${basePath}Miss_me.png",
  ),
  TeacherModel(
    name: "مستر خالد صقر",
    subject: "الكيمياء",
    info: "من أشهر وأفضل مدرسي الكيمياء في الوطن العربي.",
    image: "${basePath}Khaled_Saqr.png",
  ),
  TeacherModel(
    name: "مستر أحمد الجوهري",
    subject: "الأحياء",
    info: "من أفضل وأشهر مدرسي الأحياء.",
    image: "${basePath}Ahmed_Al_Gawhary.png",
  ),
  TeacherModel(
    name: "مستر عبد المعبود",
    subject: "الفيزياء",
    info: "من أفضل وأشهر مدرسي الفيزياء.",
    image: "${basePath}Abdul_Maboud.png",
  ),
];
