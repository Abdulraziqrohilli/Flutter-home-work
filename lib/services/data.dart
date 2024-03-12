import 'package:get/utils.dart';
import 'package:hurriyat/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "images/business.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Afghanistan";
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "World";
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Asia".tr;
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Politics";
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Development";
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Islam & Culture".tr;
  categoryModel.image = "images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Technology";
  categoryModel.image = "images/general.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Health";
  categoryModel.image = "images/health.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "images/sport.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
