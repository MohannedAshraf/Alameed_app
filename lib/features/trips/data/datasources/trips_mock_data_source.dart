import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/trip_entity.dart';

/// MOCKED for now — لستة ثابتة. استبدلها بـ DioClient() call حقيقي لـ
/// ApiEndpoints.trips لما الباك اند يجهز؛ الـ repository فوقها مش
/// هيحتاج يتغيّر.
class TripsMockDataSource {
  List<TripEntity> getAllTrips() => _trips;

  static final List<TripEntity> _trips = [
    TripEntity(
      id: '1',
      title: 'الأقصر وأسوان',
      location: 'الأقصر، مصر',
      price: 'يبدأ من 2500 جنيه',
      imagePath: AppImages.logo,
      duration: '4 أيام / 3 ليالي',
      rating: 4.7,
      description:
          'رحلة سياحية كاملة بين الأقصر وأسوان، تشمل زيارة معبد الكرنك ووادي الملوك ومعبد أبو سمبل، مع إقامة فندقية ومرشد سياحي مرخص طوال الرحلة.',
      included: [
        'إقامة فندقية',
        'وجبات الإفطار',
        'مرشد سياحي مرخص',
        'مواصلات داخلية',
      ],
      notIncluded: ['تذاكر الطيران', 'المصاريف الشخصية', 'الإكراميات'],
    ),
    TripEntity(
      id: '2',
      title: 'شرم الشيخ',
      location: 'جنوب سيناء، مصر',
      price: 'يبدأ من 3200 جنيه',
      imagePath: AppImages.logo,
      duration: '3 أيام / 2 ليلة',
      rating: 4.5,
      description:
          'إجازة استجمام على البحر الأحمر، تشمل إقامة في منتجع 5 نجوم ورحلة غطس وجولة سفاري في الصحراء.',
      included: ['إقامة منتجع 5 نجوم', 'رحلة غطس', 'جولة سفاري', 'إفطار وعشاء'],
      notIncluded: ['تذاكر الطيران', 'مشروبات إضافية'],
    ),
    TripEntity(
      id: '3',
      title: 'سيوة',
      location: 'مطروح، مصر',
      price: 'يبدأ من 1800 جنيه',
      imagePath: AppImages.logo,
      duration: '2 يوم / ليلة',
      rating: 4.8,
      description:
          'رحلة لواحة سيوة، تشمل زيارة عين كليوباترا وجبل الموتى ومعبد آمون، مع إقامة في إيكولودج تقليدي.',
      included: ['إقامة إيكولودج', 'جولة بالجيب', 'مرشد محلي'],
      notIncluded: ['المواصلات من وإلى القاهرة', 'المصاريف الشخصية'],
    ),
    TripEntity(
      id: '4',
      title: 'الجونة',
      location: 'البحر الأحمر، مصر',
      price: 'يبدأ من 2900 جنيه',
      imagePath: AppImages.logo,
      duration: '3 أيام / 2 ليلة',
      rating: 4.6,
      description:
          'إجازة في الجونة، تشمل جولة باللاجون ورحلة بحرية ووقت حر على الشاطئ.',
      included: ['إقامة فندقية', 'جولة باللاجون', 'إفطار يومي'],
      notIncluded: ['تذاكر الطيران', 'الأنشطة الإضافية'],
    ),
    TripEntity(
      id: '5',
      title: 'القاهرة التاريخية',
      location: 'القاهرة، مصر',
      price: 'يبدأ من 900 جنيه',
      imagePath: AppImages.logo,
      duration: 'يوم واحد',
      rating: 4.4,
      description:
          'جولة ليوم واحد في القاهرة القديمة، تشمل الأهرامات وأبو الهول والمتحف المصري.',
      included: ['مواصلات', 'تذاكر الدخول', 'مرشد سياحي'],
      notIncluded: ['الغداء', 'المصاريف الشخصية'],
    ),
    TripEntity(
      id: '6',
      title: 'دهب',
      location: 'جنوب سيناء، مصر',
      price: 'يبدأ من 2100 جنيه',
      imagePath: AppImages.logo,
      duration: '3 أيام / 2 ليلة',
      rating: 4.9,
      description:
          'إجازة هادئة في دهب، تشمل غطس في البلو هول وجلسة تصوير على الشاطئ وبدوي كامب.',
      included: ['إقامة', 'رحلة غطس', 'عشاء بدوي'],
      notIncluded: ['تذاكر الطيران', 'معدات الغطس الإضافية'],
    ),
  ];
}
