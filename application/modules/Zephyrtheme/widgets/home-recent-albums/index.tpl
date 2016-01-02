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

($this->home_style == '1' ) ? ($width_forwide = ' width_main') : ($width_forwide = '');
?>

<ul class="home_photos home_recent_albums clearfix<?php echo $width_forwide; ?>">
  <?php foreach( $this->paginator as $item ): ?>
    <li>
      <?php
      preg_match_all('~<img.*?src=["\']+(.*?)["\']+~', $this->itemPhoto($item, ' '), $img_url);
      $img_url = $img_url[1];
      echo '<div class="image" style="background-image: url('.$img_url[0].')">'.$this->htmlLink($item->getHref()).'</div>';
      ?>
      <div class="description">
        <h3 class="title">
          <?php echo $this->htmlLink($item->getHref(), $item->getTitle()); ?>
        </h3>
        <ul class="info">
          <li class="owner">
            <?php
            $owner = $item->getOwner();
            echo $this->htmlLink($owner->getHref(), $this->itemPhoto($item->getOwner(), 'thumb.icon').$owner->getTitle());
            ?>
          </li>
          <li class="stats">
            <?php echo $this->timestamp($item->{$this->recentCol}); ?>
          </li>
        </ul>
      </div>
    </li>
  <?php endforeach; ?>
</ul>
