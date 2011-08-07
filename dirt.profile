<?php

// We customize the standard profile's install rather than call it directly
// because it's module dependencies are different, so things like RDF mapping
// would throw errors should we try to call standard_install()
function dirt_install() {
  // Add text formats.
  $full_html_format = array(
    'format' => 'full_html',
    'name' => 'Full HTML',
    'weight' => 0,
    'filters' => array(
      // URL filter.
      'filter_url' => array(
        'weight' => 0,
        'status' => 1,
      ),
      // Email obfuscator
      'spamspan' => array(
        'weight' => 2,
        'status' => 1,
      ),
      // HTML corrector filter.
      'filter_htmlcorrector' => array(
        'weight' => 10,
        'status' => 1,
      ),
      // Pathologic
      'pathologic' => array(
        'weight' => 50,
        'status' => 1,
      ),
    ),
  );
  $full_html_format = (object) $full_html_format;
  filter_format_save($full_html_format);

  $filtered_html_format = array(
    'format' => 'filtered_html',
    'name' => 'Filtered HTML',
    'weight' => 1,
    'filters' => array(
      // URL filter.
      'filter_url' => array(
        'weight' => 0,
        'status' => 1,
      ),
      // HTML filter.
      'filter_html' => array(
        'weight' => 1,
        'status' => 1,
      ),
      // Line break filter.
      'filter_autop' => array(
        'weight' => 2,
        'status' => 1,
      ),
      // Email obfuscator
      'spamspan' => array(
        'weight' => 3,
        'status' => 1,
      ),
      // HTML corrector filter.
      'filter_htmlcorrector' => array(
        'weight' => 10,
        'status' => 1,
      ),
      // Pathologic
      'pathologic' => array(
        'weight' => 50,
        'status' => 1,
      ),
    ),
  );
  $filtered_html_format = (object) $filtered_html_format;
  filter_format_save($filtered_html_format);

  drupal_set_message("Filtered HTML and Full HTML filter formats have been configured to use Pathologic. If this site is in a subdirectory, you should put `/[subdirectory]/` and `/` as options, in that order, the the Pathologic configuration of both filter formats.", "status");

  // Enable some standard blocks.
  $default_theme = variable_get('theme_default', 'bartik');
  $admin_theme = 'seven';

  // Insert default pre-defined node types into the database. For a complete
  // list of available node type attributes, refer to the node type API
  // documentation at: http://api.drupal.org/api/HEAD/function/hook_node_info.
  $types = array(
    array(
      'type' => 'page',
      'name' => st('Basic page'),
      'base' => 'node_content',
      'description' => st("Use <em>basic pages</em> for your static content, such as an 'About us' page."),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
    array(
      'type' => 'article',
      'name' => st('Article'),
      'base' => 'node_content',
      'description' => st('Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.'),
      'custom' => 1,
      'modified' => 1,
      'locked' => 0,
    ),
  );

  foreach ($types as $type) {
    $type = node_type_set_defaults($type);
    node_type_save($type);
    node_add_body_field($type);
  }

  // Default "Basic page" to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));
  variable_set('comment_page', COMMENT_NODE_HIDDEN);

  // Don't display date and author information for "Basic page" nodes by default.
  variable_set('node_submitted_page', FALSE);

  // Enable user picture support and set the default to a square thumbnail option.
  variable_set('user_pictures', '1');
  variable_set('user_picture_dimensions', '1024x1024');
  variable_set('user_picture_file_size', '800');
  variable_set('user_picture_style', 'thumbnail');

  // Only allow admins to create new user accounts
  variable_set('user_register', USER_REGISTER_ADMINISTRATORS_ONLY);

  // Enable default permissions for system roles.
  $filtered_html_permission = filter_permission_name($filtered_html_format);
  user_role_grant_permissions(DRUPAL_ANONYMOUS_RID, array('access content', $filtered_html_permission));
  user_role_grant_permissions(DRUPAL_AUTHENTICATED_RID, array('access content', $filtered_html_permission));

  // Create a default role for site administrators, with all available permissions assigned.
  $admin_role = new stdClass();
  $admin_role->name = 'administrator';
  $admin_role->weight = 2;
  user_role_save($admin_role);
  user_role_grant_permissions($admin_role->rid, array_keys(module_invoke_all('permission')));
  // Set this as the administrator role.
  variable_set('user_admin_role', $admin_role->rid);

  // Assign user 1 the "administrator" role.
  db_insert('users_roles')
    ->fields(array('uid' => 1, 'rid' => $admin_role->rid))
    ->execute();

  // Create a Home link in the main menu.
  $item = array(
    'link_title' => st('Home'),
    'link_path' => '<front>',
    'menu_name' => 'main-menu',
  );
  menu_link_save($item);

  // Update the menu router information.
  menu_rebuild();

  // Enable the admin theme.
  db_update('system')
    ->fields(array('status' => 1))
    ->condition('type', 'theme')
    ->condition('name', 'seven')
    ->execute();
  variable_set('admin_theme', 'seven');
  variable_set('node_admin_theme', '1');

  // Securepages
  if (securepages_test()) {
    variable_set('securepages_enable', 1);
  }
  else {
    drupal_set_message("Securepages not enabled because this installation didn't pass the test. You may need to manually configure securepages from the admin UI", "warning");
  }
  variable_set('securepages_switch', TRUE);
  variable_set('securepages_secure', 1); // 1 = Only secure securepages_pages
  variable_set('securepages_pages', SECUREPAGES_PAGES);
  variable_set('securepages_ignore', SECUREPAGES_IGNORE);

  // Set up filesystem
  variable_set('file_public_path', 'files');
  variable_set('file_temporary_path', '/tmp');

  // WYSIWYG Configuration
  // Full HTML
  db_insert('wysiwyg')
    ->fields(array('format', 'editor', 'settings'))
    ->values(array('full_html', 'tinymce', serialize(array(
      'buttons' => array(
        'default' => array(
          'bold' => 1,
          'italic' => 1,
          'bullist' => 1,
          'numlist' => 1,
          'link' => 1,
          'unlink' => 1,
          'image' => 1,
          'blockquote' => 1,
        ),
        'font' => array(
          'formatselect' => 1,
        ),
        'inlinepopups' => array(
          'inlinepopups' => 1,
        ),
        'imce' => array(
          'imce' => 1,
        ),
        'drupal' => array(
          'break' => 1,
        ),
      ),
      'block_formats' => "p,address,pre,h2,h3,h4,h5,h6,div",
    ))))
    ->execute();

  // Add some helpful elements to views options
  variable_set('views_field_rewrite_elements', array(
    '' => t(' - Default - '),
    '0' => t('- None -'),
    'div' => t('Div'),
    'span' => t('Span'),
    'h1' => t('Heading 1'),
    'h2' => t('Heading 2'),
    'h3' => t('Heading 3'),
    'h4' => t('Heading 4'),
    'h5' => t('Heading 5'),
    'h6' => t('Heading 6'),
    'p' => t('Paragraph'),
    'blockquote' => t('Blockquote'),
    'article' => t('Article'),
    'aside' => t('Aside'),
    'footer' => t('Footer'),
    'header' => t('Header'),
    'menu' => t('Menu'),
    'nav' => t('Nav'),
    'time' => t('Time'),
    'figure' => t('Figure'),
    'strong' => t('Strong'),
    'em' => t('Emphasized'),
  ));

  // Logintoboggan enhancements
  variable_set('logintoboggan_login_successful_message', TRUE);
  variable_set('logintoboggan_minimum_password_length', 8);
  // Show login page on 403 Access Denied pages
  variable_set('site_403', 'toboggan/denied');

  // Menu block config
  variable_set('menu_block_suppress_core', TRUE);
  variable_set('menu_block_menu_order', array('main-menu' => ''));

  // Captcha config
  variable_set('captcha_administration_mode', TRUE);
  variable_set('captcha_default_challenge', 'textcaptcha/Text Captcha');
  // Wait until final installation process via the shovel's shell script
  // to prompt the user for the textcaptcha API key so we don't have to store
  // it in the open here
  variable_set('textcaptcha_cache_limit', 2); // 2 actually means 20... weird.

  // Pathauto node settings
  variable_set('pathauto_node_page_pattern', '[node:title]');
  variable_set('pathauto_node_webform_pattern', '[node:title]');
  variable_set('pathauto_node_pattern', '[node:content-type]/[node:title]');
  // Pathauto puncuation settings (0 = Remove, 1 = Replace, 2 = Do Nothing)
  variable_set('pathauto_punctuation_underscore', 1);
  variable_set('pathauto_punctuation_hyphen', 1);
  // Pathauto ignored words - set to none
  variable_set('pathauto_ignore_words', '');

}
