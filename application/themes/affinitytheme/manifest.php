<?php return array (
  'package' => 
  array (
    'title' => 'Affinitytheme',
    'thumb' => 'affinity.jpg',
    'author' => 'Jackson',
    'description' => '',
    'type' => 'theme',
    'name' => 'affinitytheme',
    'version' => NULL,
    'path' => 'application/themes/affinitytheme',
    'repository' => 'socialengineforum.com',
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'remove',
    ),
    'callback' => 
    array (
      'class' => 'Engine_Package_Installer_Theme',
    ),
    'directories' => 
    array (
      0 => 'application/themes/affinitytheme',
    ),
  ),
  'files' => 
  array (
    0 => 'theme.css',
    1 => 'constants.css',
  ),
); ?>