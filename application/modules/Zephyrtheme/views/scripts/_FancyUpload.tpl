<?php
$this->headScript()
->appendFile($this->baseUrl() . '/externals/fancyupload/Swiff.Uploader.js')
->appendFile($this->baseUrl() . '/externals/fancyupload/Fx.ProgressBar.js')
->appendFile($this->baseUrl() . '/externals/fancyupload/FancyUpload2.js');
$this->headLink()
->appendStylesheet($this->baseUrl() . '/externals/fancyupload/fancyupload.css');
$this->headTranslate(array(
'Overall Progress ({total})', 'File Progress', 'Uploading "{name}"',
'Upload: {bytesLoaded} with {rate}, {timeRemaining} remaining.', '{name}',
'Remove', 'Click to remove this entry.', 'Upload failed',
'{name} already added.',
'{name} ({size}) is too small, the minimal file size is {fileSizeMin}.',
'{name} ({size}) is too big, the maximal file size is {fileSizeMax}.',
'{name} could not be added, amount of {fileListMax} files exceeded.',
'{name} ({size}) is too big, overall filesize of {fileListSizeMax} exceeded.',
'Server returned HTTP-Status <code>#{code}</code>',
'Security error occurred ({text})',
'Error caused a send or load operation to fail ({text})',
));
?>
<?php $settings = Engine_Api::_()->getApi('settings', 'core');?>
<script type="text/javascript">
    var uploadCount = 0;
    var extraData = <?php echo $this->jsonInline($this->data['extradata']); ?>;

    window.addEvent('domready', function() { // wait for the content
                                             // our uploader instance

        var up = new FancyUpload2(window.$('demo-status'), window.$('demo-list'), { // options object
            // we console.log infos, remove that in production!!
            verbose: false,
            multiple: false,
            appendCookieData: true,
        <?php if ($this->data['max_files'] !== false):?>
        fileListMax: <?php echo $this->data['max_files'] ?>,
        <?php endif;?>
        // url is read from the form, so you just have to change one place
        url: window.$('form-upload').action,

            // path to the SWF file
                path: '<?php echo $this->baseUrl() . '/externals/fancyupload/Swiff.Uploader.swf';?>',

            // remove that line to select all files, or edit it, add more items
                typeFilter: {
        <?php echo $this->data['file_types'] ?>
        },

        // this is our browse button, *target* is overlayed with the Flash movie
        target: 'demo-browse',

                data: extraData,

            // graceful degradation, onLoad is only called if all went well with Flash
                onLoad: function() {
            var fallback = window.$('demo-fallback');
            if (fallback == null)
                return;
            window.$('demo-status').removeClass('hide'); // we show the actual UI
            fallback.destroy(); // ... and hide the plain form

            // We relay the interactions with the overlayed flash to the link
            this.target.addEvents({
                click: function() {
                    return false;
                },
                mouseenter: function() {
                    this.addClass('hover');
                },
                mouseleave: function() {
                    this.removeClass('hover');
                    this.blur();
                },
                mousedown: function() {
                    this.focus();
                }
            });



        },

        // Edit the following lines, it is your custom event handling

        /**
         * Is called when files were not added, "files" is an array of invalid File classes.
         *
         * This example creates a list of error elements directly in the file list, which
         * hide on click.
         */
        onSelectFail: function(files) {
            files.each(function(file) {
                new Element('li', {
                    'class': 'validation-error',
                    html: file.validationErrorMessage || file.validationError,
                    title: MooTools.lang.get('FancyUpload', 'removeTitle'),
                    events: {
                        click: function() {
                            this.destroy();
                        }
                    }
                }).inject(this.list, 'top');
            }, this);
            this.list.setStyle('display', 'block');
            var demostatuscurrent = window.$("demo-status-current");

            demostatuscurrent.style.display = "none";
            //  demostatusoverall.style.display = "none";
        },

        onFileStart: function() {
            window.$('demo-browse').style.display = "none";

        },
        onSelectSuccess: function(file) {
            window.$('demo-list').style.display = 'block';

            var demostatuscurrent = window.$("demo-status-current");
            window.$("upload_error").setStyle('display', 'none');
            demostatuscurrent.style.display = "block";
            up.start();
        } ,
        /**
         * This one was directly in FancyUpload2 before, the event makes it
         * easier for you, to add your own response handling (you probably want
         * to send something else than JSON or different items).
         */
        onFileSuccess: function(file, response) {
            var json = new Hash(JSON.decode(response, true) || {});

            if (json.get('status'))
            {
                file.element.addClass('file-success');

                if (json.get('saved'))
                {
                    parent.$('memberprofile_cover').setStyle('background-image', 'url(' + json.get('src') + ')');

                    if (json.get('first_cover'))
                    {
                        var _uploadCover = parent.$('memberprofile_cover_upload');

                        new Element('a', {
                            href: '<?php
                                echo $this->url(array("module" => "zephyrtheme",
                                "controller" => "index", "action" => "delete-cover"), "default") ?>',
                            'class': 'smoothbox',
                            id: 'memberprofile_cover_delete',
                            html: 'Delete Cover',
                        }).inject(_uploadCover, 'after');

                        parent.Smoothbox.bind();
                    }

                    window.$('success_message_box').setStyle('display', 'block');
                    setTimeout(function() {
                        parent.Smoothbox.close();
                    }, 1000 );
                }
            } else {
                file.remove();
                window.$('demo-list').style.display = 'none';
                window.$("demo-status-current").setStyle('display', 'none');
                window.$("upload_error").setStyle('display', 'block').getElement('li').set('text', (json.get('error')) ? json.get('error') : response);
            }
        },

        /**
         * onFail is called when the Flash movie got bashed by some browser plugin
         * like Adblock or Flashblock.
         */
        onFail: function(error) {
            switch (error) {
                case 'hidden': // works after enabling the movie and clicking refresh
                    alert('<?php echo $this->string()->escapeJavascript($this->translate("To enable the embedded uploader, unblock it in your browser and refresh (see Adblock).")) ?>');
                    break;
                case 'blocked': // This no *full* fail, it works after the user clicks the button
                    alert('<?php echo $this->string()->escapeJavascript($this->translate("To enable the embedded uploader, enable the blocked Flash movie (see Flashblock).")) ?>');
                    break;
                case 'empty': // Oh oh, wrong path
                    alert('<?php echo $this->string()->escapeJavascript($this->translate("A required file was not found, please be patient and we'll fix this.")) ?>');
                    break;
                case 'flash': // no flash 9+
                    alert('<?php echo $this->string()->escapeJavascript($this->translate("To enable the embedded uploader, install the latest Adobe Flash plugin.")) ?>');
            }
        }

    });

    });
</script>

<input type="hidden" name="<?php echo $this->name;?>" id="fancyuploadfileids" value ="" />
<fieldset id="demo-fallback">
    <p>
        <?php echo $this->translate("Cover images description");?>
    </p>
</fieldset>

<div id="demo-status" class="hide">
    <fieldset id="fieldset-buttons">
        <button id="demo-browse" type="button"><?php echo $this->translate('Choose image');?></button>
        or
        <a onclick="javascript:parent.Smoothbox.close();" href="javascript:void(0);" id="button_cancel">
        <?php echo $this->translate("cancel"); ?></a>
    </fieldset>
    <div class="demo-status-overall" id="demo-status-overall" style="display: none">
        <div class="overall-title"></div>
        <img src="<?php echo $this->baseUrl() . '/externals/fancyupload/assets/progress-bar/bar.gif';?>" class="progress overall-progress" />
    </div>
    <div class="demo-status-current" id="demo-status-current" style="display: none">
        <div class="current-title"></div>
        <img src="<?php echo $this->baseUrl() . '/externals/fancyupload/assets/progress-bar/bar.gif';?>" class="progress current-progress" />
    </div>
    <div class="current-text"></div>
</div>
<ul id="demo-list"></ul>
<ul class="form-errors" id="upload_error" style="display: none;">
    <li></li>
</ul>