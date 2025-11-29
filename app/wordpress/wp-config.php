<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'admin' );
define( 'DB_PASSWORD', 'supersecret' );
define( 'DB_HOST', 'wordpress-project-db.cjg2us4ekocm.eu-central-1.rds.amazonaws.com:3306' );

define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( !defined('ABSPATH') )
    define('ABSPATH', __DIR__ . '/');
require_once ABSPATH . 'wp-settings.php';
