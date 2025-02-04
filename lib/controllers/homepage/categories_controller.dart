import 'package:afrahdz/core/services/categorie_service.dart';
import 'package:afrahdz/data/models/categorie.dart';
import 'package:get/get.dart';

class CategorieController extends GetxController {
  final CategorieService categorieService = CategorieService();

  // Observable list of categories
  final categories = <CategorieModel>[].obs;

  // Observable loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller is initialized
  }

  // Fetch categories
  Future<void> fetchCategories() async {
    isLoading(true);
    try {
      final fetchedCategories = await categorieService.fetchAllCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de récupérer les catégories');
    } finally {
      isLoading(false);
    }
  }
}