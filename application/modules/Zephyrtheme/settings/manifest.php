<?php return array (
  'package' => array (
    'type' => 'module',
    'name' => 'zephyrtheme',
    'version' => '1.2.5',
    'path' => 'application/modules/Zephyrtheme',
    'title' => 'Zephyr Theme',
    'description' => 'Options for Zephyr Theme',
    'author' => '<a href="http://socialenginehelp.com/" target="_blank">socialenginehelp</a>',
	'changeLog' => 'settings/changelog.php',
    'callback' => array (
      'path' => 'application/modules/Zephyrtheme/settings/install.php',
      'class' => 'Zephyrtheme_Installer',
      'priority' => 100
    ),
    'actions' => array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'enable',
      4 => 'disable'
    ),
    'directories' => array (
      0 => 'application/modules/Zephyrtheme',
      1 => 'application/themes/zephyr',
    ),
    'files' => array (
      0 => 'application/languages/en/zephyrtheme.csv',
    )
  ),  
  // Items ---------------------------------------------------------------------
  'items' => array(
    'zephyrtheme_album',
    'zephyrtheme_photo'
  ),
  // Routes --------------------------------------------------------------------
  'routes' => array()
) ?>