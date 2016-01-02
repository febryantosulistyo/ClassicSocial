<?php

class Zephyrtheme_AdminStylingController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
    ->getNavigation('zephyr_admin_main', array(), 'zephyr_admin_main_styling');
  
    // Get available files
    $image_options = array('' => 'No image / Default');
    $imageExtensions = array('gif', 'jpg', 'jpeg', 'png');
    $it = new DirectoryIterator(APPLICATION_PATH . '/public/admin/');
    foreach( $it as $file ) {
      if( $file->isDot() || !$file->isFile() ) continue;
      $basename = basename($file->getFilename());
      if( !($pos = strrpos($basename, '.')) ) continue;
      $ext = strtolower(ltrim(substr($basename, $pos), '.'));
      if( !in_array($ext, $imageExtensions) ) continue;
      $image_options['public/admin/' . $basename] = $basename;
    }
	
	// Form
	$this->view->form = $form = new Zephyrtheme_Form_Admin_Styling();
	$form->header_img->addMultiOptions($image_options);
	$form->footer_img->addMultiOptions($image_options);
	$form->body_img->addMultiOptions($image_options);
	
    $settings = Engine_Api::_()->getApi('settings', 'core');

    // Populate form
    $form->populate($settings->getFlatSetting('zephyr', array()));

    if (!$this->getRequest()->isPost()) return false;
    if (!$form->isValid($this->getRequest()->getPost())) return false;

    // Process form
    $values = $form->getValues();
    $settings->zephyr = $values;

    // Save as constants
    $zephyr_api = Engine_Api::_()->getApi('theme', 'zephyrtheme');
    $zephyr_api->setOptions($values);
	//$zephyr_api->removeOption('zephyr_');

    $form->addNotice('Your changes have been saved.');
  }
}