import 'package:edu_master/Onboarding/model/model.dart';

const String pathimage = "assets/image/";

List<Onboarddingmodel> Onboarddinlist = [
  Onboarddingmodel(
    title: "مستقبلك يبدأ من هنا",
    body:
        "استعد لرحلة تعليمية فريدة، صممت خصيصًا لمساعدتك على تحقيق أقصى إمكانياتك الأكاديمية والتفوق في دراستك.",
    image: "${pathimage}page_one.png",
  ),

  Onboarddingmodel(
    title: "خطوات واضحة نحو هدفك",
    body:
        "تتبع تقدمك لحظة بلحظة، حدد نقاط قوتك وضعفك، وضع خطة دراسية مخصصة تضمن لك الوصول إلى أهدافك بثقة.",
    image: "${pathimage}page_three.png",
  ),
  Onboarddingmodel(
    title: "تعلّم بذكاء، ليس بجهد",
    body:
        "نقدم لك شروحات مبسطة، تدريبات تفاعلية، ومصادر تعليمية شاملة تجعل الفهم أسهل والتعلم أكثر متعة وفعالي",
    image: "${pathimage}page_tow.png",
  ),
];
