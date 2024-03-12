import 'package:hurriyat/models/language_model.dart';

List<LangugaeModel> getLanguageCategoryId() {
  List<LangugaeModel> languagecategory = [];
  LangugaeModel languagecategoryModel = new LangugaeModel();

  languagecategoryModel.name = "English";
  languagecategoryModel.id = 1;
  languagecategory.add(languagecategoryModel);
  languagecategoryModel = new LangugaeModel();
    languagecategoryModel.name = "Pashto";
  languagecategoryModel.id = 2;
  languagecategory.add(languagecategoryModel);
  languagecategoryModel = new LangugaeModel();
    languagecategoryModel.name = "Dari";
  languagecategoryModel.id = 3;
  languagecategory.add(languagecategoryModel);
  languagecategoryModel = new LangugaeModel();
    languagecategoryModel.name = "Arabic";
  languagecategoryModel.id = 4;
  languagecategory.add(languagecategoryModel);
  languagecategoryModel = new LangugaeModel();
  return languagecategory;
}
