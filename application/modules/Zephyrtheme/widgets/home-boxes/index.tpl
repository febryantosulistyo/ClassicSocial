<?php
/**
 * Pixythemes
 *
 * @category   Application_Extensions
 * @package    ZephyrTheme
 * @copyright  Pixythemes
 * @license    http://www.pixythemes.com/
 * @author     Pixythemes
 */

// Box 1
$home_ico_one = $this->home_ico_one;
$home_ico_onelink = $this->home_icoone_link;
// Box 2
$home_ico_two = $this->home_ico_two;
$home_ico_twolink = $this->home_icotwo_link;
// Box 3
$home_ico_three = $this->home_ico_three;
$home_ico_threelink = $this->home_icothree_link;
// Box 4
$home_ico_four = $this->home_ico_four;
$home_ico_fourlink = $this->home_icofour_link;

if($this->home_icos == 0){$homeboxesclass = 'onecol';}
elseif($this->home_icos == 1){$homeboxesclass = 'twocol';}
elseif($this->home_icos == 2){$homeboxesclass = 'threecol';}
elseif($this->home_icos == 3){$homeboxesclass = 'fourcol';};

?>

<div class="layout_theme_home_boxes width_main"><div class="home_boxes clearfix <?php echo $homeboxesclass; ?>">
  <div class="home_box home_box_one"><div>
    <a href="<?php echo ($home_ico_onelink) ? $home_ico_onelink : 'javascript:void(0)'; ?>">
      <?php if($this->home_icosimgs != 3): ?>
      <img src="<?php echo ($home_ico_one) ? $home_ico_one : $this->baseUrl('application/modules/Zephyrtheme/externals/images/home_ico_1.png'); ?>" alt="" />
      <?php endif; ?>
      
      <?php if($this->home_icosimgs != 2): ?><h3><?php echo $this->translate('Meet'); ?></h3><?php endif; ?>
      <?php if($this->home_icosimgs != 1): ?><div><?php echo $this->translate('Duis vitae libero et risus volutpat dignissim non faucibus lacus.'); ?></div><?php endif; ?>
    </a>
  </div></div>
  
  <?php if($this->home_icos == 1 || $this->home_icos == 2 || $this->home_icos == 3 ): ?>
  <div class="home_box home_box_two"><div>
    <a href="<?php echo ($home_ico_twolink) ? $home_ico_twolink : 'javascript:void(0)'; ?>">
      <?php if($this->home_icosimgs != 3): ?>
      <img src="<?php echo ($home_ico_two) ? $home_ico_two : $this->baseUrl('application/modules/Zephyrtheme/externals/images/home_ico_2.png'); ?>" alt="" />
      <?php endif; ?>
      
      <?php if($this->home_icosimgs != 2): ?><h3><?php echo $this->translate('Discover'); ?></h3><?php endif; ?>
      <?php if($this->home_icosimgs != 1): ?><div><?php echo $this->translate('Etiam metus tortor, viverra eu orci sit amet, placerat congue magna.'); ?></div><?php endif; ?>
    </a>
  </div></div>
  <?php endif; ?>
  
  <?php if($this->home_icos == 2 || $this->home_icos == 3 ): ?>
  <div class="home_box home_box_three"><div>
    <a href="<?php echo ($home_ico_threelink) ? $home_ico_threelink : 'javascript:void(0)'; ?>">
      <?php if($this->home_icosimgs != 3): ?>
      <img src="<?php echo ($home_ico_three) ? $home_ico_three : $this->baseUrl('application/modules/Zephyrtheme/externals/images/home_ico_3.png'); ?>" alt="" />
      <?php endif; ?>
      
      <?php if($this->home_icosimgs != 2): ?><h3><?php echo $this->translate('Share It'); ?></h3><?php endif; ?>
      <?php if($this->home_icosimgs != 1): ?><div><?php echo $this->translate('Proin posuere tellus vel odio dapibus, a fringilla magna lacinia.'); ?></div><?php endif; ?>
    </a>
  </div></div>
  <?php endif; ?>
  
  <?php if($this->home_icos == 3 ): ?>
  <div class="home_box home_box_four"><div>
    <a href="<?php echo ($home_ico_fourlink) ? $home_ico_fourlink : 'javascript:void(0)'; ?>">
      <?php if($this->home_icosimgs != 3): ?>
      <img src="<?php echo ($home_ico_four) ? $home_ico_four : $this->baseUrl('application/modules/Zephyrtheme/externals/images/home_ico_4.png'); ?>" alt="" />
      <?php endif; ?>
      
      <?php if($this->home_icosimgs != 2): ?><h3><?php echo $this->translate('Do it'); ?></h3><?php endif; ?>
      <?php if($this->home_icosimgs != 1): ?><div><?php echo $this->translate('Sed turpis metus, accumsan sit amet suscipit sed, blandit vitae dui.'); ?></div><?php endif; ?>
    </a>
  </div></div>
  <?php endif; ?>
</div></div>