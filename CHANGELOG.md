## ? - Release 0.5.0
* Added a 'raw' view for clips - #24
* Added a 'copy' button for clips
* Added 'includes' partial to inject HTML & javascript from host application - #23
* Added support for wildcard searching using \* - #20
* Various bug fixes.

## 2012-11-26 - Release 0.4.1
* Made url_hash the model id to fix issue #16
   * Consolidated migrations
   * Warning, this may break existing databases created before v0.4.1
* Changed method of finding version number on the 'About' page
* Fixed rss feed image url

## 2102-11-21 - Release 0.4.0
* Added ATOM feeds for public clips.
* Added optional user integration features
    * includes clipster:install generator that copies an initializer template to parent app
    * gives ability to configure the user model, as well as the user display attribute
* Added help tooltips on Create page.
* Added version number on 'About' page.
* Various bug fixes.

## 2012-11-08 - Release 0.3.0
* Added expiring clips.
* Added pagination in 'Recent Clips' list.
* Added and an 'About' page.
* Rearranged items on create and view pages.
* Added 'required' attribute to create clip form.

## 2012-10-15 - Release 0.2.1
* converted tests to rspec and added first test
* added travis-ci file

## 2012-10-12 - Release 0.2.0
* added search functionality with search form in nav bar
* added list by language routes and table. table shown in list and search results views.

## 2012-10-07 - Release 0.1.1
* Hotfixed README.rdoc to add missing deployment step

## 2012-10-07 - Release 0.1.0
* Released version 0.1.0 to RubyGems
* contains full clipster functionality
