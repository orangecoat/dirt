; Core version
; ------------
; Each makefile should begin by declaring the core version of Drupal that all
; projects should be compatible with.

core = 7.x


; API version
; ------------
; Every makefile needs to declare its Drush Make API version. This version of
; drush make uses API version `2`.

api = 2


; Modules
; --------
projects[admin][version] = 2.0-beta3
projects[admin][type] = "module"
projects[admin][subdir] = "contrib"
projects[ctools][version] = 1.0-rc1
projects[ctools][type] = "module"
projects[ctools][subdir] = "contrib"
projects[context][version] = 3.0-beta1
projects[context][type] = "module"
projects[context][subdir] = "contrib"
projects[date][version] = 2.0-alpha3
projects[date][type] = "module"
projects[date][subdir] = "contrib"
projects[devel][version] = 1.2
projects[devel][type] = "module"
projects[devel][subdir] = "contrib"
projects[email][version] = 1.0-beta1
projects[email][type] = "module"
projects[email][subdir] = "contrib"
projects[link][version] = 1.0-alpha3
projects[link][type] = "module"
projects[link][subdir] = "contrib"
projects[html5_tools][version] = 1.0
projects[html5_tools][type] = "module"
projects[html5_tools][subdir] = "contrib"
projects[imce][version] = 1.4
projects[imce][type] = "module"
projects[imce][subdir] = "contrib"
projects[captcha][version] = 1.0-alpha3
projects[captcha][type] = "module"
projects[captcha][subdir] = "contrib"
projects[elements][version] = 1.2
projects[elements][type] = "module"
projects[elements][subdir] = "contrib"
projects[filefield_paths][version] = 1.0-alpha1
projects[filefield_paths][type] = "module"
projects[filefield_paths][subdir] = "contrib"
projects[globalredirect][version] = 1.3
projects[globalredirect][type] = "module"
projects[globalredirect][subdir] = "contrib"
projects[imce_wysiwyg][version] = 1.x-dev
projects[imce_wysiwyg][type] = "module"
projects[imce_wysiwyg][subdir] = "contrib"
projects[logintoboggan][version] = 1.2
projects[logintoboggan][type] = "module"
projects[logintoboggan][subdir] = "contrib"
projects[menu_block][version] = 2.2
projects[menu_block][type] = "module"
projects[menu_block][subdir] = "contrib"
projects[nodequeue][version] = 2.0-alpha2
projects[nodequeue][type] = "module"
projects[nodequeue][subdir] = "contrib"
projects[pathauto][version] = 1.0-rc2
projects[pathauto][type] = "module"
projects[pathauto][subdir] = "contrib"
projects[securepages][version] = 1.x-dev
projects[securepages][type] = "module"
projects[securepages][subdir] = "contrib"
projects[strongarm][version] = 2.0-beta2
projects[strongarm][type] = "module"
projects[strongarm][subdir] = "contrib"
projects[token][version] = 1.0-beta3
projects[token][type] = "module"
projects[token][subdir] = "contrib"
projects[transliteration][version] = 3.0-alpha1
projects[transliteration][type] = "module"
projects[transliteration][subdir] = "contrib"
projects[panels][version] = 3.0-alpha3
projects[panels][type] = "module"
projects[panels][subdir] = "contrib"
projects[jquery_update][version] = 2.2
projects[jquery_update][type] = "module"
projects[jquery_update][subdir] = "contrib"
projects[wysiwyg][version] = 2.1
projects[wysiwyg][type] = "module"
projects[wysiwyg][subdir] = "contrib"
projects[views][version] = 3.0-rc1
projects[views][type] = "module"
projects[views][subdir] = "contrib"
projects[webform][version] = 3.11
projects[webform][type] = "module"
projects[webform][subdir] = "contrib"
projects[xmlsitemap][version] = 2.0-beta3
projects[xmlsitemap][type] = "module"
projects[xmlsitemap][subdir] = "contrib"
projects[redirect][version] = 1.0-beta3
projects[redirect][type] = module
projects[redirect][subdir] = contrib
projects[metatags_quick][version] = 2.0
projects[metatags_quick][type] = module
projects[metatags_quick][subdir] = contrib
projects[labjs][version] = 1.1
projects[labjs][type] = module
projects[labjs][subdir] = contrib
projects[spamspan][version] = 1.1-beta1
projects[spamspan][type] = module
projects[spamspan][subdir] = contrib
projects[textcaptcha][version] = 1.x-dev
projects[textcaptcha][type] = module
projects[textcaptcha][subdir] = contrib


; Themes
; --------
projects[boron][version] = 1.1
projects[asarko][type] = "theme"
projects[asarko][download][type] = "git"
projects[asarko][download][url] = "git://github.com/rickharris/asarko.git"
projects[skeleton][type] = "theme"
projects[skeleton][download][type] = "git"
projects[skeleton][download][url] = "git://github.com/orangecoat/skeleton.git"


; Libraries
; ---------
libraries[labjs][download][type] = file
libraries[labjs][download][url] = http://labjs.com/releases/LABjs-2.0.1.tar.gz
libraries[tinymce][download][type] = file
libraries[tinymce][download][url] = https://github.com/downloads/tinymce/tinymce/tinymce_3.4.4.zip
